--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Map as M (lookup)
import           Data.List (isInfixOf)
import           Data.Monoid ((<>))
import           Control.Monad (liftM)
import           Data.Maybe (fromMaybe)
import           Hakyll
import           System.FilePath.Posix  (takeBaseName,takeDirectory,(</>),splitFileName)
import           Text.Pandoc.Options (def)
--------------------------------------------------------------------------------

main :: IO ()
main = hakyllWith siteConfig $ do

    -- straightforward copying
    match (fromList ["index.html", "404.html", ".htaccess"]) $ do
        route idRoute
        compile copyFileCompiler

    copyDirectory "media/*"
    copyDirectory "media/book_covers/*"
    copyDirectory "js/*"
    copyDirectory "classes/*"
    copyDirectory "fonts/*"

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    -- compile templates
    match "templates/*" $ compile templateCompiler

    -- Static pages

    match (fromList staticPages) $ do
        route niceRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls
            >>= removeIndexHtml

    addStaticDirectory "prose/essays/*"
    addStaticDirectory "etc/*"

    match "biblio/*.bib" $ compile $ biblioCompiler
    match "biblio/*.csl" $ compile $ cslCompiler

    -- Reading lists
    match "reading/**.markdown" $ do
      route   $ setExtension "html"
      compile $ do
        item <- getUnderlying
        bibFile <- liftM (fromMaybe "files.bib") $ getMetadataField item "biblio"
        cslFile <- liftM (fromMaybe "chicago.csl") $ getMetadataField item "csl"
        let compiler = if bibFile /= "" then bibtexCompiler cslFile bibFile else pandocCompiler
        compiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls
        >>= removeIndexHtml

    -- Blog
    match "prose/blog/posts/*" $ do
        route $ metadataRoute niceDateRoute
        compile $ do
          pandocCompiler
          >>= loadAndApplyTemplate "templates/post.html"    postCtx
          >>= loadAndApplyTemplate "templates/default.html" postCtx
          >>= relativizeUrls
          >>= removeIndexHtml
          >>= saveSnapshot "content"

    match "prose/blog/posts/**.jpg" $ do
        route   idRoute
        compile copyFileCompiler

    match "prose/blog/posts/**.png" $ do
        route   idRoute
        compile copyFileCompiler

    -- index functions as an archive, since we simply list all posts there
    match "prose/blog/index.html" $ do
        route idRoute
        compile $ do
            let indexCtx = field "posts" $ \_ -> postList recentFirst

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" postCtx
                >>= relativizeUrls
                >>= removeIndexHtml

    -- Feeds

    makeBlogFeed "prose/blog/atom.xml" renderAtom

    makeBlogFeed "prose/blog/rss.xml" renderRss

--------------------------------------------------------------------------------

bibtexCompiler :: String -> String -> Compiler (Item String)
bibtexCompiler cslFileName bibFileName = do
    csl <- load (fromFilePath $ "" ++ "biblio/" ++ cslFileName)
    bib <- load (fromFilePath $ "" ++ "biblio/" ++ bibFileName)
    liftM writePandoc
        (getResourceBody >>= readPandocBiblio def csl bib)

myIgnoreFile :: FilePath -> Bool
myIgnoreFile ".htaccess" = False
myIgnoreFile path        = ignoreFile defaultConfiguration path

siteConfig :: Configuration
siteConfig = defaultConfiguration { ignoreFile = myIgnoreFile }

makeBlogFeed :: Identifier ->
                (FeedConfiguration -> Context String -> [Item String] -> Compiler (Item String)) ->
                Rules ()
makeBlogFeed feedName renderFunction = create [feedName] $ do
    route idRoute
    compile $ do
        let feedCtx = postCtx <> bodyField "description"
        posts <- fmap (take 10) . recentFirst =<<
                 loadAllSnapshots "prose/blog/posts/*" "content"
        renderFunction myFeedConfiguration feedCtx posts

copyDirectory :: Pattern -> Rules ()
copyDirectory dir = match dir $ do
    route idRoute
    compile copyFileCompiler

addStaticDirectory :: Pattern -> Rules ()
addStaticDirectory matchPattern = match matchPattern $ do
    route $ niceRoute
    compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls
        >>= removeIndexHtml

postCtx :: Context String
postCtx = dateField "date" "%B %e, %Y" <> defaultContext

postList :: ([Item String] -> Compiler [Item String]) -> Compiler String
postList sortFilter = do
    posts   <- sortFilter =<< loadAll "prose/blog/posts/*"
    itemTpl <- loadBody "templates/post-item.html"
    list    <- applyTemplateList itemTpl postCtx posts
    return list

appendExtension :: String -> String -> String
appendExtension extension page = page ++ "." ++ extension

staticPages :: [Identifier]
staticPages = map (fromFilePath . appendExtension "rst")
              ["meta", "prose", "etc", "code", "teaching"]

-- Thanks to: http://yannesposito.com/Scratch/en/blog/Hakyll-setup/
-- replace a foo/bar.md by foo/bar/index.html
-- this way the url looks like: foo/bar in most browsers
niceRoute :: Routes
niceRoute = customRoute $ createIndexRoute where
  createIndexRoute ident =
    takeDirectory p </> takeBaseName p </> "index.html" where
      p = toFilePath ident

-- This is niceRoute but grabs date metadata from the posts
niceDateRoute :: Metadata -> Routes
niceDateRoute md = customRoute $ createIndexRoute where
  createIndexRoute ident =
    takeDirectory p </> baseWithDate </> "index.html" where
      p = toFilePath ident
      baseWithDate = date ++ "-" ++ (takeBaseName p)
      date = fromMaybe "" $ M.lookup "date" md

-- replace url of the form foo/bar/index.html by foo/bar
removeIndexHtml :: Item String -> Compiler (Item String)
removeIndexHtml item = return $ fmap (withUrls removeIndexStr) item

removeIndexStr :: String -> String
removeIndexStr url = case splitFileName url of
    (dir, "index.html") | isLocal dir -> dir
                        | otherwise   -> url
    _                                 -> url
    where isLocal uri = not (isInfixOf "://" uri)

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "Christopher Young: Notes and Queries"
    , feedDescription = "The Blog of Christopher Young"
    , feedAuthorName  = "Christopher Young"
    , feedAuthorEmail = "chris@chrisyoung.net"
    , feedRoot        = "http://chrisyoung.net"
    }

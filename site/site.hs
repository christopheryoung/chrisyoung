--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.List (isInfixOf)
import           Data.Monoid ((<>))
import           Hakyll
import           System.FilePath.Posix  (takeBaseName,takeDirectory,(</>),splitFileName)
--------------------------------------------------------------------------------

main :: IO ()
main = hakyllWith siteConfig $ do

    -- straightforward copying
    match (fromList ["index.html", "404.html", ".htaccess"]) $ do
        route idRoute
        compile copyFileCompiler

    copyDirectory "media/*"
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
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    addStaticDirectory "prose/essays/*"
    addStaticDirectory "etc/*"

    -- Blog

    match "prose/blog/posts/**.jpg" $ do
        route   idRoute
        compile copyFileCompiler

    match "prose/blog/posts/**.png" $ do
        route   idRoute
        compile copyFileCompiler

    match "prose/blog/posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls
            >>= saveSnapshot "content"

    -- index functions as an archive, since we simply list all posts there
    match "prose/blog/index.html" $ do
        route idRoute
        compile $ do
            let indexCtx = field "posts" $ \_ -> postList recentFirst

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" postCtx
                >>= relativizeUrls

    -- Feeds

    makeBlogFeed "prose/blog/atom.xml" renderAtom

    makeBlogFeed "prose/blog/rss.xml" renderRss

--------------------------------------------------------------------------------
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
    route $ setExtension "html"
    compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

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

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "Christopher Young: Notes and Queries"
    , feedDescription = "The Blog of Christopher Young"
    , feedAuthorName  = "Christopher Young"
    , feedAuthorEmail = "chris@chrisyoung.net"
    , feedRoot        = "http://chrisyoung.net"
    }

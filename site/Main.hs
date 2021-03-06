--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Control.Applicative (Alternative (..))
import           Control.Monad (liftM)
import           Data.Hashable (Hashable, hashWithSalt)
import qualified Data.HashMap.Strict as HM
import           Data.List (isInfixOf, sortBy, intercalate)
import           Data.Maybe (fromMaybe)
import           Data.Monoid ((<>))
import           Data.Time.Clock (UTCTime)
import           Data.Time.Format (parseTimeM, defaultTimeLocale)
import           Hakyll
import           System.FilePath.Posix  (takeBaseName,takeDirectory,(</>),splitFileName)
import           System.FilePath (takeFileName)
import           Text.Pandoc.Options (def)


main :: IO ()
main = hakyllWith siteConfig $ do
    -- straightforward copying
    match (fromList ["index.html", "404.html", ".htaccess"]) $ do
        route idRoute
        compile copyFileCompiler

    copyDirectory "media/*"
    copyDirectory "media/explananda/*"
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
    allPosts <- getMatches postsGlob
    let sortedPosts = sortIdentifiersByDate allPosts
        -- build hashmap of prev/next posts
        (prevPostHM, nextPostHM) = buildAdjacentPostsHashMap sortedPosts

    tags <- buildTags "prose/blog/posts/*" (fromCapture "prose/blog/tags/*.html")
    let fullPostCtx = postCtx <> next <> previous where
          next = field "nextPost" (lookupPostUrl nextPostHM)
          previous = field "prevPost" (lookupPostUrl prevPostHM)

    tagsRules tags $ \tag pattern -> do
        let title = "Posts tagged \"" ++ tag ++ "\""
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll pattern
            let ctx = constField "title" title
                      <> listField "posts" fullPostCtx (return posts)
                      <> defaultContext
            makeItem ""
                >>= loadAndApplyTemplate "templates/tag.html" ctx
                >>= loadAndApplyTemplate "templates/default.html" ctx
                >>= relativizeUrls

    match "prose/blog/posts/*" $ do
        route $ niceRoute
        compile $ do
          pandocCompiler
          >>= loadAndApplyTemplate "templates/post.html" ((ctxWithTags tags) <> fullPostCtx)
          >>= loadAndApplyTemplate "templates/default.html" ((ctxWithTags tags) <> fullPostCtx)
          >>= relativizeUrls
          >>= removeIndexHtml
          >>= saveSnapshot "content"

    match "prose/blog/posts/**.jpg" $ do
        route   idRoute
        compile copyFileCompiler

    match "prose/blog/posts/**.png" $ do
        route   idRoute
        compile copyFileCompiler

    create ["prose/blog/tag-cloud/index.html"] $ do
      let title = constField "title" "Tag Cloud"
      let tagCloud = (tagCloudField "tagCloud" 80 200 tags)
      let tagCloudCtx = title <> postCtx <> tagCloud
      route idRoute
      compile $ do
        makeItem ""
          >>= loadAndApplyTemplate "templates/tag-cloud.html" tagCloudCtx
          >>= loadAndApplyTemplate "templates/default.html" tagCloudCtx
          >>= relativizeUrls
          >>= removeIndexHtml

    -- index functions as an archive, since we simply list all posts there
    match "prose/blog/index.html" $ do
        route idRoute
        compile $ do
            let indexCtx = field "posts" $ \_ -> postList recentFirst
            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" fullPostCtx
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
siteConfig = defaultConfiguration { ignoreFile = myIgnoreFile,
                                    deployCommand = "bash deploy.sh"}

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

-- All of this code below that generates next/previous links is thanks to Richard
-- Goulter. See
-- http://rgoulter.com/blog/posts/programming/2014-07-06-adding-nextprevious-post-to-hakyll.html
type AdjPostHM = HM.HashMap Identifier Identifier

instance Hashable Identifier where
    hashWithSalt salt = hashWithSalt salt . show

-- Glob for matching the *.markdown posts under subdirectories of /posts/<category>/
postsGlob :: Pattern
postsGlob = "prose/blog/posts/**.markdown"

sortIdentifiersByDate :: [Identifier] -> [Identifier]
sortIdentifiersByDate identifiers =
    reverse $ sortBy byDate identifiers
      where
    byDate id1 id2 =
        let fn1 = takeFileName $ toFilePath id1
            fn2 = takeFileName $ toFilePath id2
            parseTime' fn = parseTimeM True defaultTimeLocale "%Y-%m-%d" $ intercalate "-" $ take 3 $ splitAll "-" fn
        in compare ((parseTime' fn1) :: Maybe UTCTime) ((parseTime' fn2) :: Maybe UTCTime)

buildAdjacentPostsHashMap :: [Identifier] -> (AdjPostHM, AdjPostHM)
buildAdjacentPostsHashMap posts =
    let buildHM :: [Identifier] -> [Identifier] -> AdjPostHM
        buildHM [] _ = HM.empty
        buildHM _ [] = HM.empty
        buildHM (k:ks) (v:vs) = HM.insert k v $ buildHM ks vs
    in (buildHM (tail posts) posts, buildHM posts (tail posts))

lookupPostUrl :: AdjPostHM -> Item String -> Compiler String
lookupPostUrl hm post =
    let ident = itemIdentifier post
        ident' = HM.lookup ident hm
    in
    (fmap (maybe empty $ toUrl) . (maybe empty getRoute)) ident'

postList :: ([Item String] -> Compiler [Item String]) -> Compiler String
postList sortFilter = do
    posts   <- sortFilter =<< loadAll "prose/blog/posts/*"
    itemTpl <- loadBody "templates/post-item.html"
    list    <- applyTemplateList itemTpl postCtx posts
    return list

ctxWithTags :: Tags -> Context String
ctxWithTags tags = tagsField "tags" tags

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

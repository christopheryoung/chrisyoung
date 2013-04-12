--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid ((<>))
import           Hakyll


--------------------------------------------------------------------------------

main :: IO ()
main = hakyll $ do

    -- resources
    match "media/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "templates/*" $ compile templateCompiler

    -- Static pages
    match "index.html" $ do
        route idRoute
        let frontPageContext =
                constField "title" "" <>
                defaultContext
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" frontPageContext
            >>= relativizeUrls

    match (fromList staticPages) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    -- Blog
    match "prose/blog/posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    create ["prose/blog/archive.html"] $ do
        route idRoute
        compile $ do
            let archiveCtx =
                    field "posts" (\_ -> postList recentFirst) <>
                    constField "title" "Archives"              <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    match "prose/blog/index.html" $ do
        route idRoute
        compile $ do
            let indexCtx = field "posts" $ \_ ->
                                postList $ fmap (take 3) . recentFirst

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" postCtx
                >>= relativizeUrls

    -- Feeds
    create ["prose/blog/atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = postCtx <> bodyField "description"
            posts <- fmap (take 10) . recentFirst =<<
                     loadAllSnapshots "prose/blog/posts/*" "content"
            renderAtom myFeedConfiguration feedCtx posts

    create ["prose/blog/rss.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = postCtx <> bodyField "description"
            posts <- fmap (take 10) . recentFirst =<<
                     loadAllSnapshots "prose/blog/posts/*" "content"
            renderRss myFeedConfiguration feedCtx posts

--------------------------------------------------------------------------------

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
              ["meta", "prose", "other", "code"]

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "Christopher Young: Notes and Queries"
    , feedDescription = "The Blog of Christopher Young"
    , feedAuthorName  = "Christopher Young"
    , feedAuthorEmail = "chris@chrisyoung.net"
    , feedRoot        = "http://chrisyoung.net/prose/blog"
    }



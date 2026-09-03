--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "favicon.png" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "about.html" $ do
        route   idRoute
        compile $ getResourceBody
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "notes/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    noteCtx
            >>= loadAndApplyTemplate "templates/default.html" noteCtx
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    oldPostCtx
            >>= loadAndApplyTemplate "templates/default.html" oldPostCtx
            >>= relativizeUrls

    create ["notes.html"] $ do
        route idRoute
        compile $ do
            notes <- recentFirst =<< loadAll "notes/*"
            let notesCtx =
                    listField "posts" postCtx (return notes) `mappend`
                    constField "title" "Notes"               `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/notes.html"   notesCtx
                >>= loadAndApplyTemplate "templates/default.html" notesCtx
                >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Old learning notes"  `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            notes <- fmap (take 5) . recentFirst =<< loadAll "notes/*"
            let indexCtx =
                    listField "posts" postCtx (return notes) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    dateField "isodate" "%F"     `mappend`
    defaultContext

-- Articles link back to the index they belong to
noteCtx :: Context String
noteCtx =
    constField "backUrl"   "/notes.html" `mappend`
    constField "backLabel" "notes"       `mappend`
    postCtx

oldPostCtx :: Context String
oldPostCtx =
    constField "backUrl"   "/archive.html"       `mappend`
    constField "backLabel" "old learning notes"  `mappend`
    postCtx

{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty

import Data.Monoid (mconcat)

main = scotty 80 $ do
  get "/hello/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Hello, ", beam, "!</h1>"]

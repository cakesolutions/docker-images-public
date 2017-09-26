{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty

import Data.Monoid (mconcat)
import Data.Text.Lazy (Text)
import Network.Wai.Middleware.RequestLogger(logStdout)

main :: IO ()
main = scotty 80 $ do

  -- Setup a middleware action, to log everything to stdout
  middleware logStdout

  -- Select from a set of files (in the data dir) based on a query param
  get "/ad/l/1" $ do
    queryParam <- param "fileNumber"

    -- STDOUT printing. Will appear in docker logs. Note the liftAndCatchIO.
    -- This is needed for any function that returns an `IO` instead of ActionM
    liftAndCatchIO $ putStrLn ("I got param " ++ show queryParam)

    getFilePath queryParam

  -- Echo back whatever the user passed in a body
  post "/echo" $ do
    requestBody <- body
    raw requestBody

-- | Get the file, send it back to the client while setting the correct
-- content type
getFilePath:: Int -> ActionM ()
getFilePath 1 = setContentType "text/xml" >> file "/opt/data/file1.xml"
getFilePath 2 = setContentType "text/xml" >> file "/opt/data/file2.xml"
getFilePath _ = setContentType "application/json" >> file "/opt/data/file3.json"

setContentType :: Text -> ActionM ()
setContentType = setHeader "Content-Type"

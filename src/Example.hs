module Example where

import Control.Concurrent.Classy

myFunction :: MonadConc m => m String
myFunction = do
  var <- newEmptyMVar
  _ <- fork (putMVar var "hello")
  _ <- fork (putMVar var "world")
  readMVar var


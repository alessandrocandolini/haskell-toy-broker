module Example where

import Control.Concurrent.Classy

nonDeterministic :: MonadConc m => m String
nonDeterministic = do
  m <- newEmptyMVar
  _ <- fork (putMVar m "hello")
  _ <- fork (putMVar m "world")
  readMVar m

deterministic :: MonadConc m => m String
deterministic = do
  m <- newEmptyMVar
  _ <- putMVar m "hello"
  readMVar m

deadlocking :: MonadConc m => m String
deadlocking = do
  m <- newEmptyMVar
  _ <- putMVar m "hello"
  _ <- putMVar m "world"
  readMVar m

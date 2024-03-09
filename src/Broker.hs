{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE StrictData #-}

module Broker where

import Control.Concurrent.Classy
import Data.Semigroup
import Data.String (IsString)
import Data.Time
import Control.Exception (assert)

newtype Ticker = Ticker String
  deriving (Eq, Show)
  deriving (IsString) via String

newtype AccountId = AccountId String
  deriving (Eq, Show)
  deriving (IsString) via String

newtype OrderId = OrderId String
  deriving (Eq, Show)
  deriving (IsString) via String

newtype SharePrice = SharePrice Double
  deriving (Eq, Show)
  deriving (Semigroup, Monoid) via (Sum Double)

newtype Quantity = Quantity Int
  deriving (Eq, Show)
  deriving (Semigroup, Monoid) via (Sum Int)

data Side = Buy | Sell deriving (Eq, Show, Read, Enum, Bounded)

data OrderStatus = Open | Filled | Failed deriving (Eq, Show, Read, Enum, Bounded)

data AccountPosition = AccountPosition Ticker Quantity SharePrice deriving (Eq, Show)

data Market = Market
  { isOpen :: Bool
  , nextOpeningTime :: UTCTime
  , nextClosingTime :: UTCTime
  }
  deriving (Eq, Show)

data Order = Order
  { orderId :: OrderId
  , ticker :: Ticker
  , quantity :: Quantity
  , side :: Side
  , orderStatus :: OrderStatus
  }
  deriving (Eq, Show)

data Broker m = Broker
  { listTradableAssets :: m [Ticker]
  , getLatestPrice :: Ticker -> m SharePrice
  , isMarketOpen :: m Market
  , placeBuyOrderUsingAvailableFunds :: AccountId -> Ticker -> Quantity -> m OrderId
  , getAccountPositions :: AccountId -> m [AccountPosition]
  , getAllOrders :: AccountId -> m [Order]
  }



provideRandomAsset :: Monad m => Broker m -> m Ticker
provideRandomAsset = undefined


-- provide helper to deal with open/close market also base on next times

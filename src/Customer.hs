{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE StrictData #-}

module Customer where

import Data.String (IsString)

newtype CustomerId = CustomerId String
  deriving (Eq, Show)
  deriving (IsString) via String

data FreeShareStatus
  = Ineligible
  | Eligible
  | Claimed
  deriving (Eq, Show, Enum, Bounded)

data CustomerRepository m = CustomerRepository
  { fetchFreeShareStatus :: CustomerId -> m (Maybe FreeShareStatus)
  , setFreeShareStatus :: CustomerId -> FreeShareStatus -> m ()
  , updateToIneligibleAtomically :: CustomerId -> m ()
  }

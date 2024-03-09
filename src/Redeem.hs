module Redeem where
import Customer
import RedeemError
import Broker


redeem :: Monad m => Broker m -> CustomerRepository m -> CustomerId -> m (Either RedeemError OrderId)
redeem broker repo customerId = do
   opt <- fetchFreeShareStatus repo  customerId
   undefined

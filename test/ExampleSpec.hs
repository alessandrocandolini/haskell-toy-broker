module ExampleSpec where

import Example
import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck.Property
import Test.HUnit.DejaFu
import Test.DejaFu
import Test.Hspec.Contrib.HUnit (fromHUnitTest)

spec :: Spec
spec = describe "Example tests" $ do

  describe "myFunction" $ do

     fromHUnitTest $ testDejafu "no deadlock" deadlocksNever myFunction
     fromHUnitTest $ testDejafu "no exception" exceptionsNever myFunction
     fromHUnitTest $ testDejafu "non determinism sadly :(" notAlwaysSame myFunction

  --describe "myFunction autotest" $ do
       --fromHUnitTest $ testAuto myFunction

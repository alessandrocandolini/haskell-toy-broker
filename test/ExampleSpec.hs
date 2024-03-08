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

     fromHUnitTest $ testDejafu "no deadlock" deadlocksNever nonDeterministic
     fromHUnitTest $ testDejafu "no exception" exceptionsNever nonDeterministic
     fromHUnitTest $ testDejafu "non determinism sadly :(" notAlwaysSame nonDeterministic

     fromHUnitTest $ testDejafu "no deadlock" deadlocksNever deterministic
     fromHUnitTest $ testDejafu "no exception" exceptionsNever deterministic
     fromHUnitTest $ testDejafu "determinism" alwaysSame deterministic

     fromHUnitTest $ testDejafu "deadlock" deadlocksAlways deadlocking
  --describe "myFunction autotest" $ do
       --fromHUnitTest $ testAuto myFunction

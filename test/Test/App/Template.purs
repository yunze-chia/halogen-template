module Test.App.Template where

import Prelude
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec =
  describe "template unit test" do
    it "1 == 1" do
      1 `shouldEqual` 1

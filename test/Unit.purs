module Test.Unit where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)

main :: Effect Unit
main =
  launchAff_ do
    specs <- discover "Test\\.App\\..*"
    runSpec [ consoleReporter ] specs

module Main where

import Prelude
import App.AppM (runAppM)
import App.Components.Router (Query(..), component)
import App.Data.Route (routeCodec)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Halogen as H
import Halogen.Aff (awaitBody, runHalogenAff) as HA
import Halogen.VDom.Driver (runUI) as HV
import Routing.Duplex (parse)
import Routing.Hash (matchesWith)

main :: Effect Unit
main = do
  HA.runHalogenAff do
    body <- HA.awaitBody
    let
      initStore = {}
    rootComponent <- runAppM initStore component
    halogenIO <- HV.runUI rootComponent unit body
    void $ H.liftEffect
      $ matchesWith (parse routeCodec) \mOld new ->
          when (mOld /= Just new)
            $ launchAff_ do
                void $ halogenIO.query $ H.mkTell $ Navigate new

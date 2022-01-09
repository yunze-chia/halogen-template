module App.Capabilities.Navigate where

import Prelude
import Halogen (HalogenM, lift) as H
import App.Data.Route (Route)

class
  Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate (H.HalogenM st act slt o m) where
  navigate = H.lift <<< navigate

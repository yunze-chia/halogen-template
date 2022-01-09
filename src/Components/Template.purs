module App.Components.Template where

import Prelude
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState: const unit
    , render
    , eval: H.mkEval H.defaultEval
    }

render :: forall st act slt m. st -> H.ComponentHTML act slt m
render _ = HH.div [ HP.class_ $ HH.ClassName "text-center" ] [ HH.text "This is the way." ]

type Slot id
  = forall q o. H.Slot q o id

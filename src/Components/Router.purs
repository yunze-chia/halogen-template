module App.Components.Router where

import Prelude
import App.Capabilities.Navigate (class Navigate, navigate)
import App.Components.Template (Slot, component) as Template
import App.Data.Route (Route(..), routeCodec)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect.Class (class MonadEffect)
import Halogen as H
import Halogen.HTML as HH
import Routing.Duplex (parse)
import Routing.Hash (getHash)
import Type.Proxy (Proxy(..))

component :: forall i o m. MonadEffect m => Navigate m => H.Component Query i o m
component =
  H.mkComponent
    { initialState: const { route: Nothing }
    , render
    , eval:
        H.mkEval
          H.defaultEval
            { handleQuery = handleQuery
            , handleAction = handleAction
            , initialize = Just Initialize
            }
    }

type State
  = { route :: Maybe Route }

type Slots
  = ( template :: Template.Slot Unit )

__template = Proxy :: Proxy "template"

render :: forall act m. State -> H.ComponentHTML act Slots m
render { route } = case route of
  Just Root -> HH.slot_ __template unit Template.component unit
  Nothing -> HH.text ""

data Action
  = Initialize

handleAction ::
  forall st slt o m.
  MonadEffect m => Navigate m => Action -> H.HalogenM st Action slt o m Unit
handleAction = case _ of
  Initialize -> do
    eitherRoute <- (parse routeCodec) <$> H.liftEffect getHash
    case eitherRoute of
      Left _ -> navigate Root -- On first load if route is not found, navigate to home page
      Right route -> navigate route

data Query a
  = Navigate Route a

handleQuery :: forall slt o m a. Query a -> H.HalogenM State Action slt o m (Maybe a)
handleQuery = case _ of
  Navigate destination a -> do
    { route } <- H.get
    when (route /= (Just destination)) do
      H.modify_ \st -> st { route = Just destination }
    pure (Just a)

type Slot id
  = forall q o. H.Slot q o id

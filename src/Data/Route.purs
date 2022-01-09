module App.Data.Route where

import Prelude hiding ((/))
import Data.Generic.Rep (class Generic)
import Routing.Duplex (RouteDuplex', print, root)
import Routing.Duplex.Generic (noArgs, sum)

data Route
  = Root

derive instance genericRoute :: Generic Route _

derive instance eqRoute :: Eq Route

routeCodec :: RouteDuplex' Route
routeCodec =
  root
    $ sum
        { "Root": noArgs
        }

hashRoute :: Route -> String
hashRoute route = "#" <> print routeCodec route

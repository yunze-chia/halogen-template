module App.Capabilities.Store where

import App.Data.Store (Action, Store)
import Halogen.Store.Monad (class MonadStore)

class MonadStore Action Store m <= AppStore m

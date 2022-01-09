module App.Data.Store where

import Halogen.Store.Monad (StoreT)

type Store
  = {}

type Action
  = Store -> Store

reduce :: Store -> Action -> Store
reduce store k = k store

type AppStoreT
  = StoreT Action Store

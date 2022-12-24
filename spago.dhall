{ name = "my-project"
, dependencies =
  [ "aff"
  , "effect"
  , "either"
  , "halogen"
  , "halogen-store"
  , "maybe"
  , "prelude"
  , "routing"
  , "routing-duplex"
  , "safe-coerce"
  , "spec"
  , "spec-discovery"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

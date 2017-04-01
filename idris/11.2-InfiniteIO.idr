module Main

data InfIO : Type where
  Do : IO a ->
       (a -> Inf InfIO) ->
       InfIO

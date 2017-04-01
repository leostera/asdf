module Main

data InfIO : Type where
  Do : IO a ->
       (a -> Inf InfIO) ->
       InfIO

loopPrint : String -> InfIO
loopPrint x = Do {a = ([__])} ?loopPrint_rhs1 ?loopPrint_rhs2

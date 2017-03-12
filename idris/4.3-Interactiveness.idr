module Main

import Data.Vect

data Store : t -> Type where
  Create : (size : Nat) ->
           (elems : Vect size t) ->
           Store t

size : Store t -> Nat
size (Create size' elems') = size'

items : (store : Store t) -> Vect (size store) t
items (Create size' elems') = elems'

add : (store : Store t) -> t -> Store t
add (Create size elems) newElem = Create _ (elems ++ [newElem])

{-
  Splitting up the Commands for Processing from the strings that represent them
  is what makes easier to isolate parsing and it's failure modes from the
  processing.
-}
data Command = Add String
             | Get Integer
             | Quit

parse : (input : String) -> Maybe Command

processInput : Store t -> String -> Maybe (String, Store t)

main : IO ()
main = replWith (Create _ []) "Command: " processInput

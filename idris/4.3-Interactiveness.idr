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

cleanInputs : String -> (String, String)
cleanInputs input = case span (/= ' ') input of
                         (cmd, args) => (cmd, ltrim args)

parseCommand : (cmd : String) -> (args : String) -> Maybe Command


parse : (input : String) -> Maybe Command
parse input = case cleanInputs input of
                   (cmd, args) => parseCommand cmd args 

main : IO ()
main = replWith (Create _ []) "Command: " ?processInput

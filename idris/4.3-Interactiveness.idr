module Main

import Data.Vect

%default total

data Store : Type where
  Create : (size : Nat) ->
           (elems : Vect size String) ->
           Store

size : Store -> Nat
size (Create size' elems') = size'

items : (store : Store) -> Vect (size store) String
items (Create size' elems') = elems'

add : (store : Store) -> String -> Store
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
cleanInputs input = case (span (/= ' ') input) of
                         (cmd, args) => (toLower cmd, ltrim args)

parseCommand : (cmd : String) -> (args : String) -> Maybe Command
parseCommand "get" index = case all isDigit (unpack index) of
                                False => Nothing
                                True => Just (Get (cast index))
parseCommand "add" value = Just (Add value)
parseCommand "quit" ""   = Just Quit
parseCommand _  _ = Nothing

parse : (input : String) -> Maybe Command
parse input = case cleanInputs input of
                   (cmd, args) => parseCommand cmd args

getByIndex : (pos : Integer) -> (store : Store) -> Maybe String
getByIndex pos (Create Z []) = Nothing
getByIndex pos (Create (S len) (x :: xs)) = ?getByIndex_rhs_3

processInput : Store -> String -> Maybe (String, Store)
processInput store input
= case parse input of
       Just (Add item) => Just ("ID: " ++ show (size store) ++ "\n", add store item)
       Just (Get pos) => Just("Result: " ++ show (getByIndex pos store) ++ "\n", store)
       Just Quit => Nothing
       Nothing => Just ("Invalid command\n", store)

partial main : IO ()
main = replWith (Create _ []) "Command > " processInput

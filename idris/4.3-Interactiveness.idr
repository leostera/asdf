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
             | Search String
             | Size
             | Quit

cleanInputs : String -> (String, String)
cleanInputs input = case (span (/= ' ') input) of
                         (cmd, args) => (toLower cmd, ltrim args)

parseCommand : (cmd : String) -> (args : String) -> Maybe Command
parseCommand "get" index = case all isDigit (unpack index) of
                                False => Nothing
                                True => Just (Get (cast index))
parseCommand "search" query = Just (Search query)
parseCommand "add" value = Just (Add value)
parseCommand "size" ""  = Just Size
parseCommand "quit" ""  = Just Quit
parseCommand _  _ = Nothing

parse : (input : String) -> Maybe Command
parse input = case cleanInputs input of
                   (cmd, args) => parseCommand cmd args

getByIndex : (store : Store) -> (pos : Integer) -> String
getByIndex store pos = case integerToFin pos (size store) of
                            Nothing => "Out of Range"
                            Just pos' => index pos' (items store)

search_with_infix : (store : Store) -> (query : String) -> Maybe (String, Store)
search_with_infix store query = ?search_with_infix_rhs

run : Store -> Command -> Maybe (String, Store)
run store (Search query) = search_with_infix store query
run store (Add item) = Just ("ID: " ++ show (size store) ++ "\n", add store item)
run store (Get pos) = Just ("Result: " ++ show (getByIndex pos store) ++ "\n", store)
run store Size = Just (show (size store) ++ " item(s)\n", store)
run store Quit = Nothing

processInput : Store -> String -> Maybe (String, Store)
processInput store input
= case parse input of
       Just validCommand => run store validCommand
       Nothing => Just ("Invalid command\n", store)

partial main : IO ()
main = replWith (Create _ []) "Command > " processInput

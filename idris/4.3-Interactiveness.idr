module Main

import Data.Vect

%default total

data Store : Type where
  Create : (size : Nat) ->
           (elems : Vect size String) ->
           Store
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

size : Store -> Nat
size (Create size' elems') = size'

items : (store : Store) -> Vect (size store) String
items (Create size' elems') = elems'

add : (store : Store) -> String -> Store
add (Create size elems) newElem = Create _ (elems ++ [newElem])

getByIndex : (store : Store) -> (pos : Integer) -> String
getByIndex store pos = case integerToFin pos (size store) of
                            Nothing => "Out of Range"
                            Just pos' => index pos' (items store)

search : (store : Store) -> (query : String) -> (n : Nat ** Vect n String)
search store query = filter (isInfixOf query) (items store)

formatMatches : (store : Store) -> (results : (n : Nat ** Vect n String)) -> String
formatMatches store (_ ** []) = "No matches\n"
formatMatches store (n ** rs) = foldr (++) "" (map resultToString rs)
  where
    resultToString : String -> String
    resultToString r = (indexInStore r) ++ ": " ++ r ++ "\n"

    indexInStore : String -> String
    indexInStore r = case (elemIndex r (items store)) of
                          Just i => show (finToNat i)
                          Nothing => "?"

run : Store -> Command -> Maybe (String, Store)
run store (Search query) = let results = search store query in
                               Just( (formatMatches store results), store )
run store (Add item) = Just ("ID: " ++ show (size store) ++ "\n", add store item)
run store (Get pos) = Just ("Result: " ++ show (getByIndex store pos) ++ "\n", store)
run store Size = Just (show (size store) ++ " item(s)\n", store)
run store Quit = Nothing

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

processInput : Store -> String -> Maybe (String, Store)
processInput store input
= case parse input of
       Just validCommand => run store validCommand
       Nothing => Just ("Invalid command\n", store)

partial main : IO ()
main = replWith (Create _ []) "Command > " processInput

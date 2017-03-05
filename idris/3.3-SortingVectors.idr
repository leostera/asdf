import Data.Vect

total insert : Ord type => (x : type) -> (xsSorted : Vect len type) -> Vect (S len) type
insert x [] = [x]
insert x (y :: xs) = case x < y of
                          False => y :: insert x xs
                          True => x :: y :: xs

total insSort : Ord type => Vect length type -> Vect length type
insSort [] = []
insSort (x :: xs) = let xsSorted = insSort xs in
                              insert x xsSorted

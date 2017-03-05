import Data.Vect

insert : Ord type => (x : type) -> (xsSorted : Vect len type) -> Vect (S len) type
insert x [] = [x]
insert x (y :: xs) = if x < y then x :: y :: xs
                              else y :: insert x xs

insSort : Ord type => Vect length type -> Vect length type
insSort [] = []
insSort (x :: xs) = let xsSorted = insSort xs in
                              insert x xsSorted


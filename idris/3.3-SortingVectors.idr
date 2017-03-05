import Data.Vect

insert : Ord type => (x : type) -> (xsSorted : Vect len type) -> Vect (S len) type
insert x [] = [x]
insert x (y :: xs) = ?insert_rhs_2

insSort : Ord type => Vect length type -> Vect length type
insSort [] = []
insSort (x :: xs) = let xsSorted = insSort xs in
                              insert x xsSorted


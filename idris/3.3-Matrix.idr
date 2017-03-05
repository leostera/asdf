import Data.Vect

add_vec : Num t => (x : Vect cols t) -> (y : Vect cols t) -> Vect cols t
add_vec [] [] = []
add_vec (x :: xs) (y :: ys) = (x + y) :: add_vec xs ys

add : Num t => Vect rows ( Vect cols t ) -> Vect rows ( Vect cols t ) -> Vect rows ( Vect cols t )
add [] [] = []
add (x :: xs) (y :: ys) = add_vec x y :: add xs ys

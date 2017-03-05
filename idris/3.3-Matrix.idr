import Data.Vect

total add_vec : Num t =>
          (x : Vect cols t) ->
          (y : Vect cols t) ->
          Vect cols t
add_vec [] [] = []
add_vec (x :: xs) (y :: ys) = (x + y) :: add_vec xs ys

total add : Num t =>
      Vect rows ( Vect cols t ) ->
      Vect rows ( Vect cols t ) ->
      Vect rows ( Vect cols t )
add [] [] = []
add (x :: xs) (y :: ys) = add_vec x y :: add xs ys

total createEmpties : Vect n (Vect 0 t)
createEmpties = replicate _ []

total transposeHelper : (x : Vect n elem) -> (xsTrans : Vect n (Vect k elem)) -> Vect n (Vect (S k) elem)
transposeHelper [] [] = []
transposeHelper (x :: ys) (y :: xs) = (x :: y) :: transposeHelper ys xs

total transpose' : Vect m (Vect n elem) -> Vect n (Vect m elem)
transpose' [] = createEmpties
transpose' (x :: xs) = let xsTrans = transpose' xs in
                          transposeHelper x xsTrans

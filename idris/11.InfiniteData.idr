module Infinity

-- First iteration, complected number generation with labeling

labelFrom : Integer -> List a -> List (Integer, a)
labelFrom k [] = []
labelFrom k (x :: xs) = (k, x) :: labelFrom (k+1) xs

label : List a -> List (Integer, a)
label = labelFrom 0

-- Second iteration, split number generation from labeling

countFrom : Integer -> List Integer
countFrom n = n :: countFrom (n+1)

labelWith : List Integer -> List a -> List (Integer, a)
labelWith _ []  = []
labelWith (x :: xs) (y :: ys) = (x, y) :: labelWith xs ys

-- this works on the REPL because it's lazy
label' : List a -> List (Integer, a)
label' = labelWith (countFrom 0)

-- Third iteration, Infinite Lists!

data InfList : Type -> Type where
  (::) : (value : elem) -> Inf (InfList elem) -> InfList elem
-- there's no [] constructor because infinite lists just don't end

-- countFrom' is a corecursive function that returns codata
total countFrom' : Integer -> InfList Integer
countFrom' x = x :: Delay (countFrom' (x + 1))

getPrefix : (count : Nat) -> InfList ty -> List ty
getPrefix Z x = ?getPrefix_rhs_1
getPrefix (S k) x = ?getPrefix_rhs_2

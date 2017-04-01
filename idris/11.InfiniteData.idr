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

-- I would have expected this to not work!
-- but it does, and I wonder why
label' : List a -> List (Integer, a)
label' = labelWith (countFrom 0)

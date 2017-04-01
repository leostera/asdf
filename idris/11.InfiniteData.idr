module Infinity

-- First iteration, complected label generation with labeling

labelFrom : Integer -> List a -> List (Integer, a)
labelFrom k [] = []
labelFrom k (x :: xs) = (k, x) :: labelFrom (k+1) xs

label : List a -> List (Integer, a)
label = labelFrom 0

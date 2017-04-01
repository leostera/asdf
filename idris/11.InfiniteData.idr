module Infinity

labelFrom : List a -> Integer -> List (Integer, a)
labelFrom [] k = []
labelFrom (x :: xs) k = (k, x) :: labelFrom xs (k+1)

label : List a -> List (Integer, a)
label = ?labelFrom

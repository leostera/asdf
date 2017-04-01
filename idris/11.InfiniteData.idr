module Infinity

labelFrom : List a -> Nat -> List (Integer, a)
labelFrom [] k = ?labelFrom_rhs_1
labelFrom (x :: xs) k = ?labelFrom_rhs_2

label : List a -> List (Integer, a)
label = ?labelFrom

module Infinity

labelFrom : List a -> Nat -> List (Integer, a)

label : List a -> List (Integer, a)
label = labelFrom

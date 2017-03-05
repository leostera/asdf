import Data.Vect

length : Vect n elem -> Nat
length {n} xs = n

empties : Vect n (Vect 0 a)
empties {n = Z} = []
empties {n = (S k)} = [] :: empties

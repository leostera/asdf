import Data.Vect

fourInts : Vect 4 Int
fourInts = [0,1,2,3]

||| The sum of both 4D vectors is an 8D vector
eightInts : Vect 8 Int
eightInts = fourInts ++ fourInts

total allLengths : Vect len String -> Vect len Nat
allLengths (word :: words) = length word :: allLengths words

badLengthWithList : List String -> List Nat
badLengthWithList xs = []

badLengthWithVect : Vect n String -> Vect n Nat
badLengthWithVect xs = ?replace_with_empty_list_for_type_checking_error

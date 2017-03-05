import Data.Vect

fourInts : Vect 4 Int
fourInts = [0,1,2,3]

||| The sum of both 4D vectors is an 8D vector
eightInts : Vect 8 Int
eightInts = fourInts ++ fourInts

allLengths : Vect len String -> Vect len Nat
allLengths [] = []
allLengths (word :: words) = length word :: allLengths words

badLengthWithList : List String -> List Nat
badLengthWithList xs = []

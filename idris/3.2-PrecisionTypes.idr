import Data.Vect

fourInts : Vect 4 Int
fourInts = [0,1,2,3]

||| The sum of both 4D vectors is an 8D vector
eightInts : Vect 8 Int
eightInts = fourInts ++ fourInts

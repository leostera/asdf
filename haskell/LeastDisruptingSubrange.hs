module Main where

import Data.List

diff :: [Int] -> [Int] -> Int
diff a b = foldr (+) 0 $ map (\(x,y) -> abs (x-y)) $ zip a b

diffEveryPosition :: [Int] -> [Int] -> Int -> Int -> [(Int, Int)]
diffEveryPosition a b b_len i = case length a >= length b of
    False -> []
    True -> (diff (take b_len a) b, i) : diffEveryPosition (tail a) b b_len (i+1)

leastDisrupting :: [Int] -> [Int] -> Int
leastDisrupting a b = snd $ head $ sort $ diffEveryPosition a b (length b) 0

main :: IO ()
main = putStrLn "Hello"

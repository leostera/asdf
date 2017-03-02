module Shenanigans

double : Num a => a -> a
double x = x + x

add : Int -> Int -> Int
add x y = x+y

id : a -> a
id x = x

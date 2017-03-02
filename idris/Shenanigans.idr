module Shenanigans

double : Num a => a -> a
double x = x + x

add : Int -> Int -> Int
add x y = x+y

id : a -> a
id x = x

twice : (a -> a) -> a -> a
twice f x = f (f x)

Shape : Type
rotate : Shape -> Shape

turn_around : Shape -> Shape
turn_around = twice rotate

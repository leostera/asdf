
||| The cardinal directions
data Direction = North
               | East
               | South
               | West

turn : Direction -> Direction
turn North = East
turn East = South
turn South = West
turn West = North

||| A Shape
data Shape = ||| A triangle
             Triangle Double Double
           | ||| A rectangle
             Rectangle Double Double
           | ||| A circle
             Circle Double

area : Shape -> Double
area (Triangle x y) = 0.5 * x * y
area (Rectangle x y) = x * y
area (Circle x) = pi * x * x


||| The cardinal directions
data Direction = North
               | East
               | South
               | West

total turn : Direction -> Direction
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

total area : Shape -> Double
area (Triangle x y) = 0.5 * x * y
area (Rectangle x y) = x * y
area (Circle x) = pi * x * x

||| A shape defined as a type function
data Shape' : Type where
  Triangle' : Double -> Double -> Shape'
  Rectangle' : Double -> Double -> Shape'
  Circle' : Double -> Shape'

data Picture = Primitive Shape
             | Combine Picture Picture
             | Rotate Double Picture
             | Translate Double Double Picture

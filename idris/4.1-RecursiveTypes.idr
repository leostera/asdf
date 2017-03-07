data Shape = Triangle Double Double
           | Rectangle Double Double
           | Circle Double

data Picture = Primite Shape
             | Combine Picture Picture
             | Rotate Double Picture
             | Tranlate Double Double Picture

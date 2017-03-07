
data Picture = Primite Shape
             | Combine Picture Picture
             | Rotate Double Picture
             | Tranlate Double Double Picture

data Shape = Triangle Double Double
           | Rectangle Double Double
           | Circle Double

data Picture = Primite Shape
             | Combine Picture Picture
             | Rotate Double Picture
             | Translate Double Double Picture

testPicture : Picture
testPicture = Combine (Translate 5 5 ?rectangle)
                ( Combine (Translate 35 5 ?circle)
                  (Translate 15 25 ?triangle) )

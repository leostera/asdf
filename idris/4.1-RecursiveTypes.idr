%name Shape shape1, shape2
data Shape = Triangle Double Double
           | Rectangle Double Double
           | Circle Double

%name Picture pic1, pic2
data Picture = Primitive Shape
             | Combine Picture Picture
             | Rotate Double Picture
             | Translate Double Double Picture

area : Picture -> Double
area x = ?area_rhs

rectangle : Picture
rectangle = Primitive (Rectangle 20 10)

circle : Picture
circle = Primitive (Circle 5)

triangle : Picture
triangle = Primitive (Triangle 10 10)

testPicture : Picture
testPicture = Combine (Translate 5 5 rectangle)
                      (Combine (Translate 35 5 circle)
                               (Rotate 5 (Translate 15 25 triangle)))

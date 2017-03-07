data Option a = None | Some a

total safeDiv : Double -> Double -> Option Double
safeDiv x 0.0 = None
safeDiv x y = Some (x/y)

data Result a b = Ok a | Error b

run : (f : (a -> c)) -> (g : (b -> c)) -> Result a b -> c
run f g x = ?run_rhs_1

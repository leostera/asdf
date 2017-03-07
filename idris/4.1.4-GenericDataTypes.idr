data Option a = None | Some a

total safeDiv : Double -> Double -> Option Double
safeDiv x 0.0 = None
safeDiv x y = Some (x/y)

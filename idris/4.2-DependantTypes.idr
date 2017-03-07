import Data.Fin

data PowerSource = Petrol | Pedal

||| Vehicle here is a function from PowerSource to a type
data Vehicle : PowerSource -> Type where
  Bycicle : Vehicle Pedal
  Car : (fuel : Nat) -> Vehicle Petrol
  Bus : (fuel : Nat) -> Vehicle Petrol

wheels : Vehicle power -> Nat
wheels Bycicle = 2
wheels (Car fuel) = 4
wheels (Bus fuel) = 4

refuel : Vehicle Petrol -> Vehicle Petrol
refuel (Car fuel) = Car 100
refuel (Bus fuel) = Car 200
refuel Bycicle impossible

||| After looking into the definition of `integerToFin` in
||| https://github.com/idris-lang/Idris-dev/blob/master/libs/base/Data/Fin.idr
||| it seems that my original approach was wrong.
integerToFin : Integer -> (n : Nat) -> Maybe (Fin n)
integerToFin x Z = Nothing
integerToFin x n = if x >= 0 then natToFin (cast x) n else Nothing

integerToFin' : Integer -> (n : Nat) -> Maybe (Fin n)
integerToFin' x Z = Nothing
integerToFin' x n  = case compare (cast x) n of
                          GT => Nothing
                          EQ => Just (the Fin n x)
                          LT => Just (the Fin n x)

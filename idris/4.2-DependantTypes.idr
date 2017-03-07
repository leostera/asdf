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

integerToFin : Integer -> (n : Nat) -> Maybe (Fin n)
integerToFin x y = case compare x y  of
                        GT => Nothing
                        EQ => Just(Fin y)
                        LT => Just(Fin x)

data PowerSource = Petrol | Pedal

||| Vehicle here is a function from PowerSource to a type
data Vehicle : PowerSource -> Type where
  Bycicle : Vehicle Pedal
  Car : (fuel : Nat) -> Vehicle Petrol
  Bus : (fuel : Nat) -> Vehicle Petrol

wheels : Vehicle power -> Nat
wheels Bycicle = 0
wheels (Car fuel) = fuel
wheels (Bus fuel) = ?wheels_rhs_3

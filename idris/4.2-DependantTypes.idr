data PowerSource = Petrol | Pedal

||| Vehicle here is a function from PowerSource to a type
data Vehicle : PowerSource -> Type where
  Bycicle : (wheels : Nat) -> Vehicle Pedal
  Car : (wheels : Nat) -> (fuel : Nat) -> Vehicle Petrol
  Bus : (wheels : Nat) -> (fuel : Nat) -> Vehicle Petrol

wheels : Vehicle power -> Nat
wheels x = ?wheels_rhs

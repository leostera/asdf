data PowerSource = Petrol | Pedal

data Vehicle : PowerSource -> Type where
  Bycicle : Vehicle Pedal
  Car : (fuel : Nat) -> Vehicle Petrol
  Bus : (fuel : Nat) -> Vehicle Petrol

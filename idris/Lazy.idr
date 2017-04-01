h : Nat -> () -> Nat
h x = \_ => (+) x 1

h' : Nat -> Lazy Nat
h' x = (+) x 1

{-

*11.2-InfiniteIO> h 1
\underscore => 2 : () -> Nat

*11.2-InfiniteIO> h' 1
Delay 2 : Lazy Nat

-}

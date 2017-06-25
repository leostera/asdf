module Corecursive

mutual
  data A = MkA B
  data B = MkB A

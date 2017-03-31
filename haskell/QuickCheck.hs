
import Test.QuickCheck.QCGen

newtype Gen a = MkGen {
  unGen :: QCGen -> Int -> a
}

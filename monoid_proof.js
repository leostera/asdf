

type Monoid<T> = {
  empty(): Monoid<T>;
  concat(Monoid<T>): Monoid<T>;
}

const test_empty = () => {
    
}

/*
  1. Syntax checs
  2. Flow type checks
  3. Flow type tests (Laws)
  4. Regular tests
*/

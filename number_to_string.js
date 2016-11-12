import assert from 'assert'

const parts_to_string = () => {}

const to_weights = (e, i) => [e, Math.pow(10, i)]
const number_to_parts = (n: number): number[] => {
  let parts = []
  while( n > 0 ) {
    let part = n % 10
    n = (n/10)|0
    parts.push(part)
  }
  return parts.map(to_weights).reverse()
}

const number_to_string = (n: number): string => {

}

const t = (n, f, a, b) => it(`${n}(${JSON.stringify(a)}) == ${JSON.stringify(b)}`, () => {
  assert.deepEqual(b, f(a))
})

describe('number_to_string', () => {

  [[1, [ [1,1] ], "one"],
   [7, [ [7,1] ], "seven"],
   [12, [ [1,10], [2,1] ], "twelve"],
   [17, [ [1,10], [7,1] ], "seventeen"],
   [22, [ [2,10], [2,1] ], "twenty two"],
   [45, [ [4,10], [5,1] ], "forty five"],
   [145, [ [1,100], [4,10], [5,1] ], "hundred forty five"],
    [1145, [ [1,1000], [1,100], [4,10], [5,1] ], "thousand hundred forty five"]].map( ([number, parts, string]) => {
      t('number to parts', number_to_parts, number, parts)
      //t('parts to string', parts_to_string, parts, string)
      //t('number to string', number_to_string, number, string)
    })

})

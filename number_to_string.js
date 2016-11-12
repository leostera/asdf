import assert from 'assert'

const tables = {
  "1": {
    "0": "zero",
    "1": "one",
    "2": "two",
    "3": "three",
    "4": "four",
    "5": "five",
    "6": "six",
    "7": "seven",
    "8": "eight",
    "9": "nine",
  },
  "10": {
    "1": {
      "0": "ten",
      "1": "eleven",
      "2": "twelve",
      "3": "thirteen",
      "4": "fourteen",
      "5": "fifteen",
      "6": "sixteen",
      "7": "seventeen",
      "8": "eightteen",
      "9": "nineteen",
    },
    "2": "twenty",
    "3": "thirty",
    "4": "forty",
    "5": "fivety",
    "6": "sixty",
    "7": "seventy",
    "8": "eightty",
    "9": "ninety",
  },
  "100": {
    "1": "one hundred",
    "2": "two hundred",
    "3": "three hundred",
    "4": "four hundred",
    "5": "five hundred",
    "6": "six hundred",
    "7": "seven hundred",
    "8": "eight hundred",
    "9": "nine hundred",
  },
  "1000": {
    "1": "one thousand",
    "2": "two thousand",
    "3": "three thousand",
    "4": "four thousand",
    "5": "five thousand",
    "6": "six thousand",
    "7": "seven thousand",
    "8": "eight thousand",
    "9": "nine thousand",
  },
}

const part_to_string = ([value, weight], i, parts) => {
  let prev = parts[i+1]
  let next = parts[i-1]
  if (weight == 1 && next && next[1] == 10 && next[0] == 1 ) {
    return ''
  } else if ( weight == 10 && value == 1 ) {
    return tables[weight][value][prev[0]]
  } else {
    return tables[weight][value]
  }
}

const parts_to_string = (parts) => {
  return parts.map(part_to_string).join(' ').trim()
}

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

const number_to_string = (n: number): string => parts_to_string(number_to_parts(n))

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
   [145, [ [1,100], [4,10], [5,1] ], "one hundred forty five"],
    [1145, [ [1,1000], [1,100], [4,10], [5,1] ], "one thousand one hundred forty five"]].map( ([number, parts, string]) => {
      t('number to parts', number_to_parts, number, parts)
      t('parts to string', parts_to_string, parts, string)
      t('number to string', number_to_string, number, string)
    })

})

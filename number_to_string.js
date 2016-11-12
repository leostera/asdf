
const number_to_parts = (n: number): number[] => {
  let parts = []
  while( n > 0 ) {
    let part = n % 10
    n = Math.floor(n/10)
    parts.push( [part, Math.pow(10, parts.length)] )
  }
  return parts
}

const number_to_string = (n: number): string => {

}

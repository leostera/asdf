const Data = ({typeName, indexTypes, constructors}) => ({
  typeName,
  indexTypes,
  constructors
})

const Nat = Data({
  typeName: 'Nat',
  indexTypes: [],
  constructors: [
    { name: 'Z', arity: 0 },
    {
      name: 'S',
      arity: 1,
      argumentTypes: [
        { index: 0, typeName: 'Nat' },
      ]
    },
  ],
})

const Vect = Data({
  typeName: 'Vector',
  indexTypes: [
    { index: 0, typeName: 'Nat' },
    { index: 1, typeName: 'Type' },
  ],
  constructors: [
    { name: 'Nil', arity: 0 },
    {
      name: 'Cons',
      arity: 2,
      argumentTypes: [
        { index: 0, typeName: 'Type' },
        { index: 1, typeName: 'Vector' },
      ]
    }
  ]
})

module.exports = {
  Data,
  Nat,
  Vect,
}

const stringify = value => {
  if(!value) return ""
  if(value.inspect && typeof value.inspect == 'function') return value.inspect()
  if(Array.isArray(value)) return `[${value.map(stringify).join(', ')}]`
  return JSON.stringify(value)
}

const inspect = type => value => () => `${type}(${stringify(value)})`

const Type = type => value => ({
  type,
  value,
  inspect: inspect(type)(value),
});

const Action = type => payload => ({
  type,
  payload,
  inspect: inspect(type)(payload),
});

const ListAlerts = Action('ListAlerts');
const GetAlerts = Action('GetAlerts');;

const Success = Type('Success');
const Error = Type('Error');
const Request = Type('Request');

console.log(ListAlerts(Request()))
console.log(ListAlerts(Success({ object: { id: 123 }})))
console.log(GetAlerts(Error({ object: { id: 123 }})))


Function.prototype.then = function(f) {
  const g = this;
  return x => f(g(x));
}

Function.prototype.run = function(...args) {
  return this.apply(this, args);
}

Object.prototype.then = function(f) {
  return f(this);
}

const id = x => x

id
  .then(x => x + 1)
  .then(x => x * 2)
  .run(1)

Number(1).then(x => x + 1)

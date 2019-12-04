fetch("./checkers.wasm")
  .then(r => r.arrayBuffer())
  .then(WebAssembly.instantiate)
  .then(wasm => {
    const mod = wasm.instance.exports

    const white = 2;
    const black = 1;
    const crowned_white = 6;
    const crowned_black = 5;

    const offset = mod['offset-for-position'](3,4)
    console.log("Offset for 3,4 is ", offset)

    console.debug(mod['is-white'](white))
    console.debug(mod['is-black'](black))
    console.debug(mod['is-crowned'](crowned_black))
    console.debug(mod['is-crowned'](crowned_white))
  })

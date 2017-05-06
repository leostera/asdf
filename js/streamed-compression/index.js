const read = require('fs').createReadStream
const { createServer } = require('http')
const pump = require('pump')

const brotli = require('iltorb')

createServer( (req, res) => {
  pump(read('./index.html'), brotli.compressStream(), res)
}).listen(8080, () => console.log("Listening..."))


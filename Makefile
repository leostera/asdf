all:
	@./node_modules/.bin/mocha --compilers js:babel-core/register ./*.js

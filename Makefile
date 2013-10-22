all: coffee compress

coffee:
	coffee -jcp src/*.coffee > build/colors.js

compress:
	yui-compressor -o build/colors.min.js build/colors.js

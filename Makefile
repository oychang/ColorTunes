all:
	coffee -jcp src/*.coffee > build/colors.js
	yui-compressor -o build/colors.min.js build/colors.js

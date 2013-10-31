UGLIFY_JS = "uglifyjs"
REGULAR_JS_PATH = "build/colors.js"
MINIFIED_JS_PATH = "build/colors.min.js"

all: coffee compress
coffee:
	coffee -jcp src/*.coffee > $(REGULAR_JS_PATH)
compress:
	$(UGLIFY_JS)\
	    $(REGULAR_JS_PATH)\
	    -o $(MINIFIED_JS_PATH)\
	    --compress --mangle\
	    --comments all --screw-ie8 --lint


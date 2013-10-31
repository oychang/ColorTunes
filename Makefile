CLOSURE_PATH = "/home/ochang/Code/closure-compiler/build/compiler.jar"
REGULAR_JS_PATH = "build/colors.js"
MINIFIED_JS_PATH = "build/colors.min.js"

all: coffee closure
coffee:
	coffee -jcp src/*.coffee > $(REGULAR_JS_PATH)
closure:
	java -jar $(CLOSURE_PATH) --js $(REGULAR_JS_PATH) --js_output_file $(MINIFIED_JS_PATH)

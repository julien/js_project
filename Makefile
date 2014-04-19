# vim: ts=2 sw=2 expandtab
SHELL = /bin/bash
HTML_SRC = index.html
HTML_DST = build/index.html
JS_SRC = $(shell find js -type f -name '*.js')
JS_DST = build/app.min.js 

all: clean $(JS_DST) $(HTML_DST)

$(JS_DST): $(JS_SRC)
	mkdir -p $(@D)
	node ./node_modules/uglify-js/bin/uglifyjs $(JS_SRC) -o $@ -c 'warnings=false' -m --screw-ie8

$(HTML_DST): $(HTML_SRC)
	node -e "require('./node_modules/htmlprocessor/index')({src:['$(HTML_SRC)'],dest:'$@'});"

lint:
	node ./node_modules/eslint/bin/eslint.js js/*.js

server:
	node ./node_modules/sencisho/bin/sencisho -l -w js/*.js

clean:
	rm -rf build

.PHONY: clean lint server


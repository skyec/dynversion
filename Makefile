.PHONY: deps start build clean

APP_VERSION=1
minjs=main.min.js

deps:
	npm install -g http-server
	npm install -g requirejs

start:
	http-server

v/$(APP_VERSION)/$(minjs):
	pushd app && r.js -o paths.jquery='//code.jquery.com/jquery-2.1.4.min' name=main out=../$@; popd

build: v/$(APP_VERSION)/$(minjs)

clean:
	rm -rf ./v/

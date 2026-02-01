.PHONY: build
build:
	mkdir -p bin
	swift build -c release
	cp .build/release/tmignore bin/tmignore

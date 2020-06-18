prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib

build:
	swift build -c release --disable-sandbox

install: build
	install ".build/release/DefaultBrowser" "$(bindir)/default-browser"

uninstall:
	rm -rf "$(bindir)/default-browser"

clean:
	rm -rf .build

.PHONY: build install uninstall clean

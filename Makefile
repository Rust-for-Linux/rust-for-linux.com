.PHONY: build
build:
	./pre.py
	mdbook build
	./post.py

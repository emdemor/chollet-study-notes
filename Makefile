PROJECT_NAME = dl-notes

build:
	jupyter-book build $(PROJECT_NAME)/

clean:
	rm -rf dl-notes/_build
NPM=npm
NODE=node

COFFEE=$(PWD)/node_modules/coffee-script/bin/coffee

SRC=$(shell find src -name \*.coffee)

TARGETS = $(patsubst src/%.coffee,lib/%.js,$(SRC))

all: public node_modules $(TARGETS)

lib/%.js: src/%.coffee
	@mkdir -p $(shell dirname $@)
	$(COFFEE) -c -m -o $(shell dirname $@) "$<"

node_modules: package.json
	$(NPM) install -d
	touch node_modules

public: node_modules
	#make -C public

clean:
	rm -rf $(TARGETS)
	make -C public clean

.PHONY: all clean public

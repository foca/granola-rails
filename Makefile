PACKAGES := granola-rails
VERSION_FILE := lib/granola/rails/version.rb

DEPS := $(GEM_HOME)/installed
VERSION := $(shell sed -ne '/.*VERSION *= *"\(.*\)".*/s//\1/p' <$(VERSION_FILE))
GEMS := $(addprefix pkg/, $(addsuffix -$(VERSION).gem, $(PACKAGES)))

export RUBYLIB := $(RUBYLIB):test:lib

.PHONY: all
all: test $(GEMS)

.PHONY: test
test: $(DEPS)
	bin/test

.PHONY: clean
clean:
	rm pkg/*.gem

.PHONY: release
release: $(GEMS)
	for gem in $^; do gem push $$gem; done

pkg/%-$(VERSION).gem: %.gemspec $(VERSION_FILE) | pkg
	gem build $<
	mv $(@F) pkg/

$(DEPS): $(GEM_HOME) Gemfile
	bundle check || bundle install
	touch $@

pkg:
	mkdir -p $@

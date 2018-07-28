SOURCES = $(wildcard *.el | grep -v autoloader)
VERSION = $(shell cat yaml-path-pkg.el | head -n1 | awk '{print $$3}' | sed 's/"//g')

all: install

dist: yaml-path-$(VERSION).tar

yaml-path-$(VERSION).tar: $(SOURCES)
	@mkdir yaml-path-$(VERSION)
	@cp --parents -dR $(SOURCES) yaml-path-$(VERSION)/
	@tar cvf yaml-path-$(VERSION).tar yaml-path-$(VERSION)
	@rm -rf yaml-path-$(VERSION)

install: yaml-path-$(VERSION).tar
	@rm -rf ~/.emacs.d/elpa/yaml-path*/
	@emacs --batch --eval "(defconst pkg-to-install \"$(PWD)/yaml-path-$(VERSION).tar\")" -l vendor/emacs-pkg-install.el

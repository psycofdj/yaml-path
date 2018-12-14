GO     := go
GINKGO := ginkgo
PROMU  := $(GOPATH)/bin/promu
pkgs   = $(shell $(GO) list ./... | grep -v /vendor/)

PREFIX                  ?= $(shell pwd)
BIN_DIR                 ?= $(shell pwd)
TARBALLS_DIR            ?= $(shell pwd)/.tarballs
DOCKER_IMAGE_NAME       ?= githubrelease-exporter
DOCKER_IMAGE_TAG        ?= $(subst /,-,$(shell git rev-parse --abbrev-ref HEAD))
VERSION                  = $(shell cat VERSION)
VERSION_EMACS            = $(shell cat emacs/yaml-path-pkg.el | head -n1 | awk '{print $$3}' | sed 's/"//g')

all: format build test

deps:
	@$(GO) get github.com/onsi/ginkgo/ginkgo
	@$(GO) get github.com/onsi/gomega

format:
	@echo ">> formatting code"
	@$(GO) fmt $(pkgs)

style:
	@echo ">> checking code style"
	@! gofmt -d $(shell find . -path ./vendor -prune -o -name '*.go' -print) | grep '^'

vet:
	@echo ">> vetting code"
	@$(GO) vet $(pkgs)

test: deps
	@echo ">> running tests"
	@$(GINKGO) version
	@$(GINKGO) -r -race .

promu:
	@GOOS=$(shell uname -s | tr A-Z a-z) \
		GOARCH=$(subst x86_64,amd64,$(patsubst i%86,386,$(shell uname -m))) \
		$(GO) get -u github.com/prometheus/promu

emacs:
	@echo ">> building emacs tarball"
	@make -s -C emacs dist

build: promu emacs
	@echo ">> building binaries"
	@$(PROMU) build --prefix $(PREFIX)

crossbuild: promu
	@echo ">> building cross-platform binaries"
	@$(PROMU) crossbuild

tarball: build
	@echo ">> building release tarball"
	@$(PROMU) tarball --prefix $(PREFIX) $(BIN_DIR)

tarballs: crossbuild
	@echo ">> building release tarballs"
	@$(PROMU) crossbuild tarballs

release: promu emacs
	@echo ">> uploading tarballs to the Github release"
	@$(PROMU) release ${TARBALLS_DIR}
	@echo " > emacs/emacs-yaml-path-$(VERSION_EMACS).tar"
	@github-release upload -t v$(VERSION) -f emacs/emacs-yaml-path-$(VERSION_EMACS).tar -u psycofdj -r yaml-path --name emacs-yaml-path-$(VERSION_EMACS).tar
	@echo " > plugin/yaml-path.vim"
	@github-release upload -t v$(VERSION) -f plugin/yaml-path.vim -u psycofdj -r yaml-path --name yaml-path.vim

docker:
	@echo ">> building docker image"
	@docker build -t "$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" .

.PHONY: all deps format style vet test promu build crossbuild tarball tarballs release docker

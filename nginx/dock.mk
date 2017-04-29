###========================================================================
### An extendible Makefile for Docker
###
### The goal is to provide a set of common targets for Docker based
### projects, that can easily be overriden.
###
### Targets:
###
###   - init:    install/update dock.mk accordingly
###
###   - exec:    execute a given command in a given container
###
###   - run:     run a container of the current image
###
###   - stop:    stop the container of the current name
###
###   - kill:    kill the container of the current name
###
###   - clean:   removes dock.mk installation and the container
###              of the current name
###
###   - build:   create an image for the current Dockerfile
###              automatically tagged
###
###   - publish: publish the current tag of the image to
###              the internal docker hub
###
###   - tag:     used to override the tag on build and publish
###
###   - remove:  remove the container of the current name
###
###========================================================================
.PHONY: all init exec run stop kill build publish tag clean remove stats
.PHONY: dockmk_exec dockmk_run dockmk_stop dockmk_kill dockmk_build
.PHONY: dockmk_publish dockmk_tag dockmk_clean dockmk_remove dockmk_stats

## Checks
###========================================================================
ifndef CONTAINER_NAME
  $(error CONTAINER_NAME should be defined)
endif

ifndef PROJECT
  $(error PROJECT should be defined)
endif

ifndef TEAM
  $(error TEAM should be defined)
endif

ifndef REGISTRY
  $(error REGISTRY should be defined)
endif

## Settings
## ========================================================================
DOCKERFILE ?= .

RUN_OPTS   ?= --rm -ti
EXEC_OPTS  ?= -ti
BUILD_OPTS ?=
CMD        ?= /bin/sh
ARGS       ?=

## Internal Definitions
## ========================================================================
DOCKMK          := dock.mk
DOCKER          := $(shell docker info >/dev/null 2>&1 && echo "docker" || echo "sudo docker")
GIT_BRANCH      := $(shell git rev-parse --abbrev-ref HEAD 2> /dev/null)
GIT_COMMIT      := $(shell git rev-parse --short HEAD 2> /dev/null)
TAG             ?= $(GIT_BRANCH).$(GIT_COMMIT)
IMAGE_NAME      := $(REGISTRY)/$(TEAM)/$(PROJECT):$(TAG)

## Targets
## ========================================================================

# This target is required by all Make files including dock.mk. It allows
# those Make files to override it and define which targets will be executed
# when running Make without explicit targets (i.e. make).
all::

init: ; @true

exec:: | dockmk_exec
dockmk_exec::
	$(DOCKER) exec $(EXEC_OPTS) $(CONTAINER_NAME) $(CMD)

run:: | dockmk_run
dockmk_run::
	$(DOCKER) run $(RUN_OPTS) --name $(CONTAINER_NAME) $(IMAGE_NAME) $(ARGS)

stop:: | dockmk_stop
dockmk_stop::
	-$(DOCKER) stop $(CONTAINER_NAME)

kill:: | dockmk_kill
dockmk_kill::
	$(DOCKER) kill $(CONTAINER_NAME)

build:: | dockmk_build
dockmk_build::
	$(DOCKER) build $(BUILD_OPTS) -t $(IMAGE_NAME) $(DOCKERFILE)

publish:: | dockmk_publish
dockmk_publish:: | dockmk_build
	$(DOCKER) push $(IMAGE_NAME)

tag:: | dockmk_tag
dockmk_tag::
	make build publish TAG=$(TAG)

clean:: | dockmk_clean
dockmk_clean:: | dockmk_remove
	rm -f dock.mk
	rm -f .dockmk-vsn-*

remove:: | dockmk_remove
dockmk_remove:: | dockmk_stop
	-$(DOCKER) rm $(CONTAINER_NAME)

stats:: | dockmk_stats
dockmk_stats::
	$(DOCKER) stats --no-stream `$(DOCKER) ps | grep "$(CONTAINER_NAME)" | grep Up | awk '{ print $$NF }' | xargs`

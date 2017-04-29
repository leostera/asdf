.PHONY: dock.mk ALWAYS

## Settings
##=========================================================================
export

PROJECT     := nginx-playground
TEAM        := ostera
REGISTRY    := local

RUN_OPTS = --rm -ti \
					 -v $(PWD)/etc/nginx/nginx.conf:/etc/nginx/nginx.conf \
					 -p 8080:80

CONTAINER_NAME := $(PROJECT)

DOCKMK_VSN  := master

## Targets
##=========================================================================
all:: build

logs:
	make exec CMD="tail -f /var/log/nginx/access.log"

reload:
	make exec CMD="nginx -s reload"

## Bootstrap targets
## ========================================================================
-include dock.mk

# bootstrap dock.mk (implicitly called by 'include dock.mk')
DOCKMK_VSN_FILE=.dockmk-vsn-$(DOCKMK_VSN)
dock.mk: $(DOCKMK_VSN_FILE)
$(DOCKMK_VSN_FILE):
	git archive --remote=https://github.com/ostera/dock.mk.git $(DOCKMK_VSN) dock.mk | tar x
	rm -f .dockmk-vsn-* && touch $(DOCKMK_VSN_FILE)

# match any target not defined nor included in this Make file
%: ALWAYS ; @$(MAKE) -s -f dock.mk $*
ALWAYS:

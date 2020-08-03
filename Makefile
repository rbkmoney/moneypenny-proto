THRIFT = $(or $(shell which thrift), $(error "`thrift' executable missing"))
REBAR = $(shell which rebar3 2>/dev/null || which ./rebar3)
SUBMODULES = build_utils
SUBTARGETS = $(patsubst %,%/.git,$(SUBMODULES))

UTILS_PATH := build_utils
TEMPLATES_PATH := .

# Name of the service
SERVICE_NAME := moneypenny-proto

# Build image tag to be used
BUILD_IMAGE_TAG := bdc05544014b3475c8e0726d3b3d6fc81b09db96
CALL_ANYWHERE := \
	all submodules rebar-update compile clean distclean

CALL_W_CONTAINER := $(CALL_ANYWHERE)

all: compile

-include $(UTILS_PATH)/make_lib/utils_container.mk

.PHONY: $(CALL_W_CONTAINER)

# CALL_ANYWHERE
$(SUBTARGETS): %/.git: %
	git submodule update --init $<
	touch $@

submodules: $(SUBTARGETS)

rebar-update:
	$(REBAR) update

compile:
	$(REBAR) compile

clean:
	$(REBAR) clean

distclean:
	$(REBAR) clean -a
	rm -rfv _build _builds _cache _steps _temp

include $(UTILS_PATH)/make_lib/java_proto.mk

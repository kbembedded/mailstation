SUBDIRS := $(wildcard */.)
SUBDIRS := $(filter-out misc, $(SUBDIRS))

.PHONY: clean all $(SUBDIRS)

all: $(SUBDIRS)
clean: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

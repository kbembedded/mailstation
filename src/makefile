SUBDIRS := $(wildcard */.)
SUBDIRS := $(filter-out include/. host/., $(SUBDIRS))

.PHONY: clean all $(SUBDIRS)

all: $(SUBDIRS)
clean: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

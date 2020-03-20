SUBDIRS := $(wildcard */.)
SUBDIRS := $(filter-out include/., $(SUBDIRS))

.PHONY: clean all $(SUBDIRS)

all: $(SUBDIRS)
clean: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

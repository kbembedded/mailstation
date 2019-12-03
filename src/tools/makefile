SUBDIRS := $(wildcard */.)

.PHONY: clean all $(SUBDIRS)

all: $(SUBDIRS)
clean: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

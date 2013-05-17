.SUFFIXES: .d .o

OBJECTS = Trie.o

all: $(OBJECTS)
	dmd	$(OBJECTS)


.d.o:
	dmd -c -unittest $<


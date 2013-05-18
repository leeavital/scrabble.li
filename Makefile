.SUFFIXES: .d .o

OBJECTS = Trie.o Rack.o

all: $(OBJECTS)
	dmd	$(OBJECTS)


.d.o:
	dmd -c -unittest $<


clean:
	rm Trie
	rm *.o
 

.SUFFIXES: .d .o

OBJECTS = trie.o rack.o main.o board.o solver.o move.o position.o

all: $(OBJECTS)
	dmd	-ofmain $(OBJECTS)


.d.o:
	dmd -c -unittest $<


clean:
	rm main
	rm *.o
 

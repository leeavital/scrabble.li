.SUFFIXES: .d .o

OBJECTS = trie.o rack.o main.o board.o gaddag.o solver.o

all: $(OBJECTS)
	dmd	-ofmain $(OBJECTS)


.d.o:
	dmd -c -unittest $<


clean:
	rm main
	rm *.o
 

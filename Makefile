.SUFFIXES: .d .o

OBJECTS = Trie.o Rack.o main.o Board.o

all: $(OBJECTS)
	dmd	-ofmain $(OBJECTS)


.d.o:
	dmd -c -unittest $<


clean:
	rm main
	rm *.o
 

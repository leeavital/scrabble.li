.SUFFIXES: .d .o

OBJECTS = trie.o rack.o main.o board.o solver.o move.o position.o constants.o

all: $(OBJECTS)
	dmd	-ofmain $(OBJECTS)


.d.o:
	dmd -c -unittest $<


docs:
	dmd -c -D board.d	
	dmd -c -D constants.d
	dmd -c -D move.d
	dmd -c -D position.d
	dmd -c -D rack.d
	dmd -c -D solver.d
	dmd -c -D trie.d
	mkdir -p docs
	mv *.html docs

	
	


clean:
	rm main
	rm *.o
 

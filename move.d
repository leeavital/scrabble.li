/**
 * @author Lee Avital
 * 
 * A structure to represent a scrabble move
 * each move has a position and a word
 */

module move;

import std.format;
import std.array;
import position;


struct Move{
   Position position;
   string word;
   this(int x, int y, string w){
	  position = Position(x, y);
	  word = w;
   };
   string toString(){
	  auto writer = appender!string();
	  formattedWrite( writer, "%s at (%d, %d)", word, position.x, position.y );
	  return writer.data;
   };

   bool opEquals(Move m){
	  return m.position.x == position.x && m.position.y == position.y && m.word == word;
   };

   hash_t toHash(){
	  return position.x + position.y;
   };


   int opCmp( Move m ){
	  if( position.x != m.position.x ){	  
		 return position.x - m.position.x;
	  }


	  if( position.y != m.position.y ){	  
		 return position.y - m.position.y;
	  }

	  else if( word != m.word ){
		 
		 if( word < m.word ){
			return -1;
		 }else{
			return 1;
		 }	
	  }

	  return 0;

   }
   
}

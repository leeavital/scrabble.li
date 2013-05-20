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
   }

   

}

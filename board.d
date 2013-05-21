module Board;

import std.stdio;
import std.format;
import std.array;
import position;

/**
 * Represents a scrabble board
 */
class Board{

   char[26][26] board;

   this(){

	  // fill up the board with blank spaces
	  for( auto i = 0; i < 26; i++){
		 for( auto j = 0; j < 26; j++){
			board[i][j] = ' ';
		 }
	  }
   
   }
   

   /**
    * allow a board to be accessed with the index operator
	*/
   const char opIndex( int i, int j ){
	  return board[i][j];
   }

   
   /** 
    * allow the board to be accessed with a Position
    */
   const char opIndex( const Position p ){
	  return board[ p.x ][ p.y ];
   }

   /**
    * allow the board to be index assigned
	*/
   void opIndexAssign( char c, int i, int j){
	  //writefln("assigning %d %d as %c", i, j, c );
	  board[i][j] = c;
   }


   
   /**
    * print out the board
	*/
   override string toString(){
	  
	  
	  
	  auto writer = appender!string(); 
	  
	  
	  
	  formattedWrite( writer, "---" );
	   
	  for(int i = 0; i < 26; i++){
		 
		 formattedWrite( writer, "%-2d ", i );
	  
	  }
	  
	  formattedWrite( writer, "\n" );

	  for( auto y = 0; y < 26; y++ ){
		 
		 formattedWrite( writer,  "%-3d", y );
		 
		 for( int x = 0; x < 26; x++){
			
			auto thechar = board[x][y];
			if(thechar == ' '){  thechar = '-'; }

			formattedWrite( writer, "%c  ", thechar );
		 }

		 formattedWrite( writer, "\n" );

		 	 
	  }


	  return writer.data;
   }


}



unittest{
   
   auto b = new Board;
   b[0, 5] = 'J';
   
   assert( b[0, 5] == 'J', "failed index test" );

   writeln("finished unittest 1 for board");
}

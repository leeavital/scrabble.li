module Board;

import std.stdio;


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
   char opIndex( int i, int j ){
	  return board[i][j];
   }

   /**
    * allow the board to be index assigned
	*/
   void opIndexAssign( char c, int i, int j){
	  writefln("assigning %d %d as %c", i, j, c );
	  board[i][j] = c;
   }
}



unittest{
   
   auto b = new Board;
   b[0, 5] = 'J';
   
   assert( b[0, 5] == 'J', "failed index test" );

   writeln("finished unittest 1 for board");
}

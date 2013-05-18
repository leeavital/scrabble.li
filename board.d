module Board;

import std.stdio;


class Board{

   char[26][26] board;

   this(){
   }

   char opIndex( int i, int j ){
	  return board[i][j];
   }


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

import trie;
import rack;
import board;
import solver;
import std.stdio;

int main( string[] args ){

   writefln("starting the main function (unittests passed)");
   
   // writeln( args );

   // if( args[1] == "printboard" ){
   //    
   //    auto b = readBoard( ".board" );
   //    writeln( b );

   // }


   

    
   auto dictionary = getEnglishDictionary();
   auto board = new Board();
   auto rack = new Rack();
   rack.add( 'F' );
   rack.add( 'N' );
   rack.add( 'L' );
   
  
 
   // board[12,14] = 'N'; 
   board[13,13] = 'A';
   board[14,13] = 'I';
   board[15,13] = 'R';

   
   
   writefln("initial board");   
   writeln( board );


   writefln("initial rack");
   writeln(rack);

    
   solve( board, dictionary, rack );

   return 1;
}  



Board readBoard( string filename ){
   auto board = new  Board;
   auto f = File( ".board" , "r");

   for(int y = 0; y < 26; y ++ ){
	  auto line = f.readln();

	  writefln("read a line of length: %d", line.length );

	  for(int x = 0; x < 26; x++ ){
		 board[x,y] = line[x];
	  }


	  y++;
   }

   return board;
}

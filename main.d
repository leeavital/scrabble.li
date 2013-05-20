import trie;
import rack;
import board;
import solver;
import std.stdio;

int main( string[] args ){

   writefln("starting the main function (unittests passed)");
   
   writeln( args );

   if( args[1] == "printboard" ){
	  
	  auto b = readBoard( ".board" );
	  writeln( b );

   }

   
   return 1;

   

    
   auto dictionary = getEnglishDictionary();
   auto board = new Board();
   auto rack = new Rack();
   rack.add( 'B' );
   rack.add( 'R' );
   rack.add( 'S' );
   
    
   board[4, 2] = 'E';    
   board[5, 2] = 'E';
   board[5, 3] = 'R';
   
   writefln("initial board");   
   writeln( board );


   writefln("initial rack");
   writeln(rack);

    
   solve( board, dictionary, rack );

   return 1;
}  



Board readBoard( string filename ){
   return ;
}

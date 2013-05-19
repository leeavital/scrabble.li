import trie;
import rack;
import board;
import solver;
import std.stdio;

int main(){

   writefln("starting the main function (unittests passed)");

   // don't do anything
      
   auto dictionary = getEnglishDictionary();
   auto board = new Board();
   auto rack = new Rack();
   rack.add( 'C' );
   rack.add( 'A' );
   rack.add( 'T' );
   rack.add( 'S' );
   rack.add( 'T' );
   rack.add( 'E' );   
   
    
   board[4, 2] = 'E';    
   board[5, 3] = 'O';
   board[6,3] = 'R'; 
   
   writefln("initial board");   
   writeln( board );


   writefln("initial rack");
   writeln(rack);

    
   solve( board, dictionary, rack );

   return 1;
}  

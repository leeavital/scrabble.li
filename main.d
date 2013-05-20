import trie;
import rack;
import board;
import solver;
import std.stdio;

int main(){

   writefln("starting the main function (unittests passed)");

    
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

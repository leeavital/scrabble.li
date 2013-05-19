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
   
   
    
   board[4, 2] = 'S';    
   
   
   solve( board, dictionary, rack );

   return 1;
}  

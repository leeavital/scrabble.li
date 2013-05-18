import trie;
import rack;
import board;
import solver;


int main(){
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

module solver;

import board;
import trie;
import rack;


struct Position{
   int x;
   int y;
   Position left(){
	  return Position(x + 1, y );
   };
   Position right(){
	  return Position(x - 1, y);
   };
   Position above(){
	  return Position(x, y - 1);
   };
   Position below(){
	  return Position(x, y + 1);
   };
}


Board theboard;
TrieNode dictionary;



void solve( Board b, TrieNode d, Rack rack ){ 
   theboard = b;
   dictionary = d;
    
   
     
   // compute the possible anchor squares 
   
    
	// for now only use one
    auto anchor = Position(2, 2);
   
    extendLeft( "", rack, anchor, 1);
      
   
    
}


void extendLeft(  string prefix, Rack rack, Position anchor, int limit ){
   
   // extendRight .. 
   
    
   if(limit > 0){
	  
	  // go through the rack 
	  foreach(int i, char c; rack.letters ){
		 
		 // place the letter and remove it from the rack
		 rack.remove( c );
		 
		  		 
		  
		 // attempt to extendLeft more
		 
		 // remove the letter from the board and put it back on the rack:w
		  

		 
		 		  
	  }
	  
   }

}

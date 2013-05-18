module solver;

import board;
import trie;
import rack;
import std.stdio;


struct Position{
   int x;
   int y;
   Position left(){
	  return Position(x - 1, y );
   };
   Position right(){
	  return Position(x + 1, y);
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
Rack therack;


void solve( Board b, TrieNode d, Rack r){ 
   theboard = b;
   dictionary = d;
   therack = r; 
   // compute the possible anchor squares 
	
    writefln("solver with %s", therack );

	// for now only use one
    auto anchor = Position(2, 2);
   
    extendLeft( "", dictionary, anchor, 2 ); 
   
    
}


void extendLeft(  string prefix, TrieNode n, Position anchor, int limit ){
 
   extendRight( prefix, n, anchor);
   
   if( limit > 0 ){
	  
	  for( int i = 0; i < therack.size; i++ ){
		 
		 auto c = therack.letters[i];
		 auto childNode = n.search( c ~ "" );
		 
		 if( ! (childNode is null) ){
			therack.remove( c );
			extendLeft( prefix ~ c, childNode, anchor, limit - 1 );
			therack.add( c );
		 }
		 
	  }


   }
   

}



void extendRight( string prefix, TrieNode n, Position anchor ){
  


   
   
   // if the square is vacant 
   if( theboard[anchor.x, anchor.y] == ' '  ){
	  if( n.isWord ){
		 writefln("found a word at: %s", prefix);
	  }else{
		 
		 for( auto i = 0; i < therack.size; i++ ){
			
			auto c = therack.letters[i];
			auto subNode = n.search( "" ~ c );		
			
			writefln("trying %c on the right", c );	

			if( ! ( subNode is null ) && checkCrossSet(c, anchor) ){
			   	   
			   therack.remove( c );
			   extendRight( prefix ~ c, subNode, anchor.right() );
			   therack.add( c );
			}


		 }

	  }
   }

   else{
	  auto c = theboard[anchor.x, anchor.y];
	  
	  auto subNode = n.search( c ~ "" );
		 
	  if( !(subNode is null) ){
		 extendRight( prefix ~ c, subNode, anchor.right() );
	  }else{
		 // won't make any words
	  }
   }


}


bool checkCrossSet( char c, Position anchor ){
   return true;
}

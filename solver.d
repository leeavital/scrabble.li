module solver;

import board;
import trie;
import rack;
import std.stdio;


struct Position{
   int x;
   int y;
   @property Position left(){
	  return Position(x - 1, y );
   };
   @property Position right(){
	  return Position(x + 1, y);
   };
   @property Position above(){
	  return Position(x, y - 1);
   };
   @property Position below(){
	  return Position(x, y + 1);
   };
}



struct Move{
   Position position;
   string word;
}


Board theboard;
TrieNode dictionary;
Rack therack;


void solve( Board b, TrieNode d, Rack r){ 
   theboard = b;
   dictionary = d;
   therack = r; 
   // compute the possible anchor squares 
	

	// for now only use one
    auto anchor = Position(3, 2);
   
    extendLeft( "", dictionary, anchor, 2 ); 
   
    
}


void extendLeft(  string prefix, TrieNode n, Position anchor, int limit ){
 
   extendRight( prefix, n, anchor);
   
   if( limit > 0 ){
	  
	  for( int i = 0; i < therack.size; i++ ){
		 
		 auto c = therack[i];
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
		 
		 // record a move here
		 auto leftPos = Position( anchor.x - cast(int)prefix.length, anchor.y);
		 writefln("found a word at: %s from (%d, %d) to (%d, %d)", 
			prefix, leftPos.x, leftPos.y, anchor.x, anchor.y);
	  }else{
		 
		 for( auto i = 0; i < therack.size; i++ ){
			
			auto c = therack[i];
			auto subNode = n.search( "" ~ c );		
			

			if( ! ( subNode is null ) && checkCrossSet(c, anchor) ){
			   	   
			   therack.remove( c );
			   extendRight( prefix ~ c, subNode, anchor.right );
			   therack.add( c );
			}


		 }

	  }
   }

   else{
	  auto c = theboard[anchor.x, anchor.y];
	  
	  auto subNode = n.search( c ~ "" );
		 
	  if( !(subNode is null) ){
		 extendRight( prefix ~ c, subNode, anchor.right );
	  }else{
		 // won't make any words
	  }
   }


}



bool checkCrossSet( char c, Position anchor ){
   
   // get all of the letters directly above
   auto strAbove = "";
   auto nodeAbove = anchor.above;

   while( theboard[ nodeAbove.x, nodeAbove.y ] != ' ' ){
	  strAbove = theboard[nodeAbove.x, nodeAbove.y] ~ strAbove;
	  nodeAbove = nodeAbove.above;
   }

   // get all of the letters below
   auto strBelow = "";
   auto nodeBelow = anchor.below;

   
   while( theboard[ nodeBelow.x, nodeBelow.y ] != ' ' ){
	  strBelow ~= theboard[nodeBelow.x, nodeBelow.y];
	  nodeBelow = nodeBelow.below;
   }
   
   

   // concat:
   // above + this + below
   auto crossStr = strAbove ~ c ~ strBelow;
   
   // return isWord( above )
   return crossStr.length == 1 || dictionary.contains( crossStr );
}

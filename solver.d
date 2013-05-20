module solver;


import board;
import trie;
import rack;
import position;
import move;
import constants;
import std.stdio;
import std.array;
import std.format;


Board theboard;
TrieNode dictionary;
Rack therack;
int[Move] moves;







void solve( Board b, TrieNode d, Rack r){ 
   
   theboard = b;
   dictionary = d;
   therack = r; 
   // compute the possible anchor squares
   
    
   for( int x = 0; x < 26; x++ ){
	  
	  for( int y = 0; y < 26; y++ ){
		 
		  
		 auto pos = Position(x, y);

		 
		 if( theboard[pos.x, pos.y] != ' ' ) {
			
			writeln( "nonblank at ", pos );
				

			if ( theboard[pos.left] == ' ' && pos.left.x < 26 ){
			   extendLeft( "", dictionary, pos.left, 1 );
			}

		 }


	  }

   }
   
   // extendLeft( "", dictionary, anchor, 3 ); 
   
   foreach(Move m, int s; moves){
     
     writefln("%s will score %d points", m, s);
      
   }
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
		 //  writefln("found a word at: %s from (%d, %d) to (%d, %d)", 
		 // 	prefix, leftPos.x, leftPos.y, anchor.x, anchor.y);
		 

		 // record the move
		 auto m = Move( leftPos.x, leftPos.y, prefix );
		 moves[ m ] = evaluateMove( theboard, m );

		 

	  }
		 
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




/**
 * evaluate a move and return the number of points scored
 * 
 * @param b the board on which the move is played
 * @param m the move to be evaluated 
 */
int evaluateMove( Board b, Move m){
   
   
   auto startSquare = m.position;
   
   // count the total
   auto total = 0;

   // keep track of the multiplier
   auto multiplier = 1;

   foreach( ulong i; 0 .. m.word.length ){
	  
	  total += LETTER_VALUES[ m.word[ i ] ];
	  
	    	  
   }


   return total;
}





/**
 * check to see if a given character is in a positions cross set
 * i.e. , if A is the word above and B is below, is AcB a word?
 *
 * @param c the character to check
 * @param anchor the position at which to check
 */
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

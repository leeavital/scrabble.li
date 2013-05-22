/**
 * @author Lee Avital
 *
 * Holds various functions used for generating
 * and evaluating scrabble moves
 */

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




/**
 * find the union of two hash sets
 * 
 * Ideally, the first parameter is larger but it will work both ways
 */
T[V] set_union(T, V)(T[V] a, T[V] b){
   
   
   // if a is smaller than b, add everything in a to b 
   if( a.length < b.length ){
	  foreach(V v, T t; a){
   	     b[v] = t;
   	  }
	  return b;
   }

   // if b is smaller than a, add everything in b to a 
   else{
	  
	  foreach(V v, T t; b){
   	     a[v] = t;
   	  }

	  return a;
   }

}


/**
 * solve
 * @param b  the board to solve
 * @param d  the first node in a DAWG that holds all valid words
 * @param r  the rack
 */
void solve( Board b, TrieNode d, Rack r){ 
   
   theboard = b;
   dictionary = d;
   therack = r; 
   int[Move] moves;
   // compute the possible anchor squares
   
     
   for( int x = 0; x < 26; x++ ){
	  
	  for( int y = 0; y < 26; y++ ){
		 
		 auto pos = Position(x, y);
		 
		 if( theboard[pos.x, pos.y] != ' ' ) {
			   
			if ( theboard[pos.left] == ' ' && pos.left.x < 26 ){
			   
			   auto poss = extendLeft( "", dictionary, pos.left, 3 );

			   moves = set_union( moves, poss );
			}
		 }
	  }
   }

   
   foreach(Move m, int s; moves){
     
     writefln("%s will score %d points", m, s);
      
   }
}


int[Move] extendLeft( string prefix, TrieNode n, Position anchor, int limit){ 
   
 
   int[Move] moves; 
   
   
   // first extend right from the anchor without placing any tiles on the left 
   moves = set_union( extendRight( prefix, n, anchor), moves );
  
   // if we have more room to the left, we can generate a prefix and test with it 
   if( limit > 0 ){
	  
	  foreach( char c; therack.characters ){
		 
		 auto childNode = n.search( c ~ "" );
		 
		 if( ! (childNode is null) ){
			therack.remove( c );
			moves = set_union( extendLeft( prefix ~ c, childNode, anchor, limit - 1 ), moves );
			therack.add( c );
		 } 
		 
	  }


   }

   return moves;
   

}



int[Move] extendRight( string prefix, TrieNode n, Position anchor){
   
   int[Move] moves;
    
   // if the square is vacant 
   if( theboard[anchor.x, anchor.y] == ' '  ){
	  if( n.isWord ){
		 
		 writefln("recording %s", prefix );
		  
		 // record a move here
		 auto leftPos = Position( anchor.x - cast(int)prefix.length, anchor.y);
		 

		 // record the move
		 auto m = Move( leftPos.x, leftPos.y, prefix );

		 
		 moves[ m ] = evaluateMove( theboard, m );

		 

	  }
		 
	  foreach( char c; therack.characters){
		 
		  
		  
	     auto subNode = n.search( "" ~ c );		
	     
		 writefln("trying to place: %c at %s", c, anchor );
		 
	     if( ! ( subNode is null ) && checkCrossSet(c, anchor) ){
	        	   
	        therack.remove( c );
	        moves = set_union( extendRight( prefix ~ c, subNode, anchor.right), moves );
	        therack.add( c );
	     }
	  
	  
	  
	  }
   }

   else{

	  auto c = theboard[anchor.x, anchor.y];
	  
	  writefln("found an adjacent: %c", c );

	  auto subNode = n.search( c ~ "" );
		 
	  if( !(subNode is null) ){
		 moves = set_union( extendRight( prefix ~ c, subNode, anchor.right), moves );
	  }else{
		 // won't make any words
	  }
   }

   
   return moves;
}




/**
 * evaluate a move and return the number of points scored
 * 
 * @param b the board on which the move is played
 * @param m the move to be evaluated 
 */
int evaluateMove( Board b, Move m){
   
   // count the total
   auto total = 0;

   // keep track of the multiplier
   auto multiplier = 1;
   
   // keep track of a position (moving right)
   auto currPos = m.position; 
   
   foreach( ulong i; 0 .. m.word.length ){
	  
	  total += LETTER_VALUES[ m.word[ i ] ] * b.getLetterMultiplier( currPos );
	  multiplier *= b.getWordMultiplier( currPos );
	   
	  // figure out if we need a cross set
	  if( b[ currPos.above ] != ' ' || b[ currPos.below ] != ' ' ){
		 

		 auto tileptr = currPos.above;
		 while( b[tileptr] != ' '){
			total += LETTER_VALUES[ b[tileptr] ];
			tileptr = tileptr.above;

		 }



		 tileptr = currPos.below;
		 while( b[tileptr] != ' '){
			total += LETTER_VALUES[ b[tileptr] ];
			tileptr = tileptr.below;
		 }

		 // double count this letter because it's both a down word and an accros word
		 total += LETTER_VALUES[ m.word[i] ];

	  }
	  
	  // move the position pointer right
	  currPos = currPos.right;
	    	  
   }
   return total * multiplier;
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






// unit test for evaluateMove()
unittest{
   
   auto b = new Board();
   
   auto m = Move(3,3,"FOO");
  
   // simple case,  no cross sections 
   // Foo = 4 + 1 + 1
   assert( evaluateMove(b, m) == 6);
    


   // also, no cross set
   // FOOBAR = 4 + 1 + 1 + 3 + 1 + 1 = 11
   auto m2 = Move(3, 3, "FOOBAR");
   assert( evaluateMove(b, m2 ) ==  11);
   
   
   b[3,4] = 'O';
   auto m3 = Move(3, 3, "SO");
   
    
   // one cross set on the first character
   assert( evaluateMove(b, m3) == 4 );
       
   writefln("finished unittest 1 for evaluateMove");
}




unittest{

   int[string] d1;
   int[string] d2;

   d1["two"] = 2;
   d2["three"] = 3;
   d2["four"] = 4;

   auto d3 = set_union( d1, d2 );
   
   // test small -- big case 
   assert( d3.length == 3 );
   assert( d3["four"] == 4 );
   assert( d3["three"] == 3 );
   assert( d3["two"] == 2 );
   
   
   // this is the big -- small case
   d3 = set_union( d2, d1 );

   assert( d3.length == 3 );
   assert( d3["four"] == 4 );
   assert( d3["three"] == 3 );
   assert( d3["two"] == 2 );

   writeln( "finished unittest 1 for set_union" );
}



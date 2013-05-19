module trie;

import std.stdio;
import std.string;
import std.file;




/**
 * wrapper class
 */
class Trie{
   
   TrieNode root;
   
   
   this(){
	  root = new TrieNode();
   }
     
   void put( string s ){
	  root.put( s.toUpper() );
   }
   
   
   bool contains( string s){
	  return root.contains( s.toUpper() );	  
   }


}



TrieNode getEnglishDictionary(){
   
   auto root = new TrieNode;
   
   auto txt = File( "dictionary.txt" );
   
   while( ! txt.eof ){ 
	  auto line = txt.readln();
	  line = line.strip();
	  

	  root.put( line );
   }
   
    
   return root;

}




class TrieNode{

   TrieNode[] children;
   bool isWord;

   this(){
	  children = new TrieNode[26];
	  isWord = false;
   }
   

   void put( string s ){
	  

	  if( s == ""){
		 this.isWord = true;
	  }else{
		 
		  
		 auto first = s[0];
		 auto tail = s[1..$];
		 
		 // the array index where the subtrie will appear
		 auto childIndex = (first - 65) % 32;

		 // make sure the subTrieNode already exists 
		 if( children[childIndex] is null ){
			children[ childIndex ] = new TrieNode;
		 }
		 
		 // recurse
		 children[childIndex].put( tail );

	  }
   }

   
   /**
    * @return true if the TrieNode contains string s
	*/
   bool contains( string s ){
	  if( s == "" ){
		 return isWord;
	  }

	  else{
		 
		 auto head = s[0];
		 auto tail = s[1..$];		 
		 auto childIndex = (head - 65) % 32;

		 if( children[ childIndex ] is null ){
			return false;
		 }else{
			return children[ childIndex ].contains( tail );
		 }
	  }
   }



   TrieNode search( string s ){
	  
	   
	  if(s == "" ){
		 return this;
	  }else{
		 
		 auto head = s[0];
		 auto tail = s[1..$];
		 auto childIndex = head - 65;
		 
		 if( children[ childIndex ] is  null ){
			return null;
		 }else{
			return children[childIndex].search( tail );
		 }


		  
	  }

   }

}





// unit test one, tests internal structures
unittest{
   


   auto t1 = new TrieNode;
   t1.put( "HELLO" );
   

   assert( t1.contains("heLLO"), "failed test one" );
 
   assert( ! t1.contains("GOODBYE"), "failed test two" );
   
   assert( !  t1.contains("word"), "failed test three" );

   t1.put( "word" );


   assert( t1.contains("word"), "failed test four" );

   assert( ! (t1.search("WO").search("RD") is null), "failed find test 1");
   assert( t1.search("WO").search("ER") is null, "failed find test 2");


   writefln("finished unittest 1 for TrieNode");
}



// unittest 2
unittest{

   auto t1 = new Trie;
   t1.put( "HELLO" );
   

   assert( t1.contains("heLLO"), "failed test one" );
 
   assert( ! t1.contains("GOODBYE"), "failed test two" );
   
   assert( !  t1.contains("word"), "failed test three" );

   t1.put( "word" );


   assert( t1.contains("word"), "failed test four" );

   writefln("finished unittest 2 for Trie");


}



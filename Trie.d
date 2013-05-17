import std.stdio;
import std.array;
import std.string;



class Trie{

   Trie[] children;
   bool isWord;

   this(){
	  children = new Trie[26];
	  isWord = false;
   }
   

   void put( string s ){
	  if( s == ""){
		 this.isWord = true;
		 	 
	  }else{
		 
		 char first = s[0];
		 auto last = s[1..$];

	  }
   }


   bool contains( string s ){
	  return true;
   }



}





unittest{
   


   auto t1 = new Trie;
   t1.put( "hello" );

   assert( t1.contains("hello"), "failed test one" );
 
   assert( ! t1.contains("goodbye"), "failed test two" );

}


int main(){
   
   string s = "safasdf";
   auto t = back( s ); 
   writeln( t ); 
   return 1;
}

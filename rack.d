

import std.stdio;



/**
 * represents a Rack
 */
class Rack{
   
   
   private char letters[7];
   private int currentIndex = 0;
   

   @property auto size(){ return currentIndex; }


   this(){
	  currentIndex = 0;
   }

   
   /**
    * copy constructor
	*/
   this(Rack r){

	  letters = new char[ r.size ];

	  for(auto i = 0; i < r.size; i++){
		 letters[i] = r.letters[i];
	  }

   }

   
   /**
    * make the Rack index retreivable
	*/
   const char opIndex(int i){
	  return letters[i];
   }



   public void add(char c){

	  if( currentIndex >= 7 ){
		 throw new Exception( "out of range" );
	  }

	  letters[ currentIndex ] = c;
	  currentIndex++;
	  


   }

   public void remove( char c ){
	  auto i = 0;
	  for( ; i < 7; i++ ){
		 
		 if( letters[i] == c ){
			
			letters = letters[0..i] ~ letters[i+1..$] ~ new char[1];
			currentIndex --;
			return;
		 }
	  }
	   
   }

   override string toString(){
	  auto s = "";
	  for(int i = 0; i < currentIndex - 1; i++){
		 s ~= letters[i] ~ ", ";
	  }

	  s ~= letters[ currentIndex - 1 ];

	  return s;

   }
}


unittest{
   
   
   auto r = new Rack();
   assert( r.size == 0, "failed size test" );
   
   r.add('a');
   r.add('b'); 

   

   assert( r.toString() == "a, b" , "failed first toString test" );
   
   assert( r.size == 2, "failed size test 2" );

   r.add('c');
   r.add('d');
   r.add('e');
   r.add('f');
   r.add('g');

   assert( r.size == 7, "failed size test 3");
   
   try{
	  r.add('z');
	  assert( false, "added more than seven elements");
   }
   catch(Exception e){
	  // passed range test
   }


   r.remove('a');
   
   assert( r.size == 6, "failed remove" );
   assert( r.toString() == "b, c, d, e, f, g", "failed second toString test" );
    


   writefln("finished unittest 1 for Rack");

}



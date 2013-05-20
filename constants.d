module constants;


import std.stdio;


int[char] LETTER_VALUES;




// lolwut
static this(){

   writefln("initializing the constants module");

   foreach( char c; 'A' .. 'Z' ){
	 LETTER_VALUES[  c ] = 1; 	  
   }


}

module constants;


private int[] LETTER_VALUES = [];

auto getLetterValues( ){
    
   foreach( char c; 'A' .. 'Z' ){
	 LETTER_VALUES[  c ] = 1; 	  
   }
   return LETTER_VALUES;

}



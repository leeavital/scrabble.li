module constants;


import std.stdio;

int[char] LETTER_VALUES;


// lolwut
static this(){

   LETTER_VALUES['A'] = 1;
   LETTER_VALUES['B'] = 3;
   LETTER_VALUES['C'] = 3;
   LETTER_VALUES['D'] = 2;

   LETTER_VALUES['E'] = 1;
   LETTER_VALUES['F'] = 4;
   LETTER_VALUES['G'] = 2;
   LETTER_VALUES['H'] = 4;
   
   LETTER_VALUES['I'] = 1;
   LETTER_VALUES['J'] = 8;
   LETTER_VALUES['K'] = 5;
   LETTER_VALUES['L'] = 1;
  
   LETTER_VALUES['M'] = 3;
   LETTER_VALUES['N'] = 1;
   LETTER_VALUES['O'] = 1;
   LETTER_VALUES['P'] = 3;
 
   LETTER_VALUES['Q'] = 10;
   LETTER_VALUES['R'] = 1;
   LETTER_VALUES['S'] = 1;
   LETTER_VALUES['T'] = 1;
  
   LETTER_VALUES['U'] = 1;
   LETTER_VALUES['V'] = 4;
   LETTER_VALUES['W'] = 4;
   LETTER_VALUES['X'] = 8;

   LETTER_VALUES['Y'] = 4;
   LETTER_VALUES['Z'] = 10;
}

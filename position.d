/**
 * @author Lee Avital
 *
 * Holds the position struct which provides a semantically
 * superior way of representing scrabble board coordinates
 */

module position;



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



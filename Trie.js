/**
 * Construct a new Trie
 */
function Trie(){
   this.children = [];
   this.isWord = false;
}



/**
 * Put a word into the trie.
 * If the word is already in the trie, nothing will happen.
 * 
 * @param s the string to put into the trie
 * @return void
 */
Trie.prototype.put = function( s ){
   
   if( s == '' ){
	  this.isWord = true;
   }else{
	  var head = s[0];
	  var tail = s.substr(1);
	  var headIndex = this._getStringIndex( s );
	  

	  this.children[headIndex] = this.children[headIndex] || new Trie();

	  this.children[headIndex].put( tail );
   }

}


/**
 * Return true if the Trie contains s
 *
 * @param s the string that may or may not be in the trie
 * @return true if the string is in the trie, else false
 */
Trie.prototype.contains = function( s ){
   
   if( s == '' ){
	  return this.isWord;
   }else{
	  
	   
	  var head = s[0];
	  var tail = s.substr(1);
	  var headIndex = this._getStringIndex( s );
	  
	  return this.children[headIndex] !== null &&  this.children[headIndex].contains( tail );

   }


   
}



/**
 * Get the associated array index for any string
 */
Trie.prototype._getStringIndex = function( s ){
   return s.toUpperCase().charCodeAt(0) - 65;
}





var t = new Trie;
console.log(t.put( "hello" ));
console.log(t.put("hell"));
console.log(t.contains("hello"));

console.log(t.contains("hell"));



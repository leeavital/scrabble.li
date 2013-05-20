# write a blank board to .board
f = open(".board", "w")
for x in range(26):
   f.write( "".join( [" " for x in range(26) ] ) )
   f.write( "\n" )

f.close()

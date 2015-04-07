# Require
require 'socket'

# Ouverture connexion au serveur
socket = TCPSocket.new( 'localhost', 12345 )

# Envoi de donn�es
socket.print( "Salut c'est toto !" )
socket.close_write

# Reception de donn�es
puts socket.read

# Fermture connexion au serveur
socket.close

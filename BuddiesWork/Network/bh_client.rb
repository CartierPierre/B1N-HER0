# Require
require 'socket'

# Ouverture connexion au serveur
socket = TCPSocket.new( 'localhost', 12345 )

# Envoi de données
socket.print( "Salut c'est toto !" )
socket.close_write

# Reception de données
puts socket.read

# Fermture connexion au serveur
socket.close

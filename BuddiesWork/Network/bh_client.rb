# encoding: utf-8
Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

# Require
require 'socket'
require_relative "./requete"
require_relative "./reponse"

# Ouverture connexion au serveur
socket = TCPSocket.new( 'localhost', 12345 )
# socket.set_encoding 'ASCII-8BIT'

# Envoi de données
requete = Requete.creer( 1, 'toto', 'tata' )
puts requete.idCommande
puts requete.arguments
str = Marshal.dump( requete )
socket.print( str )
socket.close_write

# Reception de données
str = socket.read
reponse = Marshal.load( str )
puts "Réponse serveur : #{ reponse.contenu }"

# Fermture connexion au serveur
socket.close

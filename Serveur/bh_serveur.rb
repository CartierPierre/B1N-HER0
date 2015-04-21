# encoding: utf-8
Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

# Require
require 'socket'
require_relative "./Requete"
require_relative "./Reponse"
require_relative "./Traitement"

# Variables
port = 10101
traitement = Traitement.instance()

# Lancement du serveur
server = TCPServer.new( port )
puts "Serveur lancé sur le port #{ port }"

# Écoute de connexion entrantes
loop do
	Thread.start(server.accept) do |client|
		
		# Reception data
		str = client.gets()
		requete = Marshal.load( str )
		
		# Exploitation
		puts "IP: #{ client.addr[3] }, cmd: #{ requete.methode }, attr: #{ requete.arguments }"
		reponse = traitement.send( requete.methode )
		
		# Envoi data
		str = Marshal.dump( reponse )
		client.puts( str )
		
		# Fin connexion
		client.close()
		
	end
end

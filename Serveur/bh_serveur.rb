# encoding: utf-8
Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

# Require
require 'socket'
require_relative "./requete"
require_relative "./reponse"

# Variables
port = 10101

# Ouverture port
server = TCPServer.new('localhost', port)
# server.set_encoding 'ASCII-8BIT'
puts "Serveur lancé sur le port #{ port }"

loop do

	Thread.start(server.accept) do |client|
		
		# Reception data
		str = client.gets
		requete = Marshal.load( str )
		
		# Exploitation
		puts "IP: #{ client.addr[3] }, cmd: #{ requete.idCommande }, attr: #{ requete.arguments }"
		
		# Envoi data
		reponse = Reponse.creer( 'wip' )
		str = Marshal.dump( reponse )
		client.puts str
		
		# Fin connexion
		client.close
		
	end
	
end

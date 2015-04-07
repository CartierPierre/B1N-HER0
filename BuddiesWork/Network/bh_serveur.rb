# Require
require 'socket'

server = TCPServer.new('localhost', 12345)

loop do

	Thread.start(server.accept) do |client|
		
		# Debug
		puts client
		
		# Reception data
		puts client.gets
		
		# Envoi data
		client.puts "Hello World!"
		
		# Fin connexion
		client.close
		
	end
	
end

# Require
require 'socket'

server = TCPServer.new( 'localhost', 12345 )

loop do
	Thread.start(server.accept) do |client|
	
		puts client
		
		# while line = client.gets
			# puts line
		# end
		
		client.puts "Hello !"
		client.puts "Time is #{ Time.now }"
		
		client.close
		
	end
end

serveur.close

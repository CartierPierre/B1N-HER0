##
# Classe Serveur
#
# Version 2
#
class Serveur

	### Attributs d'instances
	
	# Thread
	# Processus fils d'un serveur
	@thread
	
	### Méthodes de classe
	
	##
	# Constructeur
	#
	def initialize()
		# @thread = nil
	end
	
	##
	# Instancie un serveur
	#
	def Serveur.creer()
		new()
	end
	private_class_method :new
	
	### Méthodes d'instances
	
	##
	# Démarre le serveur binhero sur le port spécifié
	#
	# ==== Paramètres
	# * +port+ - (int) Port à écouter
	#
	def demarrer( port, cheminLog )
	
		# Lancement du serveur dans un nouveau processus
		# @thread = Thread.new{
			
			# Lancement du serveur
			server = TCPServer.new( port )
			puts "Serveur lance sur le port : #{ port }"
			
			loop do
			
				# Création d'un nouveau thread pour chaque nouvelle connexion entrante
				# Thread.start(server.accept) do | client |
				client = server.accept
					
					# Réception de la requête du client
					str = client.read()
					requete = Marshal.load( str )
					
					# Traitement de la requête et construction d'une réponse
					# puts "IP: #{ client.peeraddr[3] }:#{ client.peeraddr[1] }, cmd: #{ requete.methode }, attr: #{ requete.arguments }"
					puts "IP: #{ client.peeraddr[3] }:#{ client.peeraddr[1] }, cmd: #{ requete.methode }"
					reponse = Traitement.instance().send( requete.methode, requete.arguments )
					
					# Envoi de la réponse au client
					str = Marshal.dump( reponse )
					client.puts( str )
					
					# Fermeture de la connexion
					client.close()
					
				# end
			end
		# }
	end
	
	##
	# Arrête le serveur
	#
	def arreter()
		@thread.exit()
	end

end

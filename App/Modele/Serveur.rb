##
# La classe Serveur permet de communiquer avec un serveur B1nHer0
# Utilise le DP Singleton
#
# Version 1
#
class Serveur

	### Attributs de classe
	
	@@instance = nil
	@@port = 10101
	@@hote = 'le-mans.kpw.ovh'
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def Serveur.instance
		if(@@instance == nil)
			@@instance = new
		end
		
		return @@instance;
	end
	
	##
	# Constructeur
	#
	def initialize
	end
	private_class_method :new
	
	### Méthodes d'instances
	
	##
	# Envoi une requête au serveur
	#
	# ==== Paramètres
	# * +r+ - (Requete) Requete à envoyer au serveur
	#
	# ==== Retour
	# Renvoi la réponse du serveur, false en cas d'erreur
	#
	def envoyerRequete( requete )
		begin
			# Ouverture connexion au serveur
			socket = TCPSocket.new( @@hote, @@port )
			
			# Envoi de données
			str = Marshal.dump( requete )
			socket.print( str )
			socket.close_write
			
			# Reception de données
			str = socket.read
			reponse = Marshal.load( str )
			
			# Fermture connexion au serveur
			socket.close
			
			return reponse
		rescue
			return false
		end
	end
	private :envoyerRequete
	
	##
	# Test la connexion avec le serveur et chronomètre le temps de réponse
	#
	# ==== Retour
	# Renvoi le temps de réponse ou false si il est impossible de communiquer avec le serveur
	#
	def testConnexion()
		t = Time.now
		reponse = envoyerRequete( Requete.creer( 'ping' ) )
		if( !reponse || reponse.contenu != 'pong' )
			return false
		end
		return ( Time.now - t ) * 1000
	end
	
	##
	# Demande la liste des ressources au serveur
	#
	def listeRessources()
	end
	
end
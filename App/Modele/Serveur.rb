##
# La classe Serveur permet de communiquer avec un serveur B1nHer0
# Utilise le DP Singleton
#
# Version 4
#
class Serveur

	### Attributs de classe
	
	@@instance = nil
	@@port = 10101
	# @@hote = 'le-mans.kpw.ovh'
	@@hote = 'localhost'
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def Serveur.instance()
		if(@@instance == nil)
			@@instance = new
		end
		
		return @@instance;
	end
	
	##
	# Constructeur
	#
	def initialize()
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
			# str = socket.recv
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
			return -1
		end
		return  ( Time.now - t ) * 1000
	end
	
	##
	# Demande les identifiants et version de toutes les ressources d'un utilisateur
	#
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Utlisateur dont l'on veut connaître les ressources et leurs versions
	#
	# ==== Retour
	# Renvoi la version de l'utilisateur sur le serveur et deux tableaux comportant des couple identifiant/version de la totalitée des ressources d'un utilisateur, le premier pour les sauvegardes et le second pour les scores
	#
	def listeRessources( utilisateur )
		reponse = envoyerRequete( Requete.creer( 'listeRessources', utilisateur.uuid ) )
		if( !reponse)
			return false
		end
		return reponse.contenu
	end
	
	##
	# Demande une suite de ressources au serveur
	#
	# ==== Paramètres
	# * +uuidUtilisateur - (int) uuid de l'utilisateur que l'on veut récupérer
	# * +uuidScores+ - (array int) Liste d'uuid de score que l'on veux récupérer
	# * +uuidSauvegardes+ - (array int) Liste d'uuid de sauvegarde que l'on veux récupérer
	#
	# ==== Retour
	# Renvoi un tableau multi-dimentionnel comportant l'intégralité des ressources demandées, false si une erreur c'est produite
	#
	def recupererRessources( uuidUtilisateur, uuidScores, uuidSauvegardes )
		reponse = envoyerRequete( Requete.creer( 'recupererRessources', uuidUtilisateur, uuidScores, uuidSauvegardes ) )
		if( !reponse)
			return false
		end
		return reponse.contenu
	end
	
	##
	# Envoi une suite de ressources au serveur
	#
	# ==== Paramètres
	# * +inserts+ - (scores) Liste d'uuid de score que l'on veux récupérer
	# * +updates+ - (sauvegardes) Utlisateur dont l'on veut connaître les ressources et leurs versions
	#
	# ==== Retour
	# Renvoi true si tout c'est bien passé, false si non
	#
	# def envoyerRessources( utilisateur, insertsScoresinsertsScores )
	def envoyerRessources( utilisateur, insertsScores, updatesScores, insertsSauvegardes, updatesSauvegardes )
		reponse = envoyerRequete( Requete.creer( 'envoyerRessources', utilisateur, insertsScores, updatesScores, insertsSauvegardes, updatesSauvegardes ) )
		if( !reponse || reponse.contenu != 'succes' )
			return false
		end
		return reponse.contenu
	end
	
end
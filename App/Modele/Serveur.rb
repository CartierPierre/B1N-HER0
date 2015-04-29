##
# La classe Serveur permet de communiquer avec un serveur B1nHer0
# Utilise le DP Singleton
#
# Version 9
#
class Serveur

	### Attributs de classe
	
	@@instance = nil
	@@port = 10101
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
			
			# Renvoi de la réponse serveur
			return reponse
		rescue
			raise "Erreur connexion !"
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
		envoyerRequete( Requete.creer( 'ping' ) )
		return  ( Time.now - t ) * 1000
	end
	
	##
	# Test si un utilisateur existe selon un pseudo et un mot de passe
	#
	# ==== Paramètres
	# * +nom+ - (string) Nom de l'utilisateur
	# * +motDePasse+ - (string) Mot de passe de l'utilisateur
	#
	# ==== Retour
	# Renvoi un object utilisateur si ce dernier à été trouvé sur le serveur, nil si non
	#
	def connexionUtilisateur( nom, motDePasse )
		reponse = envoyerRequete( Requete.creer( 'connexionUtilisateur', nom, motDePasse ) )
		return reponse.contenu
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
		return reponse.contenu
	end
	
	##
	# Demande une suite de ressources au serveur. Pour tous les paramètres qui suivent, mettre à nil si inutile.
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
		return reponse.contenu
	end
	
	##
	# Envoi une suite de ressources au serveur. Pour tous les paramètres qui suivent, mettre à nil si inutile.
	#
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Utilisateur à insérer ou à mettre à jour
	# * +scores+ - (array Score) Tableaux d'objets Score à ajouter ou à mettre à jour sur le serveur
	# * +sauvegardes+ - (array Score) Tableaux d'objets Sauvegardes à ajouter ou à mettre à jour sur le serveur
	#
	# ==== Retour
	# Pour chaque objet (Utilisateur, Score, Sauvegarde), renvoi l'id local transmit et le uuid correspondant, ou -1 si une erreur est survenu sur la ressource
	#
	def envoyerRessources( utilisateur, scores, sauvegardes )
		
		# Si un utilisateur est transmit
		if( utilisateur != nil )
			# On l'adapte pour la sérialisation
			utilServ = utilisateur.clone()
			utilServ.option = Option.serialiser( utilisateur.option )
			utilServ.statistique = nil
		end
		
		reponse = envoyerRequete( Requete.creer( 'envoyerRessources', utilServ, scores, sauvegardes ) )
		return reponse.contenu
	end
	
end
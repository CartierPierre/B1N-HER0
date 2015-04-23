##
# La classe Stockage permet d'utiliser le base de données local et de la syncroniser avec la base de données distante
# Utilise le DP Singleton
#
# Version 5
#
class Stockage
	
	### Attributs de classe
	
	@@instance = nil
	@@port = 10101
	@@hote = 'le-mans.kpw.ovh'
	
	
	### Attributs d'instances
	
	@bddLocal
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def Stockage.instance
		if(@@instance == nil)
			@@instance = new
		end
		
		return @@instance;
	end
	
	##
	# Constructeur
	#
	private_class_method :new
	def initialize
		# puts "Ouverture de la base de données ..."
		begin
			# @bddLocal = SQLite3::Database.new('./bdd-test.sqlite')
			@bddLocal = SQLite3::Database.new( File.dirname(__FILE__) + "/../Ressources/bdd.sqlite" )
			rescue SQLite3::Exception => err
				puts "Erreur"
				puts err
				abort
		end
		# puts "OK"
	end
	
	### Méthodes d'instances
	
	##
	# Execute une requête SQL sur la base de données locale
	#
	def executer(requete)
		# puts requete
		return @bddLocal.execute(requete)
	end
	
	##
	# Renvoi le dernier id créé lors d'une requête SQL sur la base de données locale
	#
	# ==== Retour
	# Renvoi un int
	#
	def dernierId()
		return @bddLocal.last_insert_row_id
	end
	
	##
	# Synchronise les données d'un utilisateur avec serveur
	# Ne fait rien si le type de l'utilisateur est 0
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont l'on veux synchroniser les données
	#
	def syncroniser(u)
		if( u.type == 1 )
			puts "Synchronosation des données de #{ u.nom }"
			puts "WIP"
		else
			puts "Les données de #{ u.nom } ne seront pas synchronisé"
		end
	end
	
	##
	#
	#
	def testConnexion()
		# Ouverture connexion au serveur
		socket = TCPSocket.new( @@hote, @@port )

		# Envoi de données
		requete = Requete.creer( 'ping' )
		# puts requete.idCommande
		# puts requete.arguments
		str = Marshal.dump( requete )
		socket.print( str )
		socket.close_write

		# Reception de données
		str = socket.read
		reponse = Marshal.load( str )
		puts "Réponse serveur : #{ reponse.contenu }"

		# Fermture connexion au serveur
		socket.close
	end
	
end

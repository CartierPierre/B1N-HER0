##
# La classe Data permet d'intéragir avec les données locales et distantes
#
# Cette classe implèmente le design patern Singleton
#
module Data

	@@bddLocal = null
	@@serverConnect = null
	
	@@dbPathFile = "./test.txt"
	@@serverIp = "b1nher0.kpw.ovh"
	@@serverPort = "123"
	
	##
	# Renvoi une instance
	#
	def new()
		/*
		if ( bddLocal == null )
		
		else
		
		end
		
		bddLocal = SQLite3::Database.new(pathDb);
		connexionServeur =
		*/
	end
	
	##
	# Test la connectivité avec le serveur
	#
	# ==== Retour
	# Renvoi true si la communication avec le serveur à réussi, false dans le cas contraire
	#
	def testConnexion()
		return false;
	end
	
	##
	# Crée un nouvel utilisateur
	#
	# ==== Paramètres
	# * +pseudo+ - (string) Pseudo de l'utilisateur
	# * +motDePasse+ - (string) Mot de passe de l'utilisateur
	# * +type+ - (boolean) Type d'utilisateur, false pour créer un utilisateur local, true pour créer un utilisateur serveur
	#
	# ==== Retour
	# Renvoi un objet utilisateur si l'utilisateur a pu être créé, null si une erreur est survenue
	#
	def utilisateurCreer(pseudo, motDePasse, type)
		return null;
	end
	
	##
	# Charge un utilisateur existant
	#
	# ==== Paramètres
	# * +pseudo+ - (string) Pseudo de l'utilisateur
	# * +motDePasse+ - (string) Mot de passe de l'utilisateur
	#
	# ==== Retour
	# Renvoi un objet utilisateur si l'utilisateur a pu être trouvé, null si une erreur est survenue ou que l'utilisateur n'a pu être trouvé
	#
	def utilisateurCharger(pseudo, motDePasse)
	end
	
	##
	# Compte le nombre d'utilisateurs locaux
	#
	# ==== Retour
	# Renvoi le nombre l'utilisateurs trouvés en local, null si une erreur est survenue
	#
	def utilisateurCompterLocaux()
		return 0;
	end
	
	##
	# Compte le nombre d'utilisateurs serveur
	#
	# ==== Retour
	# Renvoi le nombre l'utilisateurs trouvés sur le serveur, null si une erreur est survenue
	#
	def utilisateurCompterServeur()
		return 0;
	end
	
	##
	# Liste les utilisateurs locaux
	#
	# ==== Paramètres
	# * +debut+ - (int) Début de la liste
	# * +fin+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi un tableau d'objets utilisateurs, null si une erreur est survenue
	#
	def utilisateurListerLocaux(debut, fin)
		return null;
	end
	
	##
	# Liste les utilisateurs serveur
	#
	# ==== Paramètres
	# * +debut+ - (int) Début de la liste
	# * +fin+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi un tableau d'objets utilisateurs, null si une erreur est survenue
	#
	def utilisateurListerServeur(debut, fin)
		return null;
	end
	
	##
	# Change le type d'un utilisateur
	#
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Utilisateur à modifier
	#
	# ==== Retour
	# Renvoi un objet utilisateur si l'utilisateur a pu être modifié, null si une erreur est survenue
	#
	def utilisateurChangerType()
		return null;
	end
	
	##
	# Supprime un utilisateur
	#
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Utilisateur à supprimer
	#
	# ==== Retour
	# Renvoi un objet utilisateur si l'utilisateur a pu être supprimé, null si une erreur est survenue
	#
	def utilisateurSupprimer(utilisateur)
		return null;
	end
	
	##
	# Réinitialise un utilisateur
	#
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Utilisateur à modifier
	#
	# ==== Retour
	# Renvoi true si l'utilisateur à pu être réinitialiser, false si une erreur est survenue
	#
	def utilisateurReinitialiser(utilisateur)
		return false;
	end

end

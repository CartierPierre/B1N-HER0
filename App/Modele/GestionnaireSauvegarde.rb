##
# La classe GestionnaireSauvegarde permet d'intéragir avec entitées Sauvegarde
# Utilise le DP Singleton
#
# Version 1
#
# Résoudre le problème des private_class_method
# Passer la connexion BDD par une instance unique
#
class GestionnaireSauvegarde
	
	### Attributs de classe
	
	@@instance = nil
	
	
	### Attributs d'instances
	
	@bddLocal = nil
	
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def GestionnaireSauvegarde.instance
		if(@@instance == nil)
			@@instance = new
		end
		
		return @@instance;
	end
	
	
	### Méthodes d'instances
	
	##
	# Constructeur
	#
	private_class_method :new
	def initialize
		@bddLocal = SQLite3::Database.new('./bdd-test.sqlite')
	end
	
	##
	# Compte le nombre de sauvegardes d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont l'on veut connaitre le nombre de sauvegardes
	#
	# ==== Retour
	# Renvoi le nombre de sauvegardes d'un utilisateur
	#
	def recupererNombreSauvegardeUtilisateur(u)
		resultat = @bddLocal.execute("
			SELECT COUNT(id)
			FROM sauvegarde
			WHERE id_utilisateur = #{ u.id };
		")
		return resultat[0][0];
	end
	
	##
	# Liste les sauvegardes d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont l'on veut récupérer les sauvegardes
	# * +o+ - (int) Début de la liste
	# * +l+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi une liste d'objets sauvegarde d'un utilisateur
	#
	def recupererSauvegardeUtilisateur(u, o, l)
		resultat = @bddLocal.execute("
			SELECT *
			FROM sauvegarde
			WHERE id_utilisateur = #{ u.id }
			LIMIT #{ l }
			OFFSET #{ o };
		")
		
		liste = Array.new
		resultat.each do |el|
			liste.push( Sauvegarde.creer( el[0], el[1], el[2], el[3], el[4], el[5] ) )
		end
		
		return liste;
	end
	
end

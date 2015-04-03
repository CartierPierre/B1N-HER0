##
# La classe GestionnaireScore permet d'intéragir avec entitées Score
# Utilise le DP Singleton
#
# Version 1
#
# Passer la connexion BDD par une instance unique
#
class GestionnaireScore
	
	### Attributs de classe
	
	@@instance = nil
	
	
	### Attributs d'instances
	
	@bddLocal = nil
	
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def GestionnaireScore.instance
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
		@bddLocal = SQLite3::Database.new('./bdd-test.sqlite')
	end
	
	### Méthodes d'instances
	
	##
	# Crée un object score selon un tableau de paramètres
	#
	# ==== Paramètres
	# * +args+ - (tab) Tableau de paramètres (voir classe Score)
	#
	# === Retour
	# Renvoi un object score hydraté selon les paramètres
	#
	def hydraterScore(args)
		return Score.creer( args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7] )
	end
	private :hydraterScore
	
	##
	# Compte le nombre de scores
	#
	# ==== Retour
	# Renvoi le nombre de score
	#
	def recupererNombreScore
		resultat = @bddLocal.execute("
			SELECT COUNT(id)
			FROM score;
		")
		return resultat[0][0];
	end
	
	##
	# Liste les scores
	#
	# ==== Paramètres
	# * +o+ - (int) Début de la liste
	# * +l+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi une liste d'objets scores
	#
	def recupererListeScore(o, l)
	
		resultat = @bddLocal.execute("
			SELECT *
			FROM score
			LIMIT #{ l }
			OFFSET #{ o };
		")
		
		liste = Array.new
		resultat.each do |el|
			liste.push( hydraterScore( el ) )
		end
		
		return liste;
	end
	
	##
	# Compte le nombre de scores d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont l'on veut connaitre le nombre de score
	#
	# ==== Retour
	# Renvoi le nombre de score d'un utilisateur
	#
	def recupererNombreScoreUtilisateur(u)
		resultat = @bddLocal.execute("
			SELECT COUNT(id)
			FROM score
			WHERE id_utilisateur = #{ u.id };
		")
		return resultat[0][0];
	end
	
	##
	# Liste les scores d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont l'on veut récupérer les scores
	# * +o+ - (int) Début de la liste
	# * +l+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi une liste d'objets score d'un utilisateur
	#
	def recupererListeScoreUtilisateur(u, o, l)
		resultat = @bddLocal.execute("
			SELECT *
			FROM score
			WHERE id_utilisateur = #{ u.id }
			LIMIT #{ l }
			OFFSET #{ o };
		")
		
		liste = Array.new
		resultat.each do |el|
			liste.push( hydraterScore( el ) )
		end
		
		return liste;
	end
	
	##
	# Compte le nombre de scores d'un niveau
	#
	# ==== Paramètres
	# * +n+ - (Niveay) Niveau dont l'on veut connaitre le nombre de score
	#
	# ==== Retour
	# Renvoi le nombre de score d'un niveau
	#
	def recupererNombreScoreNiveau(n)
		resultat = @bddLocal.execute("
			SELECT COUNT(id)
			FROM score
			WHERE id_niveau = #{ n.id };
		")
		return resultat[0][0];
	end
	
	##
	# Liste les scores d'un niveau
	#
	# ==== Paramètres
	# * +n+ - (Niveau) Niveau dont l'on veut récupérer les scores
	# * +o+ - (int) Début de la liste
	# * +l+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi une liste d'objets score d'un utilisateur
	#
	def recupererListeScoreNiveau(n, o, l)
		resultat = @bddLocal.execute("
			SELECT *
			FROM score
			WHERE id_niveau = #{ n.id }
			LIMIT #{ l }
			OFFSET #{ o };
		")
		
		liste = Array.new
		resultat.each do |el|
			liste.push( hydraterScore( el ) )
		end
		
		return liste;
	end
	
end

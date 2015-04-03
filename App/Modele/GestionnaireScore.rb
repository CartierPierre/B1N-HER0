##
# La classe GestionnaireScore permet d'intéragir avec entitées Score
# Utilise le DP Singleton
#
# Version 4
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
	# Recherche un score selon son id
	#
	# ==== Paramètres
	# * +id+ - (int) Id du score
	#
	# ==== Retour
	# Renvoi un objets score si se dernier a été trouvé. Nil si non
	#
	def recupererScore(id)
		resultat = @bddLocal.execute("
			SELECT *
			FROM score
			WHERE id = #{ id }
			LIMIT 1;
		")
		
		if ( resultat.count == 0 )
			return nil
		end
		
		return hydraterScore( resultat[0] )
	end
	
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
	# Compte le nombre de scores d'un utilisateur sur un niveau
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont l'on veut connaitre le nombre de score
	# * +n+ - (Niveau) Niveau dont l'on veut récupérer les scores
	#
	# ==== Retour
	# Renvoi le nombre de score d'un utilisateur sur le niveau
	#
	def recupererNombreScoreUtilisateurNiveau(u, n)
		resultat = @bddLocal.execute("
			SELECT COUNT(id)
			FROM score
			WHERE
				id_utilisateur = #{ u.id }
				AND id_niveau = #{ n.id };
		")
		return resultat[0][0];
	end
	
	##
	# Liste les scores d'un utilisateur sur un niveau
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont l'on veut récupérer les scores
	# * +n+ - (Niveau) Niveau dont l'on veut récupérer les scores
	# * +o+ - (int) Début de la liste
	# * +l+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi une liste d'objets score d'un utilisateur sur le niveau
	#
	def recupererListeScoreUtilisateurNiveau(u, n, o, l)
		resultat = @bddLocal.execute("
			SELECT *
			FROM score
			WHERE
				id_utilisateur = #{ u.id }
				AND id_niveau = #{ n.id };
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
			WHERE
				id_niveau = #{ n.id }
			ORDER BY
				temps_total,
				nb_coups DESC,
				nb_conseils DESC,
				nb_aides DESC
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
	# Fait persister les données d'un score
	#
	# ==== Paramètres
	# * +s+ - (Score) Score dont il faut faire persister les informations
	#
	def insert(s)
		@bddLocal.execute("
			INSERT INTO score
			VALUES (
				null,
				null,
				#{ s.tempsTotal },
				#{ s.nbCoups },
				#{ s.nbConseils },
				#{ s.nbAides },
				#{ s.utilisateur.id },
				#{ s.niveau.id }
			);
		")
		s.id = @bddLocal.last_insert_row_id
	end
	private :insert
	
	##
	# Fait persister les données d'un score
	#
	# ==== Paramètres
	# * +s+ - (Score) Score dont il faut faire persister les informations
	#
	def update(s)
		@bddLocal.execute("
			UPDATE score
			SET
				uuid = #{ (s.uuid==nil)?"null":s.uuid },
				temps_total = #{ s.tempsTotal },
				nb_coups = #{ s.nbCoups },
				nb_conseils = #{ s.nbConseils },
				nb_aides = #{ s.nbAides },
				id_utilisateur = #{ s.tempsTotal },
				id_niveau = #{ s.utilisateur.id }
			WHERE id = #{ s.niveau.id };
		")
	end
	private :update
	
	##
	# Met à jour un score
	#
	# ==== Paramètres
	# * +s+ - (Score) Score dont il faut mettre à jour les informations
	#
	def sauvegarderScore(s)
		if (s.id == nil)
			insert(s)
		else
			update(s)
		end
	end
	
	##
	# Supprime un score
	#
	# ==== Paramètres
	# * +s+ - (Score) Score à supprimer
	#
	def supprimerScore(s)
		@bddLocal.execute("
			DELETE FROM score
			WHERE id = #{ s.id };
		")
	end
	
	##
	# Supprimer tous les scores d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut supprimer tous les scores
	#
	def supprimerScoreUtilisateur(u)
		@bddLocal.execute("
			DELETE FROM score
			WHERE id_utilisateur = #{ u.id };
		")
	end
	
end

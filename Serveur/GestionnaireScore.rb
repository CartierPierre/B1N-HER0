##
# La classe GestionnaireScore permet d'intéragir avec entitées Score
# Utilise le DP Singleton
#
# Version 2
#
class GestionnaireScore
	
	### Attributs de classe
	
	@@instance = nil
	
	
	### Attributs d'instances
	
	@stockage = nil
	
	
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
		@stockage = Stockage.instance()
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
		return Score.creer(
			args[0], # id
			args[1], # version
			args[2], # temps_total
			args[3], # nb_coups
			args[4], # nb_conseils
			args[5], # nb_aides
			args[6], # id_utilisateur
			args[7]  # id_niveau
		)
	end
	private :hydraterScore
	
	##
	# Recherche un ensemble de scores selon une liste d'ids
	#
	# ==== Paramètres
	# * +ids+ - (array int) Liste d'ids
	#
	# ==== Retour
	# Renvoi une liste d'objets score
	#
	def recupererEnsembleScore( ids )
		resultat = @stockage.executer("
			SELECT *
			FROM score
			WHERE id IN (#{ ids.join(',') });
		")
		
		liste = Array.new
		resultat.each do | el |
			liste.push( hydraterScore( el ) )
		end
		
		return liste;
	end
	
	##
	# Recherche un score selon son id
	#
	# ==== Paramètres
	# * +id+ - (int) Id du score
	#
	# ==== Retour
	# Renvoi un objets score si se dernier a été trouvé. Nil si non
	#
	# def recupererScore(id)
		# resultat = @stockage.executer("
			# SELECT *
			# FROM score
			# WHERE id = #{ id }
			# LIMIT 1;
		# ")
		
		# if ( resultat.count == 0 )
			# return nil
		# end
		
		# return hydraterScore( resultat[0] )
	# end
	
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
		resultat = @stockage.executer("
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
		resultat = @stockage.executer("
			SELECT *
			FROM score
			WHERE id_utilisateur = #{ u.id }
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
		@stockage.executer("
			INSERT INTO score
			VALUES (
				null,
				#{ s.version },
				#{ s.tempsTotal },
				#{ s.nbCoups },
				#{ s.nbConseils },
				#{ s.nbAides },
				#{ s.idUtilisateur },
				#{ s.idNiveau }
			);
		")
		s.id = @stockage.dernierId()
	end
	private :insert
	
	##
	# Fait persister les données d'un score
	#
	# ==== Paramètres
	# * +s+ - (Score) Score dont il faut faire persister les informations
	#
	def update(s)
		@stockage.executer("
			UPDATE score
			SET
				version = #{ s.version },
				temps_total = #{ s.tempsTotal },
				nb_coups = #{ s.nbCoups },
				nb_conseils = #{ s.nbConseils },
				nb_aides = #{ s.nbAides },
				id_utilisateur = #{ s.idUtilisateur },
				id_niveau = #{ s.idNiveau }
			WHERE id = #{ s.id };
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
	# def supprimerScore(s)
		# @stockage.executer("
			# DELETE FROM score
			# WHERE id = #{ s.id };
		# ")
	# end
	
	##
	# Supprimer tous les scores d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut supprimer tous les scores
	#
	# def supprimerScoreUtilisateur(u)
		# @stockage.executer("
			# DELETE FROM score
			# WHERE id_utilisateur = #{ u.id };
		# ")
	# end
	
	##
	# Supprime un ensemble de scores selon une liste d'ids
	#
	# ==== Paramètres
	# * +ids+ - (array int) Liste d'ids
	#
	def supprimerEnsembleScores( ids )
		resultat = @stockage.executer("
			DELETE FROM score
			WHERE id IN (#{ ids.join(',') });
		")
	end
	
end

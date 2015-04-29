##
# La classe GestionnaireUtilisateur permet d'intéragir avec entitées Utilisateurs
# Utilise le DP Singleton
#
# Version 2
#
class GestionnaireUtilisateur
	
	### Attributs de classe
	
	@@instance = nil
	
	
	### Attributs d'instances
	
	@stockage = nil
	
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def GestionnaireUtilisateur.instance
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
	# Crée un object utilisateur selon un tableau de paramètres
	#
	# ==== Paramètres
	# * +args+ - (tab) Tableau de paramètres (voir classe Utilisateur)
	#
	# === Retour
	# Renvoi un object utilisateur hydraté selon les paramètres
	#
	def hydraterUtilisateur(args)
		return Utilisateur.creer(
			args[0], # id
			args[1], # version
			args[2], # nom
			args[3], # motDePasse
			args[4], # dateInscription
			args[5]  # option
		)
	end
	private :hydraterUtilisateur
	
	##
	# Recherche un utilisateur selon son id
	#
	# ==== Paramètres
	# * +id+ - (int) Id de l'utilisateur
	#
	# ==== Retour
	# Renvoi un objets utilisateur si se dernier a été trouvé. Nil si non
	#
	def recupererUtilisateur( id )
		resultat = @stockage.executer("
			SELECT *
			FROM utilisateur
			WHERE id = #{ id }
			LIMIT 1;
		")
		
		if ( resultat.count == 0 )
			return nil
		end
		
		return hydraterUtilisateur( resultat[0] )
	end
	
	##
	# Fait persister les données d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut faire persister les informations
	#
	def insert(u)
		@stockage.executer("
			INSERT INTO utilisateur
			VALUES (
				null,
				#{ u.version },
				'#{ u.nom }',
				'#{ u.motDePasse }',
				#{ u.dateInscription },
				'#{ u.option }'
			);
		")
		u.id = @stockage.dernierId()
	end
	private :insert
	
	##
	# Fait persister les données d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut faire persister les informations
	#
	def update(u)
		@stockage.executer("
			UPDATE utilisateur
			SET
				version = #{ u.version },
				nom = '#{ u.nom }',
				mot_de_passe = '#{ u.motDePasse }',
				date_inscription = #{ u.dateInscription },
				options = '#{ u.option }'
			WHERE id = #{ u.id };
		")
	end
	private :update
	
	##
	# Met à jour un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut mettre à jour les informations
	#
	def sauvegarderUtilisateur( u )
		if( u.id == nil )
			insert( u )
		else
			update( u )
		end
	end
	
	##
	# Supprime un utilisateur
	#
	# ==== Paramètres
	# * +id+ - (int) Id de l'utilisateur à supprimer
	#
	def supprimerUtilisateur( id )
		@stockage.executer("
			DELETE FROM utilisateur
			WHERE id = #{ id };
		")
	end
	
	##
	# Récupère un utilisateur selon son nom et son mot de passe
	#
	# ==== Paramètres
	# * +nom+ - (string) Nom de l'utilisateur
	# * +motDePasse+ - (string) Mot de passe de l'utilisateur
	#
	# ==== Retour
	# Renvoi un object utilisateur si ce dernier à été trouvé, nil si non
	#
	def connexionUtilisateur(n, m)
		resultat = @stockage.executer("
			SELECT *
			FROM utilisateur
			WHERE
				nom = '#{n}'
				AND mot_de_passe = '#{m}'
			LIMIT 1;
		")
		
		if ( resultat.count == 0 )
			return nil
		end
		
		return hydraterUtilisateur( resultat[0] )
	end
	
end

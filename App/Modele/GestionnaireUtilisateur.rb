##
# La classe GestionnaireUtilisateur permet d'intéragir avec entitées Utilisateurs
# Utilise le DP Singleton
#
# Version 14
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
			args[1], # uuid
			args[2], # version
			args[3], # nom
			args[4], # motDePasse
			args[5], # dateInscription
			Option.deserialiser( args[6] ), # option
			args[7]  # type
		)
	end
	private :hydraterUtilisateur
	
	##
	# Compte le nombre d'utilisateurs
	#
	# ==== Retour
	# Renvoi le nombre l'utilisateurs
	#
	def recupererNombreUtilisateur
		resultat = @stockage.executer("
			SELECT COUNT(id)
			FROM utilisateur;
		")
		return resultat[0][0];
	end
	
	##
	# Liste les utilisateurs
	#
	# ==== Paramètres
	# * +o+ - (int) Début de la liste
	# * +l+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi un liste d'objets utilisateurs
	#
	def recupererListeUtilisateur(o, l)
	
		resultat = @stockage.executer("
			SELECT *
			FROM utilisateur
			LIMIT #{ l }
			OFFSET #{ o };
		")
		
		liste = Array.new
		resultat.each do |el|
			liste.push( hydraterUtilisateur( el ) )
		end
		
		return liste;
	end
	
	##
	# Recherche un utilisateur selon son id
	#
	# ==== Paramètres
	# * +id+ - (int) Id de l'utilisateur
	#
	# ==== Retour
	# Renvoi un objets utilisateur si se dernier a été trouvé. Nil si non
	#
	def recupererUtilisateur(id)
		resultat = @stockage.executer("
			SELECT *
			FROM utilisateur
			WHERE id = #{id}
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
				#{ u.uuid },
				#{ u.version },
				'#{ u.nom }',
				'#{ u.motDePasse }',
				#{ u.dateInscription },
				'#{ Option.serialiser( u.option ) }',
				#{ u.type }
			);
		")
		u.id = @stockage.dernierId()
		u.version = 1
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
				uuid = #{ (u.uuid==nil)?"null":u.uuid },
				version = version + 1,
				nom = '#{ u.nom }',
				mot_de_passe = '#{ u.motDePasse }',
				date_inscription = #{ u.dateInscription },
				options = '#{ Option.serialiser( u.option ) }',
				type = #{ u.type }
			WHERE id = #{ u.id };
		")
	end
	private :update
	
	##
	# Met à jour un utilisateur
	#
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Utilisateur dont il faut mettre à jour les informations
	#
	def sauvegarderUtilisateur( utilisateur )
		if( utilisateur.id == nil )
			insert( utilisateur )
		else
			update( utilisateur )
		end
	end
	
	##
	# Supprime un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur à supprimer
	#
	def supprimerUtilisateur(u)
		@stockage.executer("
			DELETE FROM utilisateur
			WHERE id = #{ u.id };
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
	def connexionUtilisateur( nom, motDePasse )
		resultat = @stockage.executer("
			SELECT *
			FROM utilisateur
			WHERE
				nom = '#{ nom }'
				AND mot_de_passe = '#{ motDePasse }'
			LIMIT 1;
		")
		
		if ( resultat.count == 0 )
			return nil
		end
		
		return hydraterUtilisateur( resultat[0] )
	end
	
end

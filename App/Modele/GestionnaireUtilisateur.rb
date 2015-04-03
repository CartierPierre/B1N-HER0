##
# La classe GestionnaireUtilisateur permet d'intéragir avec entitées Utilisateurs
# Utilise le DP Singleton
#
# Version 8
#
# Passer la connexion BDD par une instance unique
#
class GestionnaireUtilisateur
	
	### Attributs de classe
	
	@@instance = nil
	
	
	### Attributs d'instances
	
	@bddLocal = nil
	
	
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
		@bddLocal = SQLite3::Database.new('./bdd-test.sqlite')
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
		return Utilisateur.creer( args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8] )
	end
	private :hydraterUtilisateur
	
	##
	# Compte le nombre d'utilisateurs
	#
	# ==== Retour
	# Renvoi le nombre l'utilisateurs
	#
	def recupererNombreUtilisateur
		resultat = @bddLocal.execute("
			SELECT COUNT(id)
			FROM utilisateur;
		")
		return resultat[0][0];
	end
	
	##
	# Liste les utilisateurs
	#
	# ==== Paramètres
	# * +offset+ - (int) Début de la liste
	# * +limit+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi un liste d'objets utilisateurs
	#
	def recupererListeUtilisateur(offset, limit)
	
		resultat = @bddLocal.execute("
			SELECT *
			FROM utilisateur
			LIMIT #{ limit }
			OFFSET #{ offset };
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
		resultat = @bddLocal.execute("
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
		@bddLocal.execute("
			INSERT INTO utilisateur
			VALUES (
				null,
				null,
				'#{ u.nom }',
				'#{ u.motDePasse }',
				#{ u.dateInscription },
				#{ u.dateDerniereSync },
				'#{ u.option }',
				#{ u.type }
			);
		")
		u.id = @bddLocal.last_insert_row_id
	end
	private :insert
	
	##
	# Fait persister les données d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut faire persister les informations
	#
	def update(u)
		@bddLocal.execute("
			UPDATE utilisateur
			SET
				uuid = #{ (u.uuid==nil)?"null":u.uuid },
				nom = '#{ u.nom }',
				mot_de_passe = '#{ u.motDePasse }',
				date_inscription = #{ u.dateInscription },
				date_derniere_synchronisation = #{ u.dateDerniereSync },
				options = '#{ u.option }',
				type = #{ u.type }
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
	def sauvegarderUtilisateur(u)
		if (u.id == nil)
			insert(u)
		else
			update(u)
		end
	end
	
	##
	# Supprime un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur à supprimer
	#
	def supprimerUtilisateur(u)
		@bddLocal.execute("
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
	def connexionUtilisateur(n, m)
		resultat = @bddLocal.execute("
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

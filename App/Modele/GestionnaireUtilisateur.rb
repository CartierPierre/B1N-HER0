##
# La classe GestionnaireUtilisateur permet d'intéragir avec entitées Utilisateurs
# Utilise le DP Singleton
#
# Version 4
#
# Résoudre le problème des private_class_method
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
	
	
	### Méthodes d'instances
	
	##
	# Constructeur
	#
	private_class_method :new
	def initialize
		# begin
			# puts "Ouverture de la BDD ..."
			@bddLocal = SQLite3::Database.new('./bdd-test.sqlite')
			# rescue SQLite3::Exception => err
				# puts "Erreur BDD"
				# puts err
				# abort
		# end
		# puts "BDD OK"
	end
	
	##
	# Compte le nombre d'utilisateurs
	#
	# ==== Retour
	# Renvoi le nombre l'utilisateurs
	#
	def count
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
	def getAll(offset, limit)
	
		resultat = @bddLocal.execute("
			SELECT *
			FROM utilisateur
			LIMIT #{ limit }
			OFFSET #{ offset };
		")
		
		liste = Array.new
		resultat.each do |el|
			liste.push( Utilisateur.creer( el[0], el[1], el[2], el[3], el[4], el[5], el[6], el[7], el[8] ) )
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
	def findById(id)
		resultat = @bddLocal.execute("
			SELECT *
			FROM utilisateur
			WHERE id = #{id}
			LIMIT 1;
		")
		
		if ( resultat.count == 0 )
			return nil
		end
		
		resultat = resultat[0]
		return Utilisateur.creer(resultat[0], resultat[1], resultat[2], resultat[3], resultat[4], resultat[5], resultat[6], resultat[7], resultat[8])
	end
	
	##
	# Fait persister les données d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut faire persister les informations
	#
	# private_class_method :insert
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
	
	##
	# Fait persister les données d'un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut faire persister les informations
	#
	# private_class_method :update
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
	
	##
	# Met à jour un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur dont il faut mettre à jour les informations
	#
	def persist(u)
		if (u.id == nil)
			self.insert(u)
		else
			self.update(u)
		end
	end
	
	##
	# Supprime un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur à supprimer
	#
	def delete(u)
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
	def getForAuthentication(n, m)
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
		
		resultat = resultat[0]
		return Utilisateur.creer(resultat[0], resultat[1], resultat[2], resultat[3], resultat[4], resultat[5], resultat[6], resultat[7], resultat[8])
	end
	
end

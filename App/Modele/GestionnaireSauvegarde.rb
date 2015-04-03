##
# La classe GestionnaireSauvegarde permet d'intéragir avec entitées Sauvegarde
# Utilise le DP Singleton
#
# Version 2
#
# Passer la connexion BDD par une instance unique
# Repenser attributs (insert/update non opérationnels)
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
	
	##
	# Constructeur
	#
	private_class_method :new
	def initialize
		@bddLocal = SQLite3::Database.new('./bdd-test.sqlite')
	end
	
	### Méthodes d'instances
	
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
	
	##
	# Recherche une sauvegarde selon son id
	#
	# ==== Paramètres
	# * +id+ - (int) Id de la sauvegarde
	#
	# ==== Retour
	# Renvoi un objets sauvegarde si se dernier a été trouvé. Nil si non
	#
	def recupererSauvegarde(id)
		resultat = @bddLocal.execute("
			SELECT *
			FROM sauvegarde
			WHERE id = #{ id }
			LIMIT 1;
		")
		
		if ( resultat.count == 0 )
			return nil
		end
		
		resultat = resultat[0]
		return Sauvegarde.creer( resultat[0], resultat[1], resultat[2], resultat[3], resultat[4], resultat[5] )
		
	end
	
	##
	# Fait persister les données d'un sauvegarde
	#
	# ==== Paramètres
	# * +u+ - (Sauvegarde) Sauvegarde dont il faut faire persister les informations
	#
	# private_class_method :insert
	def insert(s)
		# @bddLocal.execute("
			# INSERT INTO sauvegarde
			# VALUES (
				# null,
				# null,
				# '#{ u.nom }',
				# '#{ u.motDePasse }',
				# { u.dateInscription },
				# { u.dateDerniereSync },
				# '#{ u.option }',
				# { u.type }
			# );
		# ")
		s.id = @bddLocal.last_insert_row_id
	end
	private :insert
	
	##
	# Fait persister les données d'une sauvegarde
	#
	# ==== Paramètres
	# * +s+ - (Sauvegarde) Sauvegarde dont il faut faire persister les informations
	#
	# private_class_method :update
	def update(s)
		# @bddLocal.execute("
			# UPDATE sauvegarde
			# SET
				# uuid = #{ (u.uuid==nil)?"null":u.uuid },
				# nom = '#{ u.nom }',
				# mot_de_passe = '#{ u.motDePasse }',
				# date_inscription = #{ u.dateInscription },
				# date_derniere_synchronisation = #{ u.dateDerniereSync },
				# options = '#{ u.option }',
				# type = #{ u.type }
			# WHERE id = #{ u.id };
		# ")
	end
	private :update
	
	##
	# Met à jour une sauvegarde
	#
	# ==== Paramètres
	# * +s+ - (Sauvegarde) Sauvegarde dont il faut mettre à jour les informations
	#
	# def sauvegarder(s)
		# if (s.id == nil)
			# insert(s)
		# else
			# update(s)
		# end
	# end
	
	##
	# Supprime une sauvegarde
	#
	# ==== Paramètres
	# * +s+ - (Sauvegarde) sauvegarde à supprimer
	#
	def supprimer(s)
		@bddLocal.execute("
			DELETE FROM sauvegarde
			WHERE id = #{ u.id };
		")
	end
	
end

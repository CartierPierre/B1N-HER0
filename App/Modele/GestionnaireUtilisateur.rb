##
# La classe GestionnaireUtilisateur permet d'intéragir avec entitées Utilisateurs
#
class GestionnaireUtilisateur
	
	# Attributs d'instance
	@bddLocal = nil
	
	# Attributs de classe
	@@dbPathFile = "./bdd-test.sqlite"
	
	##
	# Renvoi une instance
	#
	def initialize()
		begin
			puts "Ouverture de la BDD ..."
			@bddLocal = SQLite3::Database.new(@@dbPathFile)
			rescue SQLite3::Exception => err
				puts "Erreur"
				puts err
				abort
			ensure
				puts "OK"
		end
	end
	
	##
	# Exécute une requête
	#
	def execute(requete)
		resultat = nil
		begin
			puts "Execution de la requete : #{requete}"
			resultat = @bddLocal.execute(requete)
			rescue SQLite3::Exception => err
				puts "Erreur"
				puts err
				abort
			ensure
				puts "OK"
		end
		return resultat
	end
	
	##
	# Compte le nombre d'utilisateurs
	#
	# ==== Retour
	# Renvoi le nombre l'utilisateurs
	#
	def count()
		resultat = self.execute ("
			SELECT COUNT(id)
			FROM utilisateur;
		")
		return resultat[0][0];
	end
	
	##
	# Liste les utilisateurs (wip)
	#
	# ==== Paramètres
	# * +offset+ - (int) Début de la liste
	# * +limit+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi un liste d'objets utilisateurs
	#
	# def getAll(offset, limit)
		# resultat = self.execute ("
			# SELECT *
			# FROM utilisateur
			# LIMIT #{limit}
			# OFFSET #{offset};
		# ")
		# return resultat;
	# end
	
	# def FindById(id)
		# return nil;
	# end
	
	# def persist(Utilisateur)
	# end
	
	##
	# Supprime un utilisateur
	#
	# ==== Paramètres
	# * +u+ - (Utilisateur) Utilisateur à supprimer
	#
	def delete(u)
		self.execute ("
			DELETE FROM utilisateur
			WHERE id = #{ u.getId() }
			LIMIT 1;
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
		resultat = self.execute ("
			SELECT *
			FROM utilisateur
			WHERE
				nom = '#{n}'
				AND mot_de_passe = '#{m}'
			LIMIT 1;
		")
		
		# Si l'utilisateur n'a pas été trouvé
		if ( resultat.count() == 0 )
			return nil
		end
		
		resultat = resultat[0]
		return Utilisateur.creer(resultat[0], resultat[1], resultat[2], resultat[3], resultat[4], resultat[5], resultat[6], resultat[7], resultat[8])
	end
	
end

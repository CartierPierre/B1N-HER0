##
# La classe GestionnaireUtilisateur permet d'intéragir avec entitées Utilisateurs
#
class GestionnaireUtilisateur
	
	# Attributs d'instance
	@bddLocal = nil
	
	# Attributs de classe
	@@dbPathFile = "./test.db"
	
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
		return resultat;
	end
	
	# def getAll(offset, limit)
		# return nil;
	# end
	
	# def FindById(id)
		# return nil;
	# end
	
	# def persist(Utilisateur)
	# end
	
end

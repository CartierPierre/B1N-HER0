##
# La classe GestionnaireNiveau permet d'intéragir avec entitées Niveau
# Utilise le DP Singleton
#
# Version 1
#
# Passer la connexion BDD par une instance unique
#
class GestionnaireNiveau
	
	### Attributs de classe
	
	@@instance = nil
	
	
	### Attributs d'instances
	
	@bddLocal = nil
	
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def GestionnaireNiveau.instance
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
	# Compte le nombre de niveau
	#
	# ==== Retour
	# Renvoi le nombre de niveau
	#
	def recupererNombreNiveau()
		resultat = @bddLocal.execute("
			SELECT COUNT(id)
			FROM niveau;
		")
		return resultat[0][0];
	end
	
	##
	# Liste les niveaux
	#
	# ==== Paramètres
	# * +o+ - (int) Début de la liste
	# * +l+ - (int) Fin de la liste
	#
	# ==== Retour
	# Renvoi une liste d'objets niveau
	#
	def recupererListeNiveau(o, l)
		resultat = @bddLocal.execute("
			SELECT *
			FROM niveau
			LIMIT #{ l }
			OFFSET #{ o };
		")
		
		liste = Array.new
		resultat.each do |el|
			liste.push( Niveau.creer( el[0], el[1], el[2], el[3], el[4], el[5] ) )
		end
		
		return liste;
	end
	
	##
	# Recherche un niveau selon son id
	#
	# ==== Paramètres
	# * +id+ - (int) Id du niveau
	#
	# ==== Retour
	# Renvoi un objets niveau si se dernier a été trouvé. Nil si non
	#
	def recupererNiveau(id)
		resultat = @bddLocal.execute("
			SELECT *
			FROM niveau
			WHERE id = #{ id }
			LIMIT 1;
		")
		
		if ( resultat.count == 0 )
			return nil
		end
		
		resultat = resultat[0]
		return Niveau.creer( resultat[0], resultat[1], resultat[2], resultat[3], resultat[4], resultat[5] )
		
	end
	
end

##
# La classe GestionnaireNiveau permet d'intéragir avec entitées Niveau
# Utilise le DP Singleton
#
# Version 2
#
class GestionnaireNiveau
	
	### Attributs de classe
	
	@@instance = nil
	
	
	### Attributs d'instances
	
	@stockage = nil
	
	
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
		@stockage = Stockage.instance()
	end
	
	### Méthodes d'instances
	
	##
	# Crée un object niveau selon un tableau de paramètres
	#
	# ==== Paramètres
	# * +args+ - (tab) Tableau de paramètres (voir classe Niveau)
	#
	# === Retour
	# Renvoi un object niveau hydraté selon les paramètres
	#
	def hydraterNiveau(args)
		return Niveau.creer(
			args[0], # id
			args[1], # probleme
			args[2], # solution
			args[3], # difficulte
			args[4]  # dimention
		)
	end
	private :hydraterNiveau
	
	##
	# Temporaire, pour la dml, pas utiliser sauf buddies
	#
	# def insert(n)
		# @stockage.executer("
			# INSERT INTO niveau
			# VALUES (
				# null,
				# '#{ n.probleme }',
				# '#{ n.solution }',
				# '#{ n.difficulte }',
				# '#{ n.dimention }'
			# );
		# ")
		# n.id = @stockage.dernierId()
	# end
	
end

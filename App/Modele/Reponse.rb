##
# Classe Reponse
#
# Version 1
#
class Reponse

	### Attributs d'instances
	
	# Mixed
	# Contenu de la reponse
	@contenu
	
	attr_reader :contenu
	
	### Méthodes de classe
	
	##
	# Instancie une reponse
	#
    def Reponse.creer(contenu)
		new(contenu)
    end
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(contenu)
		@contenu = contenu
    end

end

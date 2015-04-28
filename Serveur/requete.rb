##
# Classe Requete
#
# Version 2
#
class Requete

	### Attributs d'instances
	
	# String
	# Nom de la méthode à exécuter sur le serveur
	@methode
	
	# Array
	# Arguments liées à la méthode
	@arguments
	
	attr_reader :methode, :arguments
	
	### Méthodes de classe
	
	##
	# Instancie une Requete
	#
	def Requete.creer( methode, *arguments )
		new( methode, arguments )
    end
	
	##
	# Constructeur
	#
	def initialize( methode, arguments )
		@methode, @arguments = methode, arguments
	end
	private_class_method :new
	
end
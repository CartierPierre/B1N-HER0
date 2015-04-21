##
# Classe Requete
#
# Version 1
#
class Requete

	### Attributs d'instances
	
	# int
	# Identifiant de la commande à executer sur le serveur
	@idCommande
	
	# Array
	# Arguments liées à la commande
	@arguments
	
	attr_reader :idCommande, :arguments
	
	### Méthodes de classe
	
	##
	# Instancie une Requete
	#
	def Requete.creer(idCommande, *arguments)
		new(idCommande, arguments)
    end
	
	##
	# Constructeur
	#
	private_class_method :new
	def initialize(idCommande, arguments)
		@idCommande, @arguments = idCommande, arguments
	end

end
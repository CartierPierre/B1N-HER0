##
# Classe Utilisateur
#
# Version 1
#
class Utilisateur
	
	### Attributs d'instances
	
	# int
	# Identifiant local de l'utilisateur
	@id
	
	# int
	# Version de l'entitée
	@version
	
	# string
	# Nom de l'utilisateur
	@nom
	
	# string
	# Mot de passe de l'utilisateur
	@motDePasse
	
	# int
	# Date à laquelle l'utilisateur c'est inscrit
	@dateInscription
	
	# Option
	# Options de l'utilisateur
	@option
	
	attr_accessor :id, :version, :nom, :motDePasse, :dateInscription, :option
	
	### Méthodes de classe
	
	##
	# Instancie un utilisateur
	#
    def Utilisateur.creer(id, version, nom, motDePasse, dateInscription, option)
		new( id, version, nom, motDePasse, dateInscription, option )
    end
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(id, version, nom, motDePasse, dateInscription, option)
		@id = id
		@version = version;
		@nom = nom
		@motDePasse = motDePasse
		@dateInscription = dateInscription
		@option = option
    end
	
end

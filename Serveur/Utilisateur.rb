##
# Classe Utilisateur
#
# Version 2
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
    def Utilisateur.creer( *args )
		case args.size
			when 5
				new( nil, args[0], args[1], args[2], args[3], args[4] )
			when 6
				new( args[0], args[1], args[2], args[3], args[4], args[5] )
			else
				puts "Utilisateur.creer n'accepte que 5 ou 6 arguments"
        end
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

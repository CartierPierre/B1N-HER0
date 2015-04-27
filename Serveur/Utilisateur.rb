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
    def Utilisateur.creer(*args)
		case args.size
			when 0 # Vide
				new(nil, nil, nil, nil, nil, nil, nil, nil, nil)
			when 6 # Gestionnaire
				new(args[0], args[1], args[2], args[3], args[4], args[5])
			else
				puts "Utilisateur.creer n'accepte que O ou 6 arguments"
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
		
		if( dateInscription == nil )
			@dateInscription = Time.now.to_i
		else
			@dateInscription = dateInscription
		end
		
		if( option == nil )
			@option = Option.creer(Option::TUILE_ROUGE, Option::TUILE_BLEUE, Langue::FR)
		else
			@option = option
		end
		
    end
	
end

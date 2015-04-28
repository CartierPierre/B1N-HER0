##
# Classe Utilisateur
#
# Version 10
#
class Utilisateur
	
	### Constantes de classe
	
	OFFLINE = 0
	ONLINE = 1
	
	### Attributs d'instances
	
	# int
	# Identifiant local de l'utilisateur
	@id
	
	# int
	# Identifiant universel unique du niveau
	@uuid
	
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
	
	# int
	# Type de compte (online/offline)
	@type
	
	# Statistique
	# Statistiques de l'utilisateur
	@statistique
	
	attr_accessor :id, :uuid, :version, :nom, :motDePasse, :dateInscription, :option, :type, :statistique
	
	### Méthodes de classe
	
	##
	# Instancie un utilisateur
	#
    def Utilisateur.creer(*args)
		case args.size
			when 0 # Vide
				new(nil, nil, nil, nil, nil, nil, nil, nil, nil)
			when 3 # Utilisateur
				new(nil, nil, nil, args[0], args[1], nil, nil, args[2])
			when 8 # Gestionnaire
				new(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7])
			else
				puts "Utilisateur.creer n'accepte que O, 3 ou 8 arguments"
        end
    end
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(id, uuid, version, nom, motDePasse, dateInscription, option, type)
		
		@id = id
		@uuid = uuid
		@version = ( version == nil ) ? 1 : version
		@nom = nom
		@motDePasse = motDePasse
		@dateInscription = ( dateInscription == nil ) ? Time.now.to_i : dateInscription
		@option = ( option == nil) ? Option.creer(Option::TUILE_ROUGE, Option::TUILE_BLEUE, Langue::FR) : option
		@type = type
		@statistique = Statistique.creer(self)
		
    end
	
end

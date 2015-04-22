##
# Classe Utilisateur
#
# Version 7
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
	
	# string
	# Nom de l'utilisateur
	@nom
	
	# string
	# Mot de passe de l'utilisateur
	@motDePasse
	
	# int
	# Date à laquelle l'utilisateur c'est inscrit
	@dateInscription
	
	# int
	# Date de la dernière syncronisation entre les données local et le serveur
	@dateDerniereSync
	
	# Option
	# Options de l'utilisateur
	@option
	
	# int
	# Type de compte (online/offline)
	@type
	
	# Statistique
	# Statistiques de l'utilisateur
	@statistique
	
	attr_accessor :id, :uuid, :nom, :motDePasse, :dateInscription, :dateDerniereSync, :option, :type
	attr_reader :statistique
	
	### Méthodes de classe
	
	##
	# Instancie un utilisateur
	#
    def Utilisateur.creer(*args)
		case args.size
			when 0
				new(nil, nil, nil, nil, nil, nil, nil, nil)
			when 3
				new(nil, nil, args[0], args[1], nil, nil, nil, args[2])
			when 8
				new(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7])
			else
				puts "Utilisateur.creer n'accepte que O, 3 ou 8 arguments"
        end
    end
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, option, type)
		
		@id = id
		@uuid = uuid
		@nom = nom
		@motDePasse = motDePasse
		
		if( dateInscription == nil )
			@dateInscription = Time.now.to_i
		else
			@dateInscription = dateInscription
		end
		
		if( dateDerniereSync == nil )
			@dateDerniereSync = Time.now.to_i
		else
			@dateDerniereSync = dateDerniereSync
		end
		
		if( option == nil )
			@option = Option.creer(Option::TUILE_ROUGE, Option::TUILE_BLEUE, Langue::FR)
		else
			@option = option
		end
		
		@type = type
		@statistique = Statistique.creer(self)
		
    end
	
end

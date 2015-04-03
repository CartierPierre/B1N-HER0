##
# Classe Utilisateur
#
# Version 2
#
class Utilisateur
	
	### Constantes de classe
	
	OFFLINE = 0
	ONLINE = 1
	
	### Attributs d'instances
	
	attr_accessor :id, :uuid, :nom, :motDePasse, :dateInscription, :dateDerniereSync, :type, :statistique, :option
	
	### Méthodes de classe
	
	##
	# Instancie un utilisateur
	#
    def Utilisateur.creer(*args)
		case args.size
			when 0
				new(nil, nil, nil, nil, Time.now.to_i, Time.now.to_i, nil, nil, nil)
			when 3
				new(nil, nil, args[0], args[1], Time.now.to_i, Time.now.to_i, args[2], nil, nil)
			when 9
				new(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8])
			else
				puts "Utilisateur.creer n'accepte que O, 3 ou 9 arguments"
        end
    end
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
		@id = id
		@uuid = uuid
		@nom = nom
		@motDePasse = motDePasse
		@dateInscription = dateInscription
		@dateDerniereSync = dateDerniereSync
		@type = type
		@statistique = statistique
		@option = option
    end
	
end

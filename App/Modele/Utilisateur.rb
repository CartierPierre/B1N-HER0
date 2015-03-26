class Utilisateur
	
	### Constantes de classe
	
	OFFLINE = 0
	ONLINE = 1
	
	### Attributs d'instances
	
	attr_accessor :id, :uuid, :nom, :motDePasse, :dateInscription, :dateDerniereSync, :type, :statistique, :option
	
	### Méthodes de classe
	
#	def Utilisateur.creer()
#        new(nil, nil, nil, nil, nil, nil, nil, nil, nil)
#    end
	
    def Utilisateur.creer(*arguments)
        if arguments.length() == 3
            new(nil, nil, arguments[0], arguments[1], nil, nil, arguments[2], nil, nil)
        end
    end
	
#	def Utilisateur.creer(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
#        new(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
#    end
	
	### Méthodes d'instances
	
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

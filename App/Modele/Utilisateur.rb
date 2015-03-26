class Utilisateur
	
	### Constantes de classe
	
	OFFLINE = 0
	ONLINE = 1
	
	### Attributs d'instances
	
	attr_accessor :id, :uuid, :nom, :motDePasse, :dateInscription, :dateDerniereSync, :type, :statistique, :option
	
	### Méthodes de classe
	
	def Utilisateur.creer()
        new()
    end
	
    def Utilisateur.creer(nom, motDePasse, type)
        new(nom, motDePasse, type)
    end
	
	### Méthodes d'instances
	
	private_class_method :new
    def initialize()
		@id = nil
		@uuid = nil
		@nom = ""
		@motDePasse = ""
		@dateInscription = ""
		@dateDerniereSync = nil
		@type = 0
		@statistique = nil
		@option = nil
    end
	
	def initialize(nom, motDePasse, type)
		self.initialize()
		@nom = nom
		@motDePasse = motDePasse
		@type = type
    end
	
end

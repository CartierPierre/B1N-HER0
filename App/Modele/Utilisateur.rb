class Utilisateur
    attr_accessor :id, :uuid, :nom, :motDePasse, :dateInscription, :dateDerniereSync, :type, :statistique, :option
	
    # Méthode de création de création d'une tuile
    def Utilisateur.creer(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
        new(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
    end
	
	private_class_method :new
    def initialize(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
		@id,@uuid,@nom,@motDePasse,@dateInscription,@dateDerniereSync,@type,@statistique,@option = id,uuid,nom,motDePasse,dateInscription,dateDerniereSync, type, statistique, option
    end
end

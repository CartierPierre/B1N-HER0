class Utilisateur
    attr_accessor :id, :uuid, :nom, :motDePasse, :dateInscription, :dateDerniereSync, :type, :statistique, :option

    # private_class_method :initialize
	
    # Méthode de création de création d'une tuile
    def Utilisateur.creer(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
        new(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
    end

    def initialize(id, uuid, nom, motDePasse, dateInscription, dateDerniereSync, type, statistique, option)
	@id,@uuid,@nom,@motDePasse,@dateInscription,@dateDerniereSync,@type,@statistique,@option = id,uuid,nom,motDePasse,dateInscription,dateDerniereSync, type, statistique, option
    end
end

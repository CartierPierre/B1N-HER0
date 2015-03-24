class Sauvegarde
    attr_reader :id, :uuid, :utilisateur, :titre, :dateCreation, :partie

    private_class_method :new
    def Sauvegarde.creer(id, uuid, utilisateur, titre, dateCreation, partie)
        new(id, uuid, utilisateur, titre, dateCreation, partie)
    end

    def initialize(id, uuid, utilisateur, titre, dateCreation, partie)
        @id, @uuid, @utilisateur, @titre, @dateCreation, @partie = id, uuid, utilisateur, titre, dateCreation, partie
    end
end
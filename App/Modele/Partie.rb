load 'Time.rb'
load 'Grille.rb'

class Partie
    attr_reader :grille, :niveau
    @historique
    @dateDebutPartie

    # Méthode de création d'une partie
    #
    # === Argument
    # *niveau* - Le niveau sur lequel ce base la partie
    private_class_method :new
    def Partie.creer(niveau)
        new(niveau)
    end

    def initialize(niveau)
        @niveau = niveau
        @grille = new.Grille(@niveau.taille)
        @historique = Array.new()
        @dateDebutPartie = Time.new()
    end

    # Ajoute enregistre l'état de la grille
    def historiqueAdd()
        @historique.add(@grille)
        self
    end

    # Remet la grille dans son état précédent
    def historiqueUndo()
        if(@historique.size > 0)
            @grille = @historique.pop()
        end
        self
    end
end
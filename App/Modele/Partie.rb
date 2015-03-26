require 'time'

class Partie
    attr_reader :grille, :niveau, :score, :utilisateur
    @historique
    @dateDebutPartie

    # Méthode de création d'une partie
    #
    # === Argument
    # *niveau* - Le niveau sur lequel ce base la partie
    private_class_method :new
    def Partie.creer(utilisateur, niveau)
        new(utilisateur, niveau)
    end

    def initialize(utilisateur, niveau)
        @utilisateur = utilisateur
        @niveau = niveau
        @grille = Grille.creer(niveau.grilleInitial.taille).copier(niveau.grilleInitial)
        @historique = Array.new()
        @dateDebutPartie = Time.new()
        @score = Score.creer(@utilisateur)
    end

    # Enregistre un coup est l'état de la tuile avant ce coup
    #
    # === Argument
    # *coup* - Le coup joué.
    def historiqueAdd(coup)
        @historique.push(coup)
        self
    end

    # Efface un coup jouer
    def historiqueUndo()
        if(@historique.size > 0)
            coup = @historique.pop()
            @grille.appliquerCoup(coup.x, coup.y, coup.etat)
        end
        self
    end

    #Permet de jouer un coup
    def jouerCoup(x, y)#TODO signale un coup invalide
        if @niveau.tuileValide?(x, y)
            historiqueAdd(Coup.creer(x, y, @grille.getTuile(x, y).etat()))
            t = (@grille.getTuile(x, y).etat() + 1)%3
            @grille.appliquerCoup(x, y, t)
            @score.incNbCoups()
        end
    end

    #TODO reset grille
end
require 'time'

class Partie
    attr_reader :grille, :niveau, :score, :utilisateur
    @historique
    @dateDebutPartie
    @historiqueCurseur
    @doneRedo

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
        @historiqueCurseur = 0
    end

    # Enregistre un coup est l'état de la tuile avant ce coup
    #
    # === Argument
    # *coup* - Le coup joué.
    def historiqueAdd(coup)
        0.upto((@historique.size()-2) - @historiqueCurseur) do
            @historique.pop()
        end
        @doneRedo = false
        @historique.push(coup)
        @historiqueCurseur = @historique.size() - 1
        self
    end

    # Efface un coup jouer
    def historiqueUndo()
        if(@historique.size > 0 && @historiqueCurseur >= 0)
            coup = @historique[@historiqueCurseur]

            # Sauvegarde le 
            if(@historiqueCurseur == @historique.size() - 1 && !@doneRedo)
                @historique.push(Coup.creer(coup.x, coup.y, @grille.getTuile(coup.x, coup.y).etat()))
            end

            if(@historiqueCurseur > 0)
                @historiqueCurseur -= 1
            end

            @grille.appliquerCoup(coup.x, coup.y, coup.etat)

            return Array[ coup.x, coup.y ]
        end

        return nil
    end

    # Efface un coup jouer
    def historiqueRedo()
        if(@historique.size > 0 && @historiqueCurseur < (@historique.size() - 1))
            @historiqueCurseur += 1
            coup = @historique[@historiqueCurseur]
            @grille.appliquerCoup(coup.x, coup.y, coup.etat)
            @doneRedo = true
        
           return Array[ coup.x, coup.y ]
        end

        return nil
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
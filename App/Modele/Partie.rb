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
        #TODO mettre a jour pour nouveau coup
        # 0.upto(@historique.size() - @historiqueCurseur) do
        #     @historique.pop()
        # end
        if((@historique.size > 0) && (@historique.last().x == coup.x && @historique.last().y == coup.y))
            if(coup.etat != 2)
                @historique.last().etat = coup.etat
            else
                @historique.pop()
            end
        else
            @historique.push(coup)
            @historiqueCurseur = @historique.size() - 1
        end

        self
    end

    # Efface un coup jouer
    def historiqueUndo()
        if(@historique.size > 0)
            coup = @historique[@historiqueCurseur]
            @grille.appliquerCoup(coup.x, coup.y, coup.etat)

            if(@historiqueCurseur > 0)
                @historiqueCurseur -= 1
            end

            monitor
            return Array[ coup.x, coup.y ]
        end

        return nil
    end

    # Efface un coup jouer
    def historiqueRedo()
        if(@historique.size > 0 && @historiqueCurseur < @historique.size())
            coup = @historique[@historiqueCurseur]
            @grille.appliquerCoup(coup.x, coup.y, (coup.etat+1)%3)
            if(@historiqueCurseur < @historique.size()-1)
                @historiqueCurseur += 1
            end
            # @doneRedo = true

            monitor
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

            monitor
        end
    end

    def monitor
        @grille.afficher()
        p @historique
        print "Cursor = ", @historiqueCurseur, "| Size = ", @historique.size(), " | Next : ", @historique[@historiqueCurseur], "\n"
        puts
    end

    #TODO reset grille
end
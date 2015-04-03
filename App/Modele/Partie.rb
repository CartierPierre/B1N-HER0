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

        @cpttest = 0
    end

    # Enregistre un coup est l'état de la tuile avant ce coup
    #
    # === Argument
    # *coup* - Le coup joué.
    def historiqueAdd(coup)
        # Vide l'historique si pour coller avec les undo
        puts (@historique.size() - @historiqueCurseur)-1
        1.upto((@historique.size() - @historiqueCurseur)-1) do
            @historique.pop()
        end

        # Ajoute le nouveau coup à l'historique
            # S'il est au même endroit que le précédent
        if((@historique.size > 0) && (@historique.last().x == coup.x && @historique.last().y == coup.y))
            # Si son état précédent est à 2 = on revient au point de départ
            if(coup.etat == Etat.etat_2)
                # On pop les deux dernier état qui ne sont plus utiles
                @historique.pop()
                @historique.pop()
            else
                # Si l'état précedent est différent de 2 (aka la case est de nouveau vide on push)
                @historique.push(coup)
            end
        else
            # Sinon on ajoute le nouveau coup à l'historique
            @historique.push(coup)
        end

        # On recalcule le curseur d'historique pour être sur de ne pas sortir des bornes de l'historique
        @historiqueCurseur = @historique.size() - 1

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
            @grille.appliquerCoup(coup.x, coup.y, Etat.suivant(coup.etat))
            if(@historiqueCurseur < @historique.size()-1)
                @historiqueCurseur += 1
            end
            # @doneRedo = true

            monitor
           return Array[ coup.x, coup.y ]
        end

        return nil
    end

    #Recommence la grille
    def recommencer()
        @grille = Grille.creer(niveau.grilleInitial.taille).copier(niveau.grilleInitial)
        @historique = Array.new()
        @historiqueCurseur = 0
    end

    #Permet de jouer un coup
    def jouerCoup(x, y)#TODO signale un coup invalide
        if @niveau.tuileValide?(x, y)
            historiqueAdd(Coup.creer(x, y, @grille.getTuile(x, y).etat()))
            t = Etat.suivant(@grille.getTuile(x, y).etat())
            @grille.appliquerCoup(x, y, t)
            @score.incNbCoups()

            monitor
        end
    end

    # Vérifie si la grille est comforme à la grille solution.
    #
    # === Retourne
    # Un booléen indiquant si la grille est valide.
    def valider()
        0.upto(@grille.taille() - 1) do |x|
            0.upto(@grille.taille() - 1) do |y|
                if(Etat.egale?(@grille.getTuile(x, y).etat, @niveau.grilleSolution.getTuile(x, y).etat))
                    return false
                end
            end
        end

        return true
    end

    @cpttest
    def monitor
        @cpttest += 1
        print "\nN° ", @cpttest, "\n"
        @grille.afficher()
        puts @historique
        print "Cursor = ", @historiqueCurseur, "| Size = ", @historique.size(), " | Next : ", @historique[@historiqueCurseur], "\n"
    end

    #TODO reset grille
end
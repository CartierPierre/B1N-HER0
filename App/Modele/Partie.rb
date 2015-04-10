require 'time'

class Partie
    attr_reader :grille, :niveau, :score, :utilisateur
    @dateDebutPartie
    @listeUndo
    @listeRedo

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
        @grille = Grille.creer(niveau.probleme.taille).copier(niveau.probleme)
        @dateDebutPartie = Time.new()
        #@score = Score.creer( 0, 0, 0, 0, @utilisateur.id, @niveau.id)

        @listeUndo = Array.new()
        @listeRedo = Array.new()
        
        @modeHypo=0

        @cpttest = 0
    end

    def charger(data)
        tabData = data.split("|")
        @grille.charger(tabData[0])

        @listeUndo.clear()
        tabData[1].split(";").each do |coupData|
            tabCoup = coupData.split(",")
            coup = Coup.creer(tabCoup[0], tabCoup[1], tabCoup[2])
            @listeUndo.push(coup)
        end

        @listeRedo.clear()
        tabData[2].split(";").each do |coupData|
            tabCoup = coupData.split(",")
            coup = Coup.creer(tabCoup[0], tabCoup[1], tabCoup[2])
            @listeRedo.push(coup)
        end
    end

    def sauvegarder()
        data = String.new()
        data += grille.sauvegarder()
        data += "|"
        0.upto(@listeUndo.size() - 1) do |i|
            coup = @listeUndo[i]
            data += "#{coup.x},#{coup.y},#{coup.etat}"
            if(i != (@listeUndo.size() - 1))
                data += ";"
            end
        end
        data += "|"
        0.upto(@listeRedo.size() - 1) do |i|
            coup = @listeUndo[i]
            data += "#{coup.x},#{coup.y},#{coup.etat}"
            if(i != (@listeUndo.size() - 1))
                data += ";"
            end
        end

        return data
    end

    # Enregistre un coup est l'état de la tuile avant ce coup
    #
    # === Argument
    # *coup* - Le coup joué.
    def historiqueAdd(coup)
        # Vide l'historique si pour coller avec les undo
       @listeRedo.clear()

        # Ajoute le nouveau coup à l'historique
            # S'il est au même endroit que le précédent
        if((@listeUndo.size > 0) && (@listeUndo.last().x == coup.x && @listeUndo.last().y == coup.y))
            # Si son état précédent est à 2 = on revient au point de départ
            if(coup.etat == Etat.etat_2)
                # On pop les deux dernier état qui ne sont plus utiles
                @listeUndo.pop()
                @listeUndo.pop()
            else
                # Si l'état précedent est différent de 2 (aka la case est de nouveau vide on push)
                @listeUndo.push(coup)
            end
        else
            # Sinon on ajoute le nouveau coup à l'historique
            @listeUndo.push(coup)
        end

        self
    end

    # Efface un coup jouer
    def historiqueUndo()
        if(@listeUndo.size > 0)
            coup = @listeUndo.pop()
            @listeRedo.push(coup)
            @grille.appliquerCoup(coup.x, coup.y, coup.etat)

            monitor
            return Array[ coup.x, coup.y ]
        end

        return nil
    end

    # Efface un coup jouer
    def historiqueRedo()
        if(@listeRedo.size > 0)
            coup = @listeRedo.pop()
            @listeUndo.push(coup)
            @grille.appliquerCoup(coup.x, coup.y, Etat.suivant(coup.etat))

            monitor
           return Array[ coup.x, coup.y ]
        end

        return nil
    end

    #Recommence la grille
    def recommencer()
        @grille = Grille.creer(niveau.probleme.taille).copier(niveau.probleme)
        @listeUndo = Array.new()
        @listeRedo = Array.new()
    end

    #Permet de jouer un coup
    def jouerCoup(x, y)#TODO signale un coup invalide
        if @niveau.tuileValide?(x, y)
            historiqueAdd(Coup.creer(x, y, @grille.getTuile(x, y).etat()))
            t = Etat.suivant(@grille.getTuile(x, y).etat())
            @grille.appliquerCoup(x, y, t)

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
                if(Etat.egale?(@grille.getTuile(x, y).etat, @niveau.solution.getTuile(x, y).etat))
                    return false
                end
            end
        end

        return true
    end

    # Donne le nombre de case de chaque état d'une ligne
    def compterCasesLigne(x)
        nbEtat = Array[0, 0]
        @grille.getLigne(x).each do |tuile|
            if(tuile.etat == Etat.etat_1 || tuile.etat == Etat.lock_1)
                nbEtat[0] += 1
            elsif(tuile.etat == Etat.etat_2 || tuile.etat == Etat.lock_2)
                nbEtat[1] += 1
            end
        end

        return nbEtat
    end

    # Donne le nombre de case de chaque état d'une colonne
    def compterCasesColonne(y)
        nbEtat = Array[0, 0]
        @grille.getColonne(y).each do |tuile|
            if(tuile.etat == Etat.etat_1 || tuile.etat == Etat.lock_1)
                nbEtat[0] += 1
            elsif(tuile.etat == Etat.etat_2 || tuile.etat == Etat.lock_2)
                nbEtat[1] += 1
            end
        end

        return nbEtat
    end

    @cpttest
    def monitor
        @cpttest += 1
        print "\nN° ", @cpttest, "\n"
        @grille.afficher()
        puts "Liste des undo :", @listeUndo, "\n"
        puts "Liste des redo :", @listeRedo, "\n"
        print "Size Undo = ", @listeUndo.size(), "| Size Redo = ", @listeRedo.size(), "\n"
    end

    #TODO reset grille
end
##
# La classe Partie permet de créer et utiliser des objet Partie.
# Cette classe à besoin des classes Chrono, Coup, Etat, Grille, Niveau et Score pour fonctionner.

class Partie
    attr_reader :grille, :niveau, :score, :utilisateur, :chrono, :hypoActif
    @listeUndo
    @listeRedo

    ##
    # Méthode de création d'une Partie.
    #
    # Paramétres::
    #   * _utilisateur_ - Utilisateur qui joue la partie.
    #   * _niveau_ - Le Niveau sur lequel ce base la partie.
    #
    private_class_method :new
    def Partie.creer(utilisateur, niveau)
        new(utilisateur, niveau)
    end

    def initialize(utilisateur, niveau)
        @utilisateur = utilisateur
        @niveau = niveau
        @grille = Grille.creer(niveau.probleme.taille).copier(niveau.probleme)
        @chrono = Chrono.creer()
        #@score = Score.creer( 0, 0, 0, 0, @utilisateur.id, @niveau.id)

        @listeUndo = Array.new()
        @listeRedo = Array.new()

        @hypoActif = false

        @cpttest = 0
    end

    ##
    # (Désérialisation)
    # Charge une Partie avec l'utilisateur, le niveau et les données passés en paramétre.
    #
    # Paramétres::
    #   * _utilisateur_ - Utilisateur de la Partie.
    #   * _niveau_ - Le Niveau sur lequel ce base la Partie.
    #   * _donnee_ - Une chaine de caractère correspondant à la sérialisation de la Partie.
    #
    # Retour::
    #   Une nouvelle partie construite à partir des paramètres donnés.
    #
    def Partie.charger(utilisateur, niveau, donnee)
        # Crée un nouvelle partie
        partie = Partie.creer(utilisateur, niveau)

        # Sépare les différents champs des données dans un tableau
        donnees = donnee.split("|")

        # Charge le chrono avec les données sérialisée du chrono
        partie.setChrono(Chrono.charger(donnees[0]))

        # Charge la grille avec les données sérialisée de la grille
        partie.setGrille(Grille.charger(donnees[1]))

        # On remet en place la liste des undo
        if(donnees[2])
            donnees[2].split(";").each do |coupDonnee|
                tabCoup = coupDonnee.split(",")
                coup = Coup.creer(tabCoup[0].to_i, tabCoup[1].to_i, Etat.stringToEtat(tabCoup[2]))
                partie.addUndo(coup)
            end
        end

        # On remet en place la liste des redo
        if(donnees[3])
            donnees[3].split(";").each do |coupDonnee|
                tabCoup = coupDonnee.split(",")
                coup = Coup.creer(tabCoup[0].to_i, tabCoup[1].to_i, Etat.stringToEtat(tabCoup[2]))
                partie.addRedo(coup)
            end
        end

        return partie
    end

    def addUndo(coup)
        @listeUndo.push(coup)
    end

    def addRedo(coup)
        @listeRedo.push(coup)
    end

    def setChrono(chrono)
        @chrono = chrono
    end

    def setGrille(grille)
        @grille = grille
    end

    ##
    # (Sérialisation)
    # Sauvegarde une partie en chaine de caractéres.
    #
    # Retour::
    #   Une chaine de caractéres correspondant à l'état de la partie.
    #
    def sauvegarder()
        data = String.new()

        # Sérialisation du chrono
        data += @chrono.sauvegarder

        data += "|"

        # Sérialisation de la grille
        data += grille.sauvegarder()

        data += "|"

        # Sérialisation de la liste des undo
        0.upto(@listeUndo.size() - 1) do |i|
            coup = @listeUndo[i]
            data += "#{coup.x},#{coup.y},#{Etat.etatToString(coup.etat)}"
            if(i != (@listeUndo.size() - 1))
                data += ";"
            end
        end

        data += "|"

        # Sérialisation de la liste des redo
        0.upto(@listeRedo.size() - 1) do |i|
            coup = @listeRedo[i]
            data += "#{coup.x},#{coup.y},#{Etat.etatToString(coup.etat)}"
            if(i != (@listeRedo.size() - 1))
                data += ";"
            end
        end

        return data
    end

    ##
    # Ajoute à l'historique l'emplacement du Coup avec l'état de la Tuile avant le Coup.
    #
    # Paramétre::
    #   * _coup_ - Le Coup joué
    #
    def historiqueAjouter(coup)
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

    ##
    # Enlève un Coup joué.
    #
    # Retour::
    #   Un tableau contenant la coordonnée x et la coodonnée y du Coup.
    #
    def historiqueUndo()
        if(@listeUndo.size > 0)
            coup = @listeUndo.pop()
            @listeRedo.push(coup)
            @grille.setTuile(coup.x, coup.y, coup.etat)

            return Array[ coup.x, coup.y ]
        end

        return nil
    end

    ##
    # Remet en place un Coup joué.
    #
    # Retour::
    #   Un tableau contenant la coordonnée x et la coodonnée y du Coup.
    #
    def historiqueRedo()
        if(@listeRedo.size > 0)
            coup = @listeRedo.pop()
            @listeUndo.push(coup)
            @grille.setTuile(coup.x, coup.y, Etat.suivant(coup.etat))

           return Array[ coup.x, coup.y ]
        end

        return nil
    end

    ##
    # Remet à zéro la Partie en cours.
    #
    def recommencer()
        @grille = Grille.creer(niveau.probleme.taille).copier(niveau.probleme)
        @listeUndo = Array.new()
        @listeRedo = Array.new()
    end

    ##
    # Joue un Coup aux coordonnées données.
    #
    # Paramétres::
    #   * _x_ - La coordonnée x du Coup.
    #   * _y_ - La coordonnée y du Coup.
    #
    def jouerCoup(x, y)#TODO signale un coup invalide
        if @niveau.tuileValide?(x, y)
            historiqueAjouter(Coup.creer(x, y, @grille.getTuile(x, y).etat()))
            t = Etat.suivant(@grille.getTuile(x, y).etat())
            @grille.setTuile(x, y, t)

            monitor
        end
    end

    ##
    # Vérifie si la Grille est comforme à la Grille solution.
    #
    # Retour::
    #   Un booléen indiquant si la Grille est valide.
    #
    def valider()
        @grille.afficher()
        @niveau.solution.afficher()
        0.upto(@grille.taille() - 1) do |x|
            0.upto(@grille.taille() - 1) do |y|
                if(!Etat.egale?(@grille.getTuile(x, y).etat, @niveau.solution.getTuile(x, y).etat))
                    return false
                end
            end
        end

        return true
    end

    ##
    # Donne le nombre de case de chaque Etat de la ligne demandée.
    #
    # Paramétre::
    #   * _x_ - La coordonnée de la ligne.
    #
    # Retour::
    #   Un tableau contenant respectivement le nombre de case à l'état 1 et le nombre de case à l'état 2.
    #
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

    ##
    # Donne le nombre de case de chaque Etat de la colonne demandée.
    #
    # Paramétre::
    #   * _y_ - La coordonnée de la colonne.
    #
    # Retour::
    #   Un tableau contenant respectivement le nombre de case à l'état 1 et le nombre de case à l'état 2.
    #
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
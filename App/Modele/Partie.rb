##
# La classe Partie permet de créer et utiliser des objets Partie.
# Cette classe à besoin des classes Chrono, Coup, Etat, Grille, Niveau et Score pour fonctionner.
#

class Partie
    attr_reader :grille, :niveau, :utilisateur, :chrono, :modeHypothese, :nbCoups, :nbConseils, :nbAides
    @listeUndo
    @listeRedo
    @regles
    @partieHypothese

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
        @grille = Grille.creer(niveau.dimention).copier(niveau.probleme)
        @chrono = Chrono.creer()
        @chrono.start()

        @listeUndo = Array.new()
        @listeRedo = Array.new()

        @regles = Array.new()
        @regles.push(RegleUn.instance())
        @regles.push(RegleDeux.instance())
        @regles.push(RegleTrois.instance())

        @modeHypothese = false

        @nbCoups = 0
        @nbConseils = 0
        @nbAides = 0

        @cpttest = 0
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
        @modeHypothese = false
        @chrono.start()

        self
    end

    ##
    # Joue un Coup aux coordonnées données.
    #
    # Paramétres::
    #   * _x_ - La coordonnée x du Coup.
    #   * _y_ - La coordonnée y du Coup.
    #
    def jouerCoup(x, y)
        if(!(@grille.getTuile(x, y).etat == Etat.lock_1) && !(@grille.getTuile(x, y).etat == Etat.lock_2))
            historiqueAjouter(Coup.creer(x, y, @grille.getTuile(x, y).etat()))
            t = Etat.suivant(@grille.getTuile(x, y).etat())
            @grille.setTuile(x, y, t)

            @nbCoups += 1
        end
    end

    ##
    # Vérifie si la Grille est comforme à la Grille solution.
    #
    # Retour::
    #   Un booléen indiquant si la Grille est valide.
    #
    def valider()
        0.upto(@grille.taille() - 1) do |x|
            0.upto(@grille.taille() - 1) do |y|
                if(!Etat.egale?(@grille.getTuile(x, y).etat, @niveau.solution.getTuile(x, y).etat))
                    return false
                end
            end
        end
        @chrono.stop()
        return true
    end



    ############################
    #                          #
    # =>  AIDE / CONSEILLE  <= #
    #                          #
    ############################

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

    ##
    # Applique toutes les régles sur la Partie.
    #
    # Retour::
    #   Renvoie nil si aucun problème n'est présent, sinon un Array contenant si le problème vient d'une ligne ou un colonne, le numéro de celle-ci et la régle qui a été appliquée.
    #
    def appliquerRegles()
        resultat = nil
        @regles.each do |regle|
            if( (resultat = regle.appliquer(self)) )
                @nbConseils += 1
                return resultat
            end
        end
        return resultat
    end

    ##
    # Méthode qui donne une case valide de la solution pour aider le joueur.
    #
    # Retour::
    #   Un tableau de coordonées de la case solution choisie aléatoirement selon les meilleurs aides possibles, sinon nil si aucune aide n'est possible. Array[x, y]
    #
    def demanderAide() #TODO améliorer pour donnée une case qui débloque une régle
        casesPossible = Array.new()
        meilleurCases = Array[-1, -1, 10]

        # Parcours la grille à la recherche de cases pourvant aider.
        0.upto(@grille.taille() - 1) do |x|
            0.upto(@grille.taille() - 1) do |y|
                # Elle doit être soit vide, soit fausse
                if(@grille.getTuile(x, y).estVide?() || !Etat.egale?(@grille.getTuile(x, y).etat, @niveau.solution.getTuile(x, y).etat))
                    nbVoisin = Array[x, y, 0]

                    # On parcours les cases alentour pour voir si l'aide serait utile.
                    (x-1).upto(x+1) do |i|
                        (y-1).upto(y+1) do |j|
                            if(i >= 0 && j >= 0 && i < @grille.taille() && j < @grille.taille() && !(i == x && j == y))
                                # La cases est dans la grille...
                                if(!@grille.getTuile(i, j).estVide?())
                                    # Elle n'est pas vide, on augmente le nombre de voisin.
                                    nbVoisin[2] += 1
                                end
                            elsif(i == x && j == y && !(i-1 >= 0 && j-1 >= 0 && i+1 < @grille.taille() && j+1 < @grille.taille()))
                                # La case est vide mais sur un bord, on la compte comme un voisin pour ne pas toujours aider sur les bords.
                                nbVoisin[2] += 1
                            end
                        end # Upto j
                    end # Upto i

                    # La nouvelle cases est meilleur que l'ancienne, on la change et vide les cases possibles.
                    if(nbVoisin[2] < meilleurCases[2])
                        meilleurCases = nbVoisin
                        casesPossible.clear()
                    # La nouvelle cases est égales à l'ancienne, on l'ajoute aux cases possibles.
                    elsif(nbVoisin[2] == meilleurCases[2])
                        casesPossible.push(meilleurCases)
                        meilleurCases = nbVoisin
                    end
                end
            end # Upto y
        end # Upto x

        if(meilleurCases[0] != -1 && meilleurCases[1] != -1)
            casesPossible.push(meilleurCases)
        end

        if(meilleurCases = casesPossible.sample())
            @grille.setTuile(meilleurCases[0], meilleurCases[1], @niveau.solution.getTuile(meilleurCases[0], meilleurCases[1]).etat())
            @nbAides += 1
            return Array[meilleurCases[0], meilleurCases[1]]
        end

        return nil
    end



    #############################
    #                           #
    # =>    SÉRIALISATION    <= #
    #                           #
    #############################

    ##
    # (Sérialisation)
    # Sauvegarde une partie en chaine de caractéres.
    #
    # Retour::
    #   Une chaine de caractéres correspondant à l'état de la partie, avec chaque champs séparer par un '|', sous la forme :
    #    self.sauvegarder #=> "donnees_chrono|donnees_grille|liste_undo|liste_redo|donnees_hypothese"
    #
    #   - *donnees_chrono* : aller voir Chrono.sauvegarder.
    #        self.sauvegarder.split('|')[0] #=> "true;50:37:17:20:4:2015:1:110:true:CEST;;"
    #
    #   - *donnees_grille* : aller voir Grille.sauvegarder.
    #        self.sauvegarder.split('|')[1] #=> "003________1_3__0_22112______0_0_1__"
    #
    #   - *liste_undo* : une liste de Coup séparer par des ';'. Aller voir Coup.sauvegarder.
    #        self.sauvegarder.split('|')[2] #=> "5,0,_;5,0,2;3,0,_;2,1,_;2,1,2;5,0,3"
    #
    #   - *liste_redo* : une liste de Coup séparer par des ';'. Aller voir Coup.sauvegarder.
    #        self.sauvegarder.split('|')[3] #=> "1,3,2;1,3,_"
    #
    #   - *donnees_hypothese* : un bouléen indiquant si le mode hypothése est activé, suivit par un '#', puis la sérialisation de la Partie avec les '|' remplacer pas des '/'.
    #        self.sauvegarder.split('|')[4] #=> "true#true;40:55:17:20:4:2015:1:110:true:CEST;;/003________1____0__2112______0_0_1__/0,2,_;0,2,2;3,4,_;3,1,_//false"
    #
    def sauvegarder()
        data = String.new()

        # Sérialisation du nombre de coups joués
        data += @nbCoups.to_s

        data += "|"

        # Sérialisation du nombre de conseils utilisées
        data += @nbConseils.to_s

        data += "|"

        # Sérialisation du nombre d'aides utilisées
        data += @nbAides.to_s

        data += "|"

        # Sérialisation du chrono
        data += @chrono.sauvegarder

        data += "|"

        # Sérialisation de la grille
        data += grille.sauvegarder()

        data += "|"

        # Sérialisation de la liste des undo
        0.upto(@listeUndo.size() - 1) do |i|
            data += @listeUndo[i].sauvegarder
            if(i != (@listeUndo.size() - 1))
                data += ";"
            end
        end

        data += "|"

        # Sérialisation de la liste des redo
        0.upto(@listeRedo.size() - 1) do |i|
            data += @listeRedo[i].sauvegarder
            if(i != (@listeRedo.size() - 1))
                data += ";"
            end
        end

        data += "|"

        data += @modeHypothese.to_s

        if(@modeHypothese)
            data += "#" + @partieHypothese.gsub(/\|/, '/')
        end

        return data
    end

    ##
    # (Désérialisation)
    # Charge une Partie avec l'utilisateur, le niveau et les données passés en paramétre.
    #
    # Paramétres::
    #   * _utilisateur_ - Utilisateur de la Partie.
    #   * _niveau_ - Le Niveau sur lequel ce base la Partie.
    #   * _donnee_ - Une chaine de caractère correspondant à la sérialisation de la Partie. Aller voir Partie.sauvegarder
    #
    # Retour::
    #   Une nouvelle partie construite à partir des paramètres donnés.
    #
    def Partie.charger(utilisateur, niveau, sauvegarde)
        # Crée un nouvelle partie
        partie = Partie.creer(utilisateur, niveau)

        # Sépare les différents champs des données dans un tableau
        donnees = sauvegarde.contenu.split("|")

        # Charge le nombre de coups joués
        partie.setNbCoups(donnees[0].to_i)

        # Charge le nombre de conseils utilisées
        partie.setNbConseils(donnees[2].to_i)

        # Charge le nombre d'aides utilisées
        partie.setNbAides(donnees[1].to_i)

        # Charge le chrono avec les données sérialisée du chrono
        partie.setChrono(Chrono.charger(donnees[3]))

        # Charge la grille avec les données sérialisée de la grille
        partie.setGrille(Grille.charger(donnees[4]))

        # On remet en place la liste des undo
        if(donnees[5])
            partie.chargerUndo(donnees[5])
        end

        # On remet en place la liste des redo
        if(donnees[6])
            partie.chargerRedo(donnees[6])
        end

        # On remet en place le mode hypothése
        if(donnees[7])
            donneesHypothese = donnees[7].split('#')

            if(donneesHypothese[0] == 'true')
                partie.setModeHypothese(true)
                partie.setPartieHypothese(donneesHypothese[1].gsub(/\//, "|"))
            else
                partie.setModeHypothese(false)
            end
        end

        return partie
    end

    def chargerUndo(donnee)
        donnee.split(";").reverse.each do |coupDonnee|
            @listeUndo.unshift(Coup.charger(coupDonnee))
        end
    end
    #protected :chargerUndo

    def chargerRedo(donnee)
        donnee.split(";").reverse.each do |coupDonnee|
            @listeRedo.unshift(Coup.charger(coupDonnee))
        end

        self
    end
    #protected :chargerRedo

    def setChrono(chrono)
        @chrono = chrono

        self
    end
    #protected :setChrono

    def setGrille(grille)
        @grille = grille

        self
    end
    #protected :setGrille

    def setModeHypothese(bool)
        @modeHypothese = bool

        self
    end
    #protected :setModeHypothese

    def setPartieHypothese(donnee)
        @partieHypothese = donnee

        self
    end

    def setNbCoups(nb)
        @nbCoups = nb
    end

    def setNbAides(nb)
        @nbAides = nb
    end


    def setNbConseils(nb)
        @nbConseils = nb
    end




    ##############################
    #                            #
    # =>    MODE HYPOTHÉSE    <= #
    #                            #
    ##############################

    ##
    # Active le mode hypothése sur la partie.
    #
    def activerModeHypothese()
        if(!@modeHypothese)
            @partieHypothese = sauvegarder  # Sauvegarde la partie actuelle
            @listeUndo = Array.new()        # Remet à zéro les Undos
            @listeRedo = Array.new()        # Remet à zéro les Redos
            @modeHypothese = true           # Indique que le mode est actif
        end

        self
    end

    ##
    # Valide le mode hypothése pour le fusionner avec la partie.
    #
    def validerHypothese()
        if(@modeHypothese)
            # Sépare les différents champs des données dans un tableau
            donnees = @partieHypothese.split("|")

            # On remet en place la liste des undo
            if(donnees[5])
                chargerUndo(donnees[5])
            end

            # On remet en place la liste des redo
            if(donnees[6])
                chargerRedo(donnees[6])
            end

            @modeHypothese = false
        end

        self
    end

    ##
    # Annule le mode hypothése et remet la partie dans l'état à laquelle elle se trouver avant l'activation du mode hypothése.
    #
    def annulerHypothese()
        if(@modeHypothese)
            @listeUndo = Array.new()        # Remet à zéro les Undos
            @listeRedo = Array.new()        # Remet à zéro les Redos

            # Sépare les différents champs des données dans un tableau
            donnees = @partieHypothese.split("|")

            # Charge la grille avec les données sérialisée de la grille
            @grille = Grille.charger(donnees[4])

            # On remet en place la liste des undo
            if(donnees[5])
                chargerUndo(donnees[5])
            end

            # On remet en place la liste des redo
            if(donnees[6])
                chargerRedo(donnees[6])
            end

            @modeHypothese = false
        end

        self
    end

    @cpttest
    def monitor
        @cpttest += 1
        print "N° ", @cpttest, "#{(@modeHypothese ? ' (Mode Hypothése)' : '')}\n"
        @grille.afficher()
        puts "Liste des undo :", @listeUndo, "\n"
        puts "Liste des redo :", @listeRedo, "\n"
        print "Size Undo = ", @listeUndo.size(), "| Size Redo = ", @listeRedo.size(), "\n"
        print "\n"

        self
    end
end
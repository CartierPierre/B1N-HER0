##
# La classe Grille permet de créer et utiliser des grilles.
# Cette classe à besoin des classes Tuile et Etat pour fonctionner.
#

class Grille
    @grille
    attr_reader :taille

    private_class_method :new
    ##
    # Méthode de création d'une Grille.
    #
    # Paramétre::
    #   * _taille_ - La _taille_ de la Grille.
    #
    def Grille.creer(taille)
        new(taille)
    end

    def initialize(taille)
        @taille = taille

        #Création d'un tableau de tableau de tuile
        @grille =   Array.new(@taille) { Array.new(@taille) { Tuile.creer() } }
    end

    ##
    # Donne la Tuile aux coordonnées données.
    #
    # Paramétres::
    #   * _x_ - La coordonnée _x_ de la Tuile cherchée.
    #   * _y_ - La coordonnée _y_ de la Tuile cherchée.
    #
    # Retour::
    #   La Tuile ciblé par les coordonnées, sinon nil.
    #
    def getTuile(x, y)
        if(0 <= x && x < @taille && 0 <= y && y < @taille)
            return @grille[x][y]
            return nil
        end
    end

    ##
    # Modifie l'état de la Tuile aux coordonnées données.
    #
    # Paramétres::
    #   * _x_ - La coordonnée _x_ de la Tuile cherchée..
    #   * _y_ - La coordonnée _y_ de la Tuile cherchée..
    #   * _etat_ - Le nouvel _etat_ de la Grille..
    #
    def setTuile(x, y, etat)
        if(0 <= x && x < @taille && 0 <= y && y < @taille)
            getTuile(x, y).etat = etat
        end

        self
    end

    ##
    # Donne la ligne de la Grille à la coordonnée donnée.
    #
    # Paramétre::
    #   * _x_ - La coordonnée de la ligne ciblée.
    #
    # Retour::
    #   La ligne ciblée si trouvée sous forme de tableau, sinon nil.
    #
    def getLigne(x)
        if(0 <= x && x < @taille)
            return @grille[x]
        else
            return nil
        end
    end

    ##
    # Donne la colonne de la Grille à la coordonnée donnée.
    #
    # Paramétre::
    #   * _y_ - La coordonnée de la colonne ciblée.
    #
    # Retour::
    #   La colonne ciblée si trouvée sous forme de tableau, sinon nil.
    #
    def getColonne(y)
        if(0 <= y && y < @taille)
            newColonne = Array.new(@taille)

            0.upto(@taille -1) do |i|
                newColonne[i] = self.getTuile(i, y)
            end
        else
            newColonne = nil
        end

        return newColonne
    end




    #############################
    #                           #
    # =>    SÉRIALISATION    <= #
    #                           #
    #############################

    ##
    # (Désérialisation)
    # Charge une Grille à partir du modèle donné.
    #
    # Paramétre::
    #   * _modele_ - Une chaine de caractères correspondant au modèle de la Grille.
    #
    # Retour::
    #   Une Grille initialisée avec le modéle désiré.
    #
    def Grille.charger(modele)
        return Grille.creer(Math.sqrt(modele.size)).initFrom(modele)
    end

    ##
    # (Sérialisation)
    # Sauvegarde une Grille en chaine de caractères.
    #
    # Retour::
    #   Une chaine de caractères correspondant à l'état de la Grille.
    #
    def sauvegarder()
        modele = String.new()

        0.upto(taille-1) do |x|
            0.upto(taille-1) do |y|
                modele += Etat.etatToString(@grille[x][y].etat)
            end
        end

        return modele
    end

    ##
    # Initialise une Grille à partir du modéle donné.
    #
    # Paramétre::
    #   * _modele_ - Une chaine de caractères correspondant au modéle à appliquer à la Grille.
    #
    def initFrom(modele)
        tab = modele.split(//);
        taille = Math.sqrt(modele.size)

        0.upto(taille) do |x|
            0.upto(taille) do |y|
                self.setTuile(x, y, Etat.stringToEtat(tab[(x*taille)+y]))
            end
        end

        self
    end

    ##
    # Copie l'état d'une Grille pour le mettre dans la Grille appelante.
    #
    # Paramétre::
    #   * _grille_ - La Grille à copier.
    #
    def copier(grille)
        0.upto(self.taille() - 1) do |i|
            0.upto(self.taille() - 1) do |j|
                self.setTuile(i, j, grille.getTuile(i, j).etat)
            end
        end

        self
    end

    ##
    # Crée un nouvelle Grille à partir de la Grille donnée.
    #
    # Paramétre::
    #   * _grille_ - La Grille à dupliquer.
    #
    # Retour::
    #   Une nouvelle Grille basée sur la première.
    #
    def Grille.dupliquer(grille)
        nouvelleGrille = Grille.creer(grille.taille())
        0.upto(grille.taille() - 1) do |i|
            0.upto(grille.taille() - 1) do |j|
                nouvelleGrille.setTuile(i, j, grille.getTuile(i, j).etat)
            end
        end

        return nouvelleGrille;
    end

    ##
    # Affiche la Grille sous la forme :
    # 
    #   X\Y│ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │
    #   ───┼───┼───┼───┼───┼───┼───┤
    #    0 │ O │ O │   │   │   │   │
    #   ───┼───┼───┼───┼───┼───┼───┤
    #    1 │   │   │   │   │   │ X │
    #   ───┼───┼───┼───┼───┼───┼───┤
    #    2 │   │   │   │   │ O │   │
    #   ───┼───┼───┼───┼───┼───┼───┤
    #    3 │   │   │ X │ X │   │   │
    #   ───┼───┼───┼───┼───┼───┼───┤
    #    4 │   │   │   │   │   │ O │
    #   ───┼───┼───┼───┼───┼───┼───┤
    #    5 │   │ O │   │ X │   │   │
    #   ───┴───┴───┴───┴───┴───┴───┘
    #
    def afficher()
        print self

        self
    end

    ##
    # Convertie la Grille en chaine de caractère affichable dans le terminal.
    #
    # Retour::
    #   Une chaine de caractéres représentant la Grille.
    #
    def to_s()
        n = String.new()

        n += "X\\Y│ "
        0.upto(self.taille() - 1) do |i|
            n += i.to_s + " │ "
        end
        n += "\n"
        0.upto(self.taille() - 1) do |i|
            n += "───┼"*(self.taille()) + "───┤\n"
            n += " " + i.to_s + " │ "
            0.upto(self.taille() - 1) do |j|
                n += "#{(@grille[i][j].etat==Etat.etat_1) ? 'O' : ((@grille[i][j].etat==Etat.etat_2) ? 'X' : ((@grille[i][j].etat==Etat.lock_1) ? 'Ⓞ' : ((@grille[i][j].etat==Etat.lock_2) ? 'Ⓧ' : ' ')))} │ "
            end
            n += "\n"
        end
        n += "───┴"*(self.taille()) + "───┘\n"

        return n
    end

    ##
    # Détermine si la grille est remplie ou non
    #
    # Retour::
    #   Vrai si la grille est remplie, faux sinon
    #
    def estRemplie?()
        0.upto(self.taille() - 1) do |i|
            0.upto(self.taille() - 1) do |j|
                if(self.getTuile(i,j).estVide?())
                    return false
                end
            end
        end
        return true
    end
end
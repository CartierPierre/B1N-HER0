# ajouter sérialisation !!!

class Grille
    @grille
    # attr_reader :nbLigne, :nbColonne
    attr_reader :taille

    private_class_method :new
    # Méthode de création d'une grille
    #
    # === Arguments
    # *nbLigne* - Nombre de ligne que contient la grille
    # *nbColonne* - Nombre de colonne que contient la grille
    def Grille.creer(taille)
        new(taille)
    end

    def initialize(taille)
        @taille = taille

        #Création d'un tableau de tableau de tuile
        @grille =   Array.new(@taille) { Array.new(@taille) { Tuile.creer() } }
    end

    # Permet d'obtenir une tuile à des coordonnées données
    #
    # === Arguments
    # *x* - La coordonnée x de la tuile cherchée
    # *y* - La coordonnée y de la tuile cherchée
    #
    # === Retour
    # La tuile ciblé par les coordonnées, si elle n'est pas dans les coordonnées données renvoie une nouvelle tuile
    def getTuile(x, y) #TODO Générer une execption
        #if(0 <= x && x < @nbLigne && 0 <= y && y < @nbColonne)
        if(0 <= x && x < @taille && 0 <= y && y < @taille)
            return @grille[x][y]
        else
            return Tuile.creer()
        end
    end

    # Permet de modifier l'état d'une tuile à des coordonnées données
    #
    # === Arguments
    # *x* - La coordonnée x de la tuile cherchée
    # *y* - La coordonnée y de la tuile cherchée
    # *etat* - Le nouvel état de la grille
    def setTuile(x, y, etat) #TODO Générer une execption
        # if(0 <= x && x < @nbLigne && 0 <= y && y < @nbColonne)
        if(0 <= x && x < @taille && 0 <= y && y < @taille)
            getTuile(x, y).etat = etat
        else
            #TODO
        end
        self
    end

    # Permet d'obtenir une ligne de la grille
    #
    # === Argument
    # *x* - La coordonnée de la ligne ciblée
    #
    # === Retour
    # La ligne ciblée si trouvée, sinon une nouvelle ligne
    def getLigne(x) #TODO Générer une execption
        # if(0 <= x && x < @nbLigne)
        if(0 <= x && x < @taille)
            return @grille[x]
        else
            #return  Array.new(@nbLigne) { Tuile.creer() }
            return  Array.new(@taille) { Tuile.creer() }
        end
    end

    # Permet d'obtenir une colonne de la grille
    #
    # === Argument
    # *y* - La coordonnée de la colonne ciblée
    #
    # === Retour
    # La colonne ciblée si trouvée, sinon une nouvelle colonne
    def getColonne(y) #TODO Générer une execption
        # if(0 <= y && y < @nbColonne)
        if(0 <= y && y < @taille)
            newColonne = Array.new(@taille)

            0.upto(@taille -1) do |i|
                newColonne[i] = self.getTuile(i, y)
            end
        else
            # newColonne = Array.new(@nbLigne) { Tuile.creer() }
            newColonne = Array.new(@taille) { Tuile.creer() }
        end

        return newColonne
    end

    # Permet de charger le modèle de grille pour l'appliquer à la grille
    #
    # === Argument
    # *data* - Une string correspondant au modèle de la grille
    def Grille.charger(data)
        return Grille.creer(Math.sqrt(data.size)).initFrom(data)
    end

    def sauvegarder()
        modele = String.new()
        0.upto(taille-1) do |x|
            0.upto(taille-1) do |y|
                case @grille[x][y].etat
                    when Etat.vide
                        modele += "_"
                    when Etat.lock_1
                        modele += "0"
                    when Etat.lock_2
                        modele += "1"
                    when Etat.etat_1
                        modele += "2"
                    when Etat.etat_2
                        modele += "3"
                    else
                        modele += "_"
                end
            end
        end

        return modele
    end

    def initFrom(data)
        i = 0
        j = 0
        data.split(//).each do |x|
            case x
                when "0"
                    self.setTuile(j, i, Etat.lock_1())
                when "1"
                    self.setTuile(j, i, Etat.lock_2())
                when "2"
                    self.setTuile(j, i, Etat.etat_1())
                when "3"
                    self.setTuile(j, i, Etat.etat_2())
                else
                    self.setTuile(j, i, Etat.vide())
            end
            i += 1
            if i >= @taille
                i = 0
                j += 1
            end
        end

        self
    end

    # Applique un coup joué sur la grille
    #
    # === Arguments
    # *x* - La coordonnée x du coup.
    # *y* - La coordonnée y du coup.
    # *etat* - Le nouvel état de la grille.
    def appliquerCoup(x, y, etat)
        self.setTuile(x, y, etat)
    end

    # Créer une nouvelle grille en ce basant sur la grille donnée en paramètre.
    #
    # === Argument
    # *grille* - La grille à copier.
    def copier(grille)
        0.upto(self.taille() - 1) do |i|
            0.upto(self.taille() - 1) do |j|
                self.setTuile(i, j, grille.getTuile(i, j).etat)
            end
        end

        self
    end

    # Permet de dupliquer la grille
    #
    # === Argument
    # *grille* - La grille à dupliquer
    #
    # === Retourne
    # Une nouvelle grille basée sur la première
    def Grille.dupliquer(grille)
        nouvelleGrille = Grille.creer(grille.taille())
        0.upto(grille.taille() - 1) do |i|
            0.upto(grille.taille() - 1) do |j|
                nouvelleGrille.setTuile(i, j, grille.getTuile(i, j).etat)
            end
        end

        return nouvelleGrille;
    end

    def afficher()
        print "X\\Y│ "
        0.upto(self.taille() - 1) do |i|
            print i, " │ "
        end
        print "\n"
        0.upto(self.taille() - 1) do |i|
            print "───┼"*(self.taille()), "───┤\n"
            print " ", i, " │ "
            0.upto(self.taille() - 1) do |j|
                print "#{(@grille[i][j].etat==Etat.etat_1)?'O':((@grille[i][j].etat==Etat.etat_2)?'X':((@grille[i][j].etat==Etat.lock_1)?'Ⓞ':((@grille[i][j].etat==Etat.lock_2)?'Ⓧ':' ')))} │ "
            end
            print "\n"
        end
        print "───┴"*(self.taille()), "───┘\n"
    end
end
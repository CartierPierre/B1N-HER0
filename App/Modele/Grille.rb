class Grille
    @grille
    attr_reader :nbLigne, :nbColonne

    private_class_method :new
    #Méthode de création d'une grille
    #
    # === Arguments
    # *nbLigne* - Nombre de ligne que contient la grille
    # *nbColonne* - Nombre de colonne que contient la grille
    def Grille.creer(nbLigne, nbColonne)
        new(nbLigne, nbColonne)
    end

    def initialize(nbLigne, nbColonne)
        @nbLigne, @nbColonne = nbLigne, nbColonne

        #Création d'un tableau de tableau de tuile
        @grille =   Array.new(@nbLigne) 
                    {
                        Array.new(@nbColonne)
                        {
                            Tuile.creer()
                        }
                    }
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
        if(0 =< x && x < @nbLigne && 0 =< y && y < @nbColonne)
            return @grille[x][y]
        else
            return Tuile.creer()
        end
    end

    #Permet d'obtenir une ligne de la grille
    #
    # === Argument
    # *x* - La coordonnée de la ligne ciblée
    #
    # === Retour
    # La ligne ciblé si trouvée, sinon une nouvelle ligne
    def getLigne(x) #TODO Générer une execption
        if(0 =< x && x < @nbLigne)
            return @grille[x]
        else
            return  Array.new(@nbLigne)
                    {
                        Tuile.creer()
                    }
        end
    end

    #Permet d'obtenir une colonne de la grille
    #
    # === Argument
    # *y* - La coordonnée de la colonne ciblée
    #
    # === Retour
    # La colonne ciblé si trouvée, sinon une nouvelle colonne
    def getColonne(y) #TODO Générer une execption
        if(0 =< y && y < @nbColonne)
            newColonne = Array.new(@nbLigne)

            0.upto(@nbLigne -1) do |i|
                newColonne[i] = this.getTuile(i, y)
            end
        else
            newColonne = Array.new(@nbLigne) { Tuile.creer() }
        end

        return newColonne
    end
end
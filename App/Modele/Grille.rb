class Grille
    @grille
    attr_reader :nbLigne, :nbColonne

    private_class_method :new
    #Méthode de création d'une grille
    #
    # === Arguments
    # *nbLigne* - Nombre de ligne que contient la grille
    # *nbColonne* - Nombre de colonne que contient la grille
    def creer(nbLigne, nbColonne)
        @nbLigne, @nbColonne = nbLigne, nbColonne

        #Création d'un tableau de tableau de tuile
        @grille =   Array.new(@nbLigne) 
                    {
                        Array.new(@nbColonne)
                        {
                            Tuile.new()
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
    def getTuile(x, y)
        if(0 < x && x < @nbLigne && 0 < y && y < @nbColonne)
            return @grille[x][y]
        else
            return Tuile.new()
        end
    end
end
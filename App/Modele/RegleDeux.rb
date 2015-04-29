##
# La classe RegleDeux permet d'obtenir et utiliser une instance de la régle deux qui consiste en :
#   Règle n°2 : Chaque ligne et colonne possède autant de cases à l’état n°1 et à l’état n°2
#

class RegleDeux
    # L'instance de la RegleDeux.
    @@instance = nil

    private_class_method :new
    ##
    # Donne l'instance de la régle deux.
    #
    # Retour::
    #   Une instance de la régle deux.
    #
    def RegleDeux.instance()
        if(@@instance == nil)
            @@instance = new()
        end

        return @@instance
    end

    ##
    # Applique la régle deux sur la Partie.
    #
    # Paramétre::
    #   * _partie_ - La Partie sur laquelle on applique la régle.
    #
    # Retour::
    #   Renvoie nil si aucun problème n'est présent, sinon un Array contenant si le problème vient d'une ligne ou un colonne, le numéro de celle-ci et la régle qui a été appliquée.
    #
    def appliquer(partie)
        # Le nombre d'une cases d'une couleur ne doit pas dépasser la moitier du nombre de cases d'une ligne/colonne.
        nbCasesMax = partie.grille.taille() / 2

        # Parcours les lignes pour détecter si la régle deux est enfreinte sur l'une d'entre elles.
        0.upto(partie.grille.taille() - 1) do |x|
            tab = partie.compterCasesLigne(x)
            if( (tab[0]+tab[1] < partie.grille.taille()) && (tab[0] >= nbCasesMax || tab[1] >= nbCasesMax) )
                # Il y a plus de cases d'un état qu'il ne peut y avoir de l'autre, la régles deux est enfreinte.
                return Array[:regleLigne, x, :regles2]
            end
        end

        # Parcours les colonnes pour détecter si la régle deux est enfreinte sur l'une d'entre elles.
        0.upto(partie.grille.taille() - 1) do |y|
            tab = partie.compterCasesColonne(y)
            if( (tab[0]+tab[1] < partie.grille.taille()) && (tab[0] >= nbCasesMax || tab[1] >= nbCasesMax) )
                # Il y a plus de cases d'un état qu'il ne peut y avoir de l'autre, la régles deux est enfreinte.
                return Array[:regleColonne, y, :regles2]
            end
        end

        # Aucun problème rencontré, on renvoie nil.
        return nil
    end
end
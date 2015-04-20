##
# La classe RegleTrois permet d'obtenir et utiliser une instance de la régle trois qui consiste en :
#   Règle n°3 : Il ne peut y avoir deux lignes ou deux colonnes identiques
#


class RegleTrois

    @@instance = nil

    private_class_method :new
    ##
    # Donne l'instance de la régle trois.
    #
    # Retour::
    #   Une instance de la régle trois.
    #
    def RegleTrois.instance()
        if(@@instance == nil)
            @@instance = new()
        end

        return @@instance
    end

    ##
    # Applique la régle trois sur la Partie.
    #
    # Paramétre::
    #   * _partie_ - La Partie sur laquelle on applique la régle.
    #
    # Retour::
    #   Renvoie nil si aucun problème n'est présent, sinon un Array contenant si le problème vient d'une ligne ou un colonne, un tableau contenant les numéro de celles-ci et la régle qui a été appliquée.
    #
    def appliquer(partie)
        # Parcours les lignes pour détecter si la régle trois est enfreinte sur l'une d'entre elles.
        0.upto partie.grille.taille - 2 do |x|
            (x+1).upto partie.grille.taille - 1 do |z|
                if(ligneIdentique(partie.grille.getLigne(x), partie.grille.getLigne(z)))
                    # Les deux lignes sont identique (ou peuvent l'être avec les cases vides),
                    # on indique que la régle trois est ou sera enfreinte.
                    return Array[:regleLigne, Array[x, z], :regles3]
                end
            end
        end

        # Parcours les colonnes pour détecter si la régle trois est enfreinte sur l'une d'entre elles.
        0.upto partie.grille().taille() - 2 do |y|
            (y+1).upto partie.grille().taille() - 1 do |z|
                if(ligneIdentique(partie.grille.getColonne(y), partie.grille.getColonne(z)))
                    # Les deux colonnes sont identique (ou peuvent l'être avec les cases vides),
                    # on indique que la régle trois est ou sera enfreinte.
                    return Array[:regleColonne, Array[y, z], :regles3]
                end
            end
        end

        # Aucun problème rencontré, on renvoie nil.
        return nil
    end

    ##
    # Vérifie que deux lignes ne soit pas identique.
    #
    # Paramétre::
    #   * _ligne1_ - Une ligne a vérifier.
    #   * _ligne2_ - L'autre ligne a vérifier.
    #
    # Retour::
    #   Un bouléen qui indique si les lignes sont identique.
    #
    def ligneIdentique(ligne1, ligne2)
        0.upto(ligne1.size - 1) do |i|
            if(!Etat.egale?(ligne1[i].etat, ligne2[i].etat))
                return false
            end
        end

        return true
    end
end
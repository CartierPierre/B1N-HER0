##
# La classe RegleUn permet d'obtenir et utiliser une instance de la régle une qui consiste en :
#   Règle n°1 : Il ne peut y avoir plus de deux cases possédant le même état à la suite.
#

class RegleUn
    @@instance = nil

    private_class_method :new
    ##
    # Donne l'instance de la régle une.
    #
    # Retour::
    #   Une instance de la régle une.
    #
    def RegleUn.instance()
        if(@@instance == nil)
            @@instance = new()
        end

        return @@instance
    end

    ##
    # Applique la régle une sur la Partie.
    #
    # Paramétre::
    #   * _partie_ - La Partie sur laquelle on applique la régle.
    #
    # Retour::
    #   Renvoie nil si aucun problème n'est présent, sinon un Array contenant si le problème vient d'une ligne ou un colonne, le numéro de celle-ci et la régle qui a été appliquée.
    #
    def appliquer(partie)
        # Parcours les lignes pour détecter si la régle une est enfreinte sur l'une d'entre elles.
        0.upto(partie.grille().taille() - 1) do |x|
            1.upto(partie.grille().taille() - 2)do |y|
                if(# On ne souhaite pas contrôler les cases vide (on peut avoir 3 cases vides de suite).
                    partie.grille().getTuile(x, y-1).etat() != Etat.vide &&
                    partie.grille().getTuile(x,  y ).etat() != Etat.vide &&
                    partie.grille().getTuile(x, y+1).etat() != Etat.vide
                ) then
                    if(# On vérifie que les cases avant et après n'est pas la même valeur que la notre.
                        Etat.egale?(partie.grille().getTuile(x,y-1).etat(), partie.grille().getTuile(x,y).etat()) &&
                        Etat.egale?(partie.grille().getTuile(x,y+1).etat(), partie.grille().getTuile(x,y).etat())
                    ) then
                        #On indique le problème une fois qu'on le rencontre.
                        return Array.new(:regleLigne, x, :regles1)
                    end
                end
            end
        end

        # Parcours les colonnes pour détecter si la régle une est enfreinte sur l'une d'entre elles.
        0.upto(partie.grille().taille() - 1) do |y|
            1.upto(partie.grille().taille() - 2) do |x|
                if(# On ne souhaite pas contrôler les cases vide (on peut avoir 3 cases vides de suite).
                    partie.grille().getTuile(x-1,y).etat() != Etat.vide &&
                    partie.grille().getTuile( x ,y).etat() != Etat.vide &&
                    partie.grille().getTuile(x+1,y).etat() != Etat.vide
                ) then
                    if(# On vérifie que les cases avant et après n'est pas la même valeur que la notre.
                        Etat.egale?(partie.grille().getTuile(x-1,y).etat(), partie.grille().getTuile(x,y).etat()) &&
                        Etat.egale?(partie.grille().getTuile(x+1,y).etat(), partie.grille().getTuile(x,y).etat())
                    ) then
                        #On indique le problème une fois qu'on le rencontre.
                        return Array.new(:regleColonne, x, :regles1)
                    end
                end
            end
        end

        # Aucun problème rencontré, on renvoie nil.
        return nil
    end
end

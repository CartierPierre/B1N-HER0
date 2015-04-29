##
# La classe Coup permet de créer et utiliser des coups.
#

class Coup
    # Un entier représentant la coordonnée _x_ du Coup.
    attr_reader :x
    # Un entier représentant la coordonnée _y_ du Coup.
    attr_reader :y
    # Etat de la Tuile avant le Coup.
    attr_accessor :etat

    ##
    # Méthode de création d'un Coup.
    #
    # Paramétres::
    #   * _x_ - La coordonnée x du Coup.
    #   * _y_ - La coordonnée y du Coup.
    #   * _etat_ - L'état de la Tuile avant le Coup.
    private_class_method :new
    def Coup.creer(x, y, etat)
        new(x, y, etat)
    end

    def initialize(x, y, etat) #:notnew:
        @x, @y, @etat = x, y, etat
    end




    #############################
    #                           #
    # =>    SÉRIALISATION    <= #
    #                           #
    #############################

    ##
    # (Sérialisation)
    # Sauvegarde un Coup en chaine de caractères.
    #
    # Retour::
    #   Un chaine de caractéres représentant un coup avec les champs (respectivement: coordonnée x, coordonnée y et état précédent) séparés par des ','.
    #    self.sauvegarder #=> "5,1,_"
    def sauvegarder()
        return "#{x},#{y},#{Etat.etatToString(etat)}"
    end

    ##
    # (Désérialisation)
    # Charge un Coup à partir des données.
    #
    # Paramétre::
    #   * _donnee_ - Une chaine de caractéres qui représente un Coup. Aller voir Coup.sauvegarder.
    #
    # Retour::
    #   Un nouveau coup initialisé avec les données.
    #
    def Coup.charger(donnee)
        donnees = donnee.split(',')
        return Coup.creer(donnees[0], donnees[1], Etat.stringToEtat(donnees[2]))
    end

    def to_s
        return "\tCoup x = #{@x} y = #{@y} etat = #{@etat}"
    end
end

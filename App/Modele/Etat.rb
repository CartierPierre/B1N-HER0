##
# La classe Etat permet d'utiliser les états.

class Etat
    @@VIDE = 0   # Etat d'une case vide
    @@ETAT_1 = 1 # Etat 1 d'une case pleine
    @@ETAT_2 = 2 # Etat 2 d'une case pleine
    @@LOCK_1 = 3 # Etat 1 d'une case bloquée
    @@LOCK_2 = 4 # Etat 2 d'une case bloquée

    ##
    # Donne la valeur d'état vide.
    #
    # Retour::
    #   Un entier correspondant à la valuer de l'état.
    #
    def Etat.vide
        return @@VIDE
    end

    ##
    # Donne la valeur d'état pleine 1.
    #
    # Retour::
    #   Un entier correspondant à la valuer de l'état.
    #
    def Etat.etat_1
        return @@ETAT_1
    end

    ##
    # Donne la valeur d'état pleine 2.
    #
    # Retour::
    #   Un entier correspondant à la valuer de l'état.
    #
    def Etat.etat_2
        return @@ETAT_2
    end

    ##
    # Donne la valeur d'état bloquée 1.
    #
    # Retour::
    #   Un entier correspondant à la valuer de l'état.
    #
    def Etat.lock_1
        return @@LOCK_1
    end

    ##
    # Donne la valeur d'état bloquée 2.
    #
    # Retour::
    #   Un entier correspondant à la valuer de l'état.
    #
    def Etat.lock_2
        return @@LOCK_2
    end

    ##
    # Donne la valeur de l'état qui suit l'état donné.
    #
    # Paramétre::
    #   * _etat_ - L'état de base.
    #
    # Retour::
    #   Un entier correspondant à l'état qui suit l'état donné.
    #
    def Etat.suivant(etat)
        case etat
            when @@VIDE
                return @@ETAT_1
            when @@ETAT_1
                return @@ETAT_2
            when @@ETAT_2
                return @@VIDE
            else
                return nil
        end
    end

    ##
    # Vérifie si deux états sont égaux.
    #
    # Paramétre::
    #   * _etat1_ - L'état à vérifier.
    #   * _etat2_ - L'état à vérifier.
    #
    # Retour::
    #   Un bouléen indiquand si les deux états sont égaux.
    #
    def Etat.egale?(etat1, etat2)
        if etat1 == etat2 
            return true
        elsif (etat1 == @@ETAT_1 && etat2 == @@LOCK_1) || (etat2 == @@ETAT_1 && etat1 == @@LOCK_1) # ETAT_1 == LOCK_1
            return true
        elsif (etat1 == @@ETAT_2 && etat2 == @@LOCK_2) || (etat2 == @@ETAT_2 && etat1 == @@LOCK_2) # ETAT_2 == LOCK_2
            return true
        end

        return false
    end

    ##
    # Convertie un caractère en Etat.
    #
    # Paramétre::
    #   * _s_ - Le caractére à vérifier.
    #
    # Retour::
    #   Un entier correspondant à la valeur de l'état du caractére donné.
    #
    def Etat.stringToEtat(s)
        case s
            when "0"
                return Etat.lock_1()
            when "1"
                return Etat.lock_2()
            when "2"
                return Etat.etat_1()
            when "3"
                return Etat.etat_2()
            else
                return Etat.vide()
        end
    end

    ##
    # Convertie un Etat donné en caractére.
    #
    # Paramétre::
    #   * _e_ - L'état à convertir.
    #
    # Retour::
    #   Un caractére correspondant à l'état.
    def Etat.etatToString(e)
        case e
            when Etat.vide
                return "_"
            when Etat.lock_1
                return "0"
            when Etat.lock_2
                return "1"
            when Etat.etat_1
                return "2"
            when Etat.etat_2
                return "3"
            else
                return "_"
        end
    end
end
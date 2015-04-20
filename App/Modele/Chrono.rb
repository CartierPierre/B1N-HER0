##
# La classe Chrono permet de créer et utiliser un Chrono.
#

class Chrono
    attr_reader :estActif, :debut, :pause, :fin

    private_class_method :new
    ##
    # Méthode de création d'un chrono.
    def Chrono.creer()
        new()
    end

    def initialize()
        @debut=Time.now
        @estActif = false
    end

    ##
    # Démarre le chrono.
    #
    def start()
        @debut=Time.now
        @estActif = true

        self
    end

    ##
    # Arrête le chrono.
    #
    # Retour::
    #   Le temps de fin.
    #
    def stop()
        @fin=Time.now-@debut
        @estActif = false

        return @fin
    end

    # Inutile comme méthode, on déjà accés au temps de fin
    # def to_i()
    #     return @fin.to_i
    # end

    ##
    # Donne le chrono sous forme de chaine de caractères.
    #
    # Retour::
    #   Une chaine de caractéres représentant le chrono.
    #
    def to_s()
        temps = Time.now()-@debut
        minutes = sprintf('%02i', ((temps.to_i % 3600) / 60))
        secondes = sprintf('%02i', (temps.to_i % 60))

        return "#{minutes}:#{secondes}"
    end

    ##
    # Met le chrono en pause.
    #
    def pause() #a utiliser seulement pour les sauvegardes ou regles, penser a masquer la grille
        @pause=Time.now
        @estActif = false

        self
    end

    ##
    # Remet le chrono en marche
    #
    def finPause()
        @debut+=(Time.now-@pause)
        @estActif = true

        self
    end




    #############################
    #                           #
    # =>    SÉRIALISATION    <= #
    #                           #
    #############################

    ##
    # (Sérialisation)
    # Sauvegarde un Chrono en chaine de caractéres.
    #
    # Retour::
    #   Une chaine de caractére représentant le Chrono, chaque champs séparer par un ';' (respectivement estActif, debut, pause, fin).
    #    self.sauvegarder #=> "true;50:37:17:20:4:2015:1:110:true:CEST;;"
    #
    def sauvegarder()
        donnee = String.new()

        # Sauvegarde le bouléen qui indique si le chrono est actif.
        donnee += "#{estActif.to_s};"

        # Sauvegarde du temps de début.
        @debut.to_a().each do |x|
            donnee += "#{x.to_s}"
            if x != @debut.to_a().last()
                donnee += ":"
            end
        end

        donnee += ";"

        # Sauvegarde du temps de pause.
        if(@pause)
            @pause.to_a().each do |x|
                donnee += "#{x.to_s}"
                if x != @pause.to_a().last()
                    donnee += ":"
                end
            end
        end

        donnee += ";"

        # Sauvegarde du temps de fin.
        if(@fin)
            @fin.to_a().each do |x|
                donnee += "#{x.to_s}"
                if x != @fin.to_a().last()
                    donnee += ":"
                end
            end
        end

        return donnee
    end

    ##
    # (Désérialisation)
    # Charge un Chrono à partir des données.
    #
    # Paramétre::
    #   * _donnee_ - Une chaine de caractéres qui représente un Chrono. Aller voir Chrono.sauvegarder.
    #
    # Retour::
    #   Un nouveau Chrono initialisé avec les données.
    #
    def Chrono.charger(donnee)
        chrono = Chrono.creer()

        donnees = donnee.split(';')

        # On remet le bouléen indiquant si le chrono est actif.
        chrono.estActif = (donnees[0] == 'true')?true:false

        # On remet le temps de début.
        t = donnees[1].split(':')
        debut = Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6])
                        # seconde :  minute  :   heure  :   jour   :   mois   :annee     :   wday   :   yday   :              isdst          : zone
        # On remet le temps de pause.
        if donnees.size >= 4
            t = donnees[2].split(':')
            chrono.pause = Time.now + (Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6]) - debut)
        end

        # On remet le temps de fin.
        if donnees.size >= 3
            t = donnees[3].split(':')
            chrono.fin = Time.now + (Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6]) - debut)
        end

        return chrono
    end
end
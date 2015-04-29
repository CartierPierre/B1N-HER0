##
# La classe Chrono permet de créer et utiliser un Chrono.
#

class Chrono
    # Un booléen indiquant si le Chrono est actif.
    attr_accessor :estActif
    # Un Time marquant le temps de début du Chrono.
    attr_accessor :tempsDebut
    # Un Time marquant le temps de pause du Chrono.
    attr_accessor :tempsPause
    # Un entier indiquant le temps écoulé entre le temps de début et la fin du Chrono.
    attr_accessor :tempsFin

    private_class_method :new
    ##
    # Méthode de création d'un chrono.
    def Chrono.creer()
        new()
    end

    def initialize() #:notnew:
        @tempsDebut=Time.now
        @estActif = false
    end

    ##
    # Démarre le chrono.
    #
    def start()
        @tempsDebut=Time.now
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
        @tempsFin=Time.now-@tempsDebut
        @estActif = false

        return @tempsFin
    end

    ##
    # Donne le chrono sous forme de chaine de caractères.
    #
    # Retour::
    #   Une chaine de caractéres représentant le chrono.
    #
    def to_s()
        temps = Time.now()-@tempsDebut
        minutes = sprintf('%02i', ((temps.to_i % 3600) / 60))
        secondes = sprintf('%02i', (temps.to_i % 60))

        return "#{minutes}:#{secondes}"
    end

    ##
    # Met le chrono en pause.
    #
    def pause() #a utiliser seulement pour les sauvegardes ou regles, penser a masquer la grille
        if(@estActif)
            @tempsPause=Time.now
            @estActif = false
        end

        self
    end

    ##
    # Remet le chrono en marche
    #
    def finPause()
        if(!@estActif)
            @tempsDebut+=(Time.now-@tempsPause)
            @estActif = true
        end

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
    #   Une chaine de caractére représentant le Chrono, chaque champs séparer par un ';' (respectivement estActif, tempsDebut, tempsPause, tempsFin).
    #    self.sauvegarder #=> "true;50:37:17:20:4:2015:1:110:true:CEST;;"
    #
    def sauvegarder()
        # On s'assure que le chrono est en pause pour la sauvegarde
        wasActif = @estActif
        self.pause()

        donnee = String.new()

        # Sauvegarde le booléen qui indique si le chrono est actif.
        donnee += "#{estActif.to_s};"

        # Sauvegarde du temps de début.
        @tempsDebut.to_a().each do |x|
            donnee += "#{x.to_s}"
            if x != @tempsDebut.to_a().last()
                donnee += ":"
            end
        end

        donnee += ";"

        # Sauvegarde du temps de pause.
        if(@tempsPause)
            @tempsPause.to_a().each do |x|
                donnee += "#{x.to_s}"
                if x != @tempsPause.to_a().last()
                    donnee += ":"
                end
            end
        end

        donnee += ";"

        # Sauvegarde du temps de fin.
        if(@tempsFin)
            @tempsFin.to_a().each do |x|
                donnee += "#{x.to_s}"
                if x != @tempsFin.to_a().last()
                    donnee += ":"
                end
            end
        end

        # On remet en route le chrono s'il l'était avant la sauvegarde.
        if(wasActif)
            self.finPause()
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

        # On remet le booléen indiquant si le chrono est actif.
        chrono.estActif = (donnees[0] == 'true')?true:false

        # On remet le temps de début.
        t = donnees[1].split(':')
                    #Time.gm(  seconde ,  minute  ,   heure  ,   jour   ,   mois   ,   annee  ,   wday   ,   yday   ,              isdst          , zone
        tempsDebut = Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6])

        # On remet le temps de pause.
        if donnees.size >= 3
            t = donnees[2].split(':')
            chrono.tempsPause = Time.now + (Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6]) - tempsDebut)
        end

        chrono.tempsDebut = chrono.tempsPause - (Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6]) - tempsDebut)

        # On remet le temps de fin.
        if donnees.size >= 4
            t = donnees[3].split(':')
            chrono.tempsFin = Time.now + (Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6]) - tempsDebut)
        end

        return chrono
    end
end
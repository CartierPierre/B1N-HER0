class Chrono
    @debut
    @pause
    @fin
    @estActif

    attr_accessor :estActif, :debut, :pause, :fin

    private_class_method :new
    def Chrono.creer()
        new()
    end

    def initialize()
        @debut=Time.now
        @fin=Time.now
        @pause=Time.now
        @estActif = false
    end
    
    def start()
        @debut=Time.now
        @estActif = true
    end
    
    def stop()
        @fin=Time.now-@debut
        @estActif = false
        return @fin
    end

    def to_s()
        temps = Time.now()-@debut
        minutes = sprintf('%02i', ((temps.to_i % 3600) / 60))
        secondes = sprintf('%02i', (temps.to_i % 60))   
        return "#{minutes}:#{secondes}"
    end
    
    def pause() #a utiliser seulement pour les sauvegardes ou regles, penser a masquer la grille
        @pause=Time.now
        @estActif = false
    end
    
    def finPause()
        @debut+=(Time.now-@pause)
        @estActif = true
    end

    def sauvegarder()
        n = String.new()

        n += "#{estActif.to_s};"

        @debut.to_a().each do |x|
            n += "#{x.to_s}"
            if x != @debut.to_a().last()
                n += ":"
            end
        end

        n += ";"

        if(@pause)
            @pause.to_a().each do |x|
                n += "#{x.to_s}"
                if x != @debut.to_a().last()
                    n += ":"
                end
            end
        end

        n += ";"

        if(@fin)
            @fin.to_a().each do |x|
                n += "#{x.to_s}"
                if x != @debut.to_a().last()
                    n += ":"
                end
            end
        end

        return n
    end

    def Chrono.charger(data)
        chrono = Chrono.creer()

        tab = data.split(';')

        chrono.estActif = (tab[0] == 'true')?true:false

        t = tab[1].split(':')
        debut = Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6])
                        # seconde :  minute  :   heure  :   jour   :   mois   :annee     :   wday   :   yday   :              isdst          : zone
        if tab.size >= 4
            t = tab[2].split(':')
            chrono.fin = Time.now + (Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6]) - debut)
        end

        if tab.size >= 3
            t = tab[3].split(':')
            chrono.pause = Time.now + (Time.gm( t[0].to_i, t[1].to_i, t[2].to_i, t[3].to_i, t[4].to_i, t[5].to_i, t[6].to_i, t[7].to_i,((t[5] == 'true')?true:false), t[6]) - debut)
        end

        return chrono
    end
end
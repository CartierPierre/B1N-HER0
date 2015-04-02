class Chrono
    @debut
    @fin
       
    def initialize()
        @debut=Time.now
    end
    
    def start()
        @debut=Time.now
    end
    
    def stop()
        @fin=Time.now-@debut
        return @fin
    end

    def to_s()
        temps = Time.now()-@debut
        minutes = sprintf('%02i', ((temps.to_i % 3600) / 60))
        secondes = sprintf('%02i', (temps.to_i % 60))   
        return "#{minutes}:#{secondes}"
    end

end
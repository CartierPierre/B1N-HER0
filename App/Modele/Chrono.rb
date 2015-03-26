class Chrono
    @debut
    @fin
    
    private_class_method :new
    
    def Chrono.nouveau()
        new()
    end
    
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
    
    
    # http://www.tutorialspoint.com/ruby/ruby_multithreading.htm
end
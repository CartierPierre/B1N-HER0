class Score
    @id #id_score
    @uuid #uuid_score
    @utilisateur
    @tempsTotal
    @nbCoups
    @nbAides
    @nbConseils
    
    attr_reader :id, :uuid, :utilisateur, :tempsTotal, :nbCoups, :nbAides, :nbConseils
    
    
    
    
    
    def Score.creer(user)
        new(user)
    end
    
    def initialize(user)
        @id=nil
        @uuid=nil
        @utilisateur=user
        @tempsTotal=0
        @nbCoups=0
        @nbAides=0
        @nbConseils=0
    end
    
    def incNbCoups()
        @nbCoups+=1
    end
    
    def incNbAides()
        @nbCoups+=1
    end
    
    def incNbConseils()
        @nbCoups+=1
    end
    
    def scoreFinal(tailleGrille, diffGrille)
        return ((tailleGrille**diffGrille)/(1+tempsTotal+(2**nbConseils)*10+(2**nbAides)*30+(nbCoups/10)**2))
    end
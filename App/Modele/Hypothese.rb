class Hypothese < Partie
    def Hypothese.creer(utilisateur, niveau)
        new(utilisateur, niveau)
    end
    
    def initialize(utilisateur, niveau)
        super(utilisateur, niveau)
        modeHypo=1
    end
end
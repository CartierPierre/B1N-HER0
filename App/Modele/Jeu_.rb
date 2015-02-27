class Jeu
    @grille

    private_class_method :new
    #Méthode de création d'un Jeu
    def creer()
        @grille = Grille.new(6, 6)
    end

    def to_s()
        puts "Voici le takuzu de #{@nbL}*#{@nbC}: "
        0.upto(@nbL - 1) do |i|
            0.upto(@nbC - 1) do |j|
                if @mat[i][j] == 1
                    print "1"
                elsif @mat[i][j] == 2
                    print "2"
                else
                    print "0"
                end
            end
            print "\n"
        end
        print "\n"
    end
end
##
# Classe Sauvegarde
#
# Version 2
#
class Sauvegarde

	### Attributs d'instances
	
    attr_reader :id, :uuid, :utilisateur, :titre, :dateCreation, :partie
	
	### Méthodes de classe
	
	##
	# Instancie une sauvegarde
	#
    def Sauvegarde.creer(*args)
		case args.size
			when 0
				new(nil, nil, nil, nil, Time.now.to_i, nil)
			when 6
				new(args[0], args[1], args[2], args[3], args[4], args[5])
			else
				puts "Sauvegarde.creer n'accepte que O ou 6 arguments"
        end
    end

	### Méthodes d'instances
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(id, uuid, utilisateur, titre, dateCreation, partie)
        @id = id
		@uuid = uuid
		@utilisateur = utilisateur
		@titre = titre
		@dateCreation = dateCreation
		@partie = id
    end
end
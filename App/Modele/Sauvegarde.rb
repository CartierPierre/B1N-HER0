##
# Classe Sauvegarde
#
# Version 3
#
class Sauvegarde

	### Attributs d'instances
	
    attr_reader :id, :uuid, :description, :dateCreation, :contenu, :utilisateur, :niveau, :partie
	# Contenu, Utilisateur et Niveau ne devrait pas être accessibles, ils sont déduits de partie et utilisées seulement pour la persistance des données
	
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
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(id, uuid, utilisateur, description, dateCreation, partie)
	
		# int
		# Identifiant locale de la sauvegarde
        @id = id
		
		# uuid
		# Identifiant universel unique de la sauvegarde
		@uuid = uuid
		
		# string
		# Description de la sauvegarde
		@description = description
		
		# ???
		# Date de création de cette sauvegarde
		@dateCreation = dateCreation
		
		# string
		# Informations sérialisées de la sauvegarde
		@contenu = contenu
		
		# Utilisateur
		# Utilisateur a qui appartient la sauvegarde
		@utilisateur = utilisateur
		
		# Niveau
		# Niveau sur lequel porte cette sauvegarde
		@niveau = niveau
		
		# Partie
		# Référence vers l'object partie déduits des informations de l'object sauvegarde
		@partie = nil
		
    end
end
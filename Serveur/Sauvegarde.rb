##
# Classe Sauvegarde
#
# Version 2
#
class Sauvegarde

	### Attributs d'instances
	
	# int
	# Identifiant locale de la sauvegarde
	@id
	
	# int
	# Version de l'entitée
	@version

	# string
	# Description de la sauvegarde
	@description

	# int
	# Date de création de cette sauvegarde
	@dateCreation

	# string
	# Informations sérialisées de la partie
	@contenu

	# int
	# Identifiant de l'utilisateur a qui appartient la sauvegarde
	@idUtilisateur

	# int
	# Identifiant du niveau sur lequel porte cette sauvegarde
	@idNiveau

    attr_accessor :id, :version, :description, :dateCreation, :contenu, :idUtilisateur, :idNiveau
	
	### Méthodes de classe
	
	##
	# Instancie une sauvegarde
	#
    def Sauvegarde.creer( *args )
		case args.size
			when 6
				new( nil, args[0], args[1], args[2], args[3], args[4], args[5] )
			when 7
				new( args[0], args[1], args[2], args[3], args[4], args[5], args[6] )
			else
				puts "Sauvegarde.creer n'accepte que 6 ou 7 arguments"
        end
    end
	
	##
	# Constructeur
	#
    def initialize( id, version, description, dateCreation, contenu, idUtilisateur, idNiveau )
		@id = id
		@version = version
		@description = description
		@dateCreation = dateCreation
		@contenu = contenu
		@idUtilisateur = idUtilisateur
		@idNiveau = idNiveau
    end
	private_class_method :new
	
end

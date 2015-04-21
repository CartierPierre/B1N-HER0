##
# Classe Sauvegarde
#
# Version 6
#
class Sauvegarde

	### Attributs d'instances
	
    attr_accessor :id, :uuid, :description, :dateCreation, :contenu, :idUtilisateur, :idNiveau
	
	### Méthodes de classe
	
	##
	# Instancie une sauvegarde
	#
    def Sauvegarde.creer(*args)
		case args.size
			# args[0] (string) description
			# args[1] (Partie) partie
			when 2
				new( nil, nil, args[0], Time.now.to_i, args[1].sauvegarder(), args[1].utilisateur.id, args[1].niveau.id ) # Pour les développeurs
			when 7
				new( args[0], args[1], args[2], args[3], args[4], args[5], args[6] ) # Pour la classe GestionnaireSauvegarde
			else
				puts "Sauvegarde.creer n'accepte que 2 ou 7 arguments"
        end
    end
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize( id, uuid, description, dateCreation, contenu, idUtilisateur, idNiveau )
	
		# int
		# Identifiant locale de la sauvegarde
        @id = id
		
		# int
		# Identifiant universel unique de la sauvegarde
		@uuid = uuid
		
		# string
		# Description de la sauvegarde
		@description = description
		
		# int
		# Date de création de cette sauvegarde
		@dateCreation = dateCreation
		
		# string
		# Informations sérialisées de la partie
		@contenu = contenu
		
		# int
		# Identifiant de l'utilisateur a qui appartient la sauvegarde
		@idUtilisateur = idUtilisateur
		
		# int
		# Identifiant du niveau sur lequel porte cette sauvegarde
		@idNiveau = idNiveau
		
    end
end
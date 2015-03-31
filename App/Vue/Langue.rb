class Langue

	@langueFr
	@langueEn
	@langueActuelle

	attr_reader :langueActuelle

	def initialize() 

        @langueFr = {
            sauvegarder: "Sauvegarder",
            charger: "Charger",
            options: "Options",
            regles: "Règles du jeu",
            quitter: "Quitter",
            hypothese: "Hypothèse",
            valider: "Valider",
            annuler: "Annuler",
            repeter: "Répéter",
            conseil: "Conseil",
            recommencer: "Recommencer",
            pseudo: "Pseudo",
            motDePasse: "Mot de passe",
            inscription: "Inscription",
            connexion: "Connexion",
            oui: "Oui",
            non: "Non",
            langue: "Langue",
            francais: "Français",
            anglais: "Anglais",
            retour: "Retour"
        }

        @langueEn = {
            sauvegarder: "Save",
            charger: "Load",
            options: "Settings",
            regles: "Rules",
            quitter: "Exit",
            hypothese: "Hypothesis",
            valider: "Confirm",
            annuler: "Undo",
            repeter: "Redo",
            conseil: "Advice",
            recommencer: "Restart",
            pseudo: "Pseudo",
            motDePasse: "Password",
            inscription: "Sign up",
            connexion: "Login",
            oui: "Yes",
            non: "No",
            langue: "Language",
            francais: "French",
            anglais: "English",
            retour: "Back"
        }
        @langueActuelle = @langueFr
	end

	def setLangueFr()
		@langueActuelle = @langueFr
	end

	def setLangueEn()
		@langueActuelle = @langueEn
	end

end
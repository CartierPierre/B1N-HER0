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
            retour: "Retour",
            regles1: "Règle n°1 : Il ne peut y avoir plus de deux cases possédant le même état à la suite.\n\n",
            regles2: "Règle n°2 : Chaque ligne et colonne possède autant de cases à l’état n°1 et à l’état n°2.\n\n",
            regles3: "Règle n°3 : Il ne peut y avoir deux lignes ou deux colonnes identiques.",
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
            retour: "Back",
            regles1: "Rule n°1 : Three adjacent tiles of the same color in a row or column isn't allowed.\n\n",
            regles2: "Rule n°2 : Rows and columns have an equal number of each color.\n\n",
            regles3: "Rule n°3 : No two rows and no two columns are the same."
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
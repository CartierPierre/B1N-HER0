# Heu ... ba quand je sérialise les option pour un utilisateur, je me dis cela va
# juste stocker 2 ou 3 variable et en fait je me retrouve avec un ***** de dico
# anglais/francais !!!
#
# Je pense qu'il serai préférable d'utiliser des constantes de classe ou je sais pas quoi ^^
#

class Langue

      EN = 0
      FR = 1

	@langueFr
	@langueEn
	@langueActuelle

	attr_reader :langueActuelle

	def initialize(langue) 

        @langueFr = {
            sauvegarder: "Sauvegarder",
            charger: "Charger",
            options: "Options",
            regles: "Règles du jeu",
            quitter: "Quitter",
            hypothese: "Hypothèse",
            hypotheseActive: " Hypothèse\n activé",
            valider: "Valider",
            appliquer: "Appliquer",
            annuler: "Annuler",
            annulerAction: "Annuler",
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
            couleurTuiles: "Couleur des tuiles",
            tailleGrille: "Taille de la grille",
            difficulte: "Difficulté",
            menuPrincipal: "Menu principal",
            jouer: "Jouer",
            nouvellePartie: "Nouvelle partie",
            chargerPartie: "Charger partie",
            classement: "Classement",
            profil: "Profil",
            modeDeJeuEnLigne: "Mode de jeu en ligne",
            modeDeJeuHorsLigne: "Mode de jeu hors ligne"
        }

        @langueEn = {
            sauvegarder: "Save",
            charger: "Load",
            options: "Settings",
            regles: "Rules",
            quitter: "Quit",
            hypothese: "Hypothesis",
            hypotheseActive: " Hypothesis\n enabled",
            valider: "Confirm",
            appliquer: "Apply",
            annuler: "Cancel",
            annulerAction: "Undo",
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
            regles3: "Rule n°3 : No two rows and no two columns are the same.",
            couleurTuiles: "Color tiles",
            tailleGrille: "Grid size",
            difficulte: "Difficulty",
            menuPrincipal: "Main menu",
            jouer: "Play",
            nouvellePartie: "New game",
            chargerPartie: "Load game",
            classement: "Ranking",
            profil: "Profile",
            modeDeJeuEnLigne: "Online play mode",
            modeDeJeuHorsLigne: "Offline play mode"
        }
            if(langue == FR)
                  @langueActuelle = @langueFr
            else
                  @langueActuelle = @langueEn
            end
	end

	def setLangueFr()
		@langueActuelle = @langueFr
	end

	def setLangueEn()
		@langueActuelle = @langueEn
	end

end
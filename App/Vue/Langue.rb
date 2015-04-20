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
    @langueConstante

    attr_reader :langueActuelle, :langueConstante

    def initialize(langue) 

        @langueFr = {
            sauvegarder: "Sauvegarder",
            confirmationSauvegarde: "Voulez vous vraiment sauvegarder cette partie ?",
            charger: "Charger",
            options: "Options",
            regles: "Règles du jeu",
            quitter: "Quitter",
            hypothese: "Hypothèse",
            hypotheseActive: " Hypothèse\n activé",
            niveau: "Niveau",
            validerGrille: "Valider la grille",
            valider: "Valider",
            appliquer: "Appliquer",
            annuler: "Annuler",
            annulerAction: "Annuler",
            repeter: "Répéter",
            conseil: "Conseil",
            appliquerRegle: "Appliquer la ",
            regleLigne: " sur la ligne ",
            regleColonne: " sur la colonne ",
            et: " et ",
            aide: "Aide",
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
            regles1: "Règle n°1 : Il ne peut y avoir plus de deux cases possédant le même état à la suite\n\n",
            regles2: "Règle n°2 : Chaque ligne et colonne possède autant de cases à l’état n°1 et à l’état n°2\n\n",
            regles3: "Règle n°3 : Il ne peut y avoir deux lignes ou deux colonnes identiques",
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
            modeDeJeuHorsLigne: "Mode de jeu hors ligne",
            resultatPartie: "Résultat de la partie",
            retournerMenuPrincipal: "Retourner au menu principal",
            felicitations: "Félicitations, vous avez réussi à résoudre une grille ",
            felicitations2: " en difficulté ",
            temps: "Temps",
            score: "Score",
            nbCoups: "Nombre de coups effectués",
            nbConseils: "Nombre de conseils utilisés",
            nbAides: "Nombre d'aides utilisées",
            grilleInvalide: "Grille invalide",
            grilleInvalideExplications: "La grille est invalide, vérifiez bien que toutes les règles sont respectées.",
            credits: "Crédits",
            chefProjet: "Chef de projet",
            documentaliste: "Documentaliste",
            interfaceGraphique: "Interface graphique",
            baseDonnees: "Base de données",
            codage: "Codage du jeu",
            rang: "Rang",
            demarrage: "Demarrage"
        }

        @langueEn = {
            sauvegarder: "Save",
            confirmationSauvegarde: "Do you really want to save this game ?",
            charger: "Load",
            options: "Settings",
            regles: "Rules",
            quitter: "Quit",
            hypothese: "Hypothesis",
            hypotheseActive: " Hypothesis\n enabled",
            niveau: "Level",
            validerGrille: "Check the grid",
            valider: "Confirm",
            appliquer: "Apply",
            annuler: "Cancel",
            annulerAction: "Undo",
            repeter: "Redo",
            conseil: "Advice",
            appliquerRegle: "Apply the ",
            regleLigne: " on the row ",
            regleColonne: " on the column ",
            et: " and ",
            aide: "Help",
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
            regles1: "Rule n°1 : Three adjacent tiles of the same color in a row or column isn't allowed\n\n",
            regles2: "Rule n°2 : Rows and columns have an equal number of each color\n\n",
            regles3: "Rule n°3 : No two rows and no two columns are the same",
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
            modeDeJeuHorsLigne: "Offline play mode",
            resultatPartie: "Result of the game",
            felicitations: "Congratulations, you managed to solve a grid ",
            felicitations2: " in difficulty ",
            temps: "Time",
            retournerMenuPrincipal: "Back to the main menu",
            score: "Score",
            nbCoups: "Number of moves made",
            nbConseils: "Number of advices used",
            nbAides: "Number of helps used",
            grilleInvalide: "Invalid grid",
            grilleInvalideExplications: "The grid is invalid, make sure that all the rules are followed.",
            credits: "Credits",
            chefProjet: "Project manager",
            documentaliste: "Archivist",
            interfaceGraphique: "Graphical User Interface",
            baseDonnees: "Database",
            codage: "Coding",
            rang: "Rank",
            demarrage: "Launch"
        }
        if(langue == FR)
            @langueActuelle = @langueFr
        else
            @langueActuelle = @langueEn
        end
        @langueConstante = langue
    end

    def getLangueConstante()
        return @langueConstante
    end

    def setLangue(langue)
        if(langue == FR)
            @langueActuelle = @langueFr
        else
            @langueActuelle = @langueEn
        end  
        @langueConstante = langue
    end

end
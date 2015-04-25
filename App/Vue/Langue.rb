class Langue

    ### Constantes de classe

    EN = 0
    FR = 1

    ### Attributs d'instances

    @langueFr
    @langueEn
    @langueActuelle
    @langueConstante

    attr_reader :langueActuelle, :langueConstante

    ##
    # Méthode de création de la Langue.
    #
    # Paramètre::
    #   * _langue_ - Langue du jeu sous la forme des constantes de cette classe
    #
    def initialize(langue) 

        @langueFr = {
            aide: "Aide",
            anglais: "Anglais",
            annuler: "Annuler",
            annulerAction: "Annuler",
            appliquer: "Appliquer",
            appliquerRegle: "Appliquer la ",
            baseDonnees: "Base de données",
            charger: "Charger",
            chargerPartie: "Charger partie",
            chefProjet: "Chef de projet",
            classement: "Classement",
            codage: "Codage du jeu",
            confirmationQuitter: "Voulez vous vraiment quitter la partie ?",
            confirmationRecommencer: "Voulez vous vraiment recommencer cette partie ?",
            confirmationSauvegarde: "Voulez vous vraiment sauvegarder cette partie ?",
            connexion: "Connexion",
            conseil: "Conseil",
            reglesRespectees: "L'ensemble des règles sont respectées.\nUtiliser l'aide ou le mode hypothèse si vous êtes bloqué.",
            couleurTuiles: "Couleur des tuiles",
            credits: "Crédits",
            demarrage: "Demarrage",
            difficulte: "Difficulté",
            documentaliste: "Documentaliste",
            et: " et ",
            felicitations: "Félicitations, vous avez réussi à résoudre une grille ",
            felicitations2: " en difficulté ",
            formatDate: "%d/%m/%Y",
            francais: "Français",
            grilleInvalide: "Grille invalide",
            grilleInvalideExplications: "La grille est invalide, vérifiez bien que toutes les règles sont respectées.",
            hypothese: "Hypothèse",
            hypotheseActive: " Hypothèse\n activé",
            inscription: "Inscription",
            inscrit: "Inscrit le",
            interfaceGraphique: "Interface graphique",
            jouer: "Jouer",
            langue: "Langue",
            menuPrincipal: "Menu principal",
            modeDeJeuEnLigne: "Mode de jeu en ligne",
            modeDeJeuHorsLigne: "Mode de jeu hors ligne",
            motDePasse: "Mot de passe",
            nbAides: "Nombre d'aides utilisées",
            nbConseils: "Nombre de conseils utilisés",
            nbCoups: "Nombre de coups effectués",
            nbPartiesTermines: "Nombre de parties terminées",
            succesDeverrouille: "Succès déverrouillé",
            niveau: "Niveau",
            non: "Non",
            nouvellePartie: "Nouvelle partie",
            options: "Options",
            oui: "Oui",
            partiesParfaites: "parties parfaites",
            partiesTermines: "parties terminées",
            profil: "Profil",
            pseudo: "Pseudo",
            quitter: "Quitter",
            fermer: "Fermer",
            rang: "Rang",
            recherche: "Chercher un joueur",
            recommencer: "Recommencer",
            regleColonne: " sur la colonne ",
            regleLigne: " sur la ligne ",
            regles: "Règles du jeu",
            regles1: "Règle n°1 : Il ne peut y avoir plus de deux cases possédant le même état à la suite",
            regles2: "Règle n°2 : Chaque ligne et colonne possède autant de cases à l’état n°1 et à l’état n°2",
            regles3: "Règle n°3 : Il ne peut y avoir deux lignes ou deux colonnes identiques",
            repeter: "Répéter",
            resultatPartie: "Résultat de la partie",
            retour: "Retour",
            retournerMenuPrincipal: "Retourner au menu principal",
            descriptionSauvegarde: "Entrer une description pour la sauvegarde (20 caractères max)",
            sauvegardeEffectuee: "La partie a bien été sauvegardée",
            sauvegarder: "Sauvegarder",
            score: "Score",
            succes: "Succes",
            statistiques: "Statistiques",
            taille: "Taille",
            tailleGrille: "Taille de la grille",
            temps: "Temps",
            tempsDeJeu: "Temps de jeu total",
            valider: "Valider",
            validerGrille: "Valider la grille"
        }

        @langueEn = {
            aide: "Help",
            anglais: "English",
            annuler: "Cancel",
            annulerAction: "Undo",
            appliquer: "Apply",
            appliquerRegle: "Apply the ",
            baseDonnees: "Database",
            charger: "Load",
            chargerPartie: "Load game",
            chefProjet: "Project manager",
            classement: "Ranking",
            codage: "Coding",
            confirmationQuitter: "Do you really want to quit this game ?",
            confirmationRecommencer: "Do you really want to restart this game ?",
            confirmationSauvegarde: "Do you really want to save this game ?",
            connexion: "Login",
            conseil: "Advice",
            reglesRespectees: "All the rules are followed.\nUse helps or hypothesis if you get stuck.",
            couleurTuiles: "Color tiles",
            credits: "Credits",
            demarrage: "Launch",
            difficulte: "Difficulty",
            documentaliste: "Archivist",
            et: " and ",
            felicitations: "Congratulations, you managed to solve a grid ",
            felicitations2: " in difficulty ",
            formatDate: "%m/%d/%Y",
            francais: "French",
            grilleInvalide: "Invalid grid",
            grilleInvalideExplications: "The grid is invalid, make sure that all the rules are followed.",
            hypothese: "Hypothesis",
            hypotheseActive: " Hypothesis\n enabled",
            inscription: "Sign up",
            inscrit: "Registered",
            interfaceGraphique: "Graphical User Interface",
            jouer: "Play",
            langue: "Language",
            menuPrincipal: "Main menu",
            modeDeJeuEnLigne: "Online play mode",
            modeDeJeuHorsLigne: "Offline play mode",
            motDePasse: "Password",
            nbAides: "Number of helps used",
            nbConseils: "Number of advices used",
            nbCoups: "Number of moves made",
            nbPartiesTermines: "Number of finished games",
            succesDeverrouille: "Achievement unlocked",
            niveau: "Level",
            non: "No",
            nouvellePartie: "New game",
            options: "Settings",
            oui: "Yes",
            partiesParfaites: "completed games",
            partiesTermines: "perfect games",
            profil: "Profile",
            pseudo: "Pseudo",
            quitter: "Quit",
            fermer: "Close",
            rang: "Rank",
            recherche: "Player search",
            recommencer: "Restart",
            regleColonne: " on the column ",
            regleLigne: " on the row ",
            regles: "Rules",
            regles1: "Rule n°1 : Three adjacent tiles of the same color in a row or column isn't allowed",
            regles2: "Rule n°2 : Rows and columns have an equal number of each color",
            regles3: "Rule n°3 : No two rows and no two columns are the same",
            repeter: "Redo",
            resultatPartie: "Result of the game",
            retour: "Back",
            retournerMenuPrincipal: "Back to the main menu",
            descriptionSauvegarde: "Enter a description for the save (20 characters max)",
            sauvegardeEffectuee: "The game has been saved.",
            sauvegarder: "Save",
            score: "Score",
            succes: "Achievement",
            statistiques: "Statistics",
            taille: "Size",
            tailleGrille: "Grid size",
            temps: "Time",
            tempsDeJeu: "Total play time",
            valider: "Confirm",
            validerGrille: "Check the grid"
        }
        if(langue == FR)
            @langueActuelle = @langueFr
        else
            @langueActuelle = @langueEn
        end
        @langueConstante = langue
    end

    ##
    # Retour::
    #   La constante de langue actuellement active
    #
    def getLangueConstante()
        return @langueConstante
    end

    ##
    # Affecte une nouvelle langue
    #
    # Paramètre::
    #   * _langue_ - La nouvelle langue à affecter sous la forme des constantes de cette classe
    #
    def setLangue(langue)
        if(langue == FR)
            @langueActuelle = @langueFr
        else
            @langueActuelle = @langueEn
        end  
        @langueConstante = langue
    end

end
/*
	Requêtes SQL à implémenter dans la classe Data du client (variantes pour le serveur)
	Toutes ne sont pas forcément utiles et tous les cas ne sont pas couvert mais c'est déjà bien large
	
	WIP : les requêtes de calcul de scores
*/

/*
	---
	Utilisateurs
	---
*/

/* Récupérer le nombre d'utilisateur */
SELECT COUNT(id)
FROM utilisateur;

/* Lister les utilisateurs */
SELECT *
FROM utilisateur
LIMIT var0
OFFSET var1;

/* Sélectionner un utilisateur par son pseudo et mot de passe (connexion) */
SELECT *
FROM utilisateur
WHERE
	nom = var0
	AND mot_de_passe = var1
LIMIT 1;

/* Sélectionner un utilisateur par son uuid (voir profil autre utilisateur) (attention cas offline et online id/uuid)*/
/*SELECT *
FROM utilisateur
WHERE uuid = var0
LIMIT 1;/*

/* Ajouter un utilisateur */
INSERT INTO score
VALUES (
	null,
	null,
	string,
	string,
	int,
	string,
	int
);

/* Supprimer un utilisateur */
DELETE FROM utilisateur
WHERE id = var0
LIMIT 1;

/* CHanger le type d'utilisateur */
UPDATE utilisateur
SET type = (
	CASE type
		WHEN 0 THEN 1
		WHEN 1 THEN 0
	END
)
WHERE id = var0
LIMIT 1;

/*
	---
	Scores
	---
*/

/* Compter le nombre de scores */
SELECT COUNT(id)
FROM score;

/* Lister les scores */
SELECT *
FROM score
LIMIT var0
OFFSET var1;

/* Compter le nombre de scores pour une grille */
SELECT COUNT(id)
FROM score
WHERE id_grille = var0;

/* Lister les scores d'une grille */
SELECT *
FROM score
WHERE id_grille = var0
LIMIT var0
OFFSET var1;

/* Compter le nombre de scores d'un utilisateur */
SELECT COUNT(id)
FROM score
WHERE id_utilisateur = var0;

/* Lister les scores d'un utilisateur */
SELECT *
FROM score
WHERE id_utilisateur = var0
LIMIT var0
OFFSET var1;

/* Sélectionner un score selon un id (utile ?) */
SELECT *
FROM score
WHERE id = var0
lIMIT 1;

/* Sélectionner un score selon l'utilisateur et la grille (utile ?) */
SELECT *
FROM score
WHERE
	id_utilisateur = var0
	AND id_grille = var1
LIMIT 1;

/*
	Calculer le score total d'un utilisateur
	
	t : le temps nécessaire pour résoudre la grille (en seconde).
	x : le nombre de changement de case.
	a : le nombre de demande d'aide
	c : le nombre de demande conseil
	g : la taille de la grille
	n : le niveau de difficulté de la grille
	
	F = (g * n) / (1 + t + c + a)
*/
SELECT SUM(nb_coups * )
FROM score
WHERE id_utilisateur = var0;

/* Lire le meilleur score d'un utilisateur sur une grille */
SELECT
	score.id,
	score.temps_total,
	score.nb_coups,
	score.nb_conseils,
	score.nb_aides,
	grille.niveau
FROM score
INNER JOIN grille
	ON grille.id = var1
WHERE
	score.id_utilisateur = var0
	AND score.id_grille = var1
ORDER BY
	score.temps_total,
	score.nb_coups DESC,
	score.nb_conseils DESC,
	score.nb_aides DESC
LIMIT 1;

/* Lire le meilleur score d'une grille */
SELECT
	score.id,
	score.temps_total,
	score.nb_coups,
	score.nb_conseils,
	score.nb_aides,
	grille.niveau
FROM score
INNER JOIN grille
	ON grille.id = var0
WHERE
	score.id_grille = var0
ORDER BY
	score.temps_total,
	score.nb_coups DESC,
	score.nb_conseils DESC,
	score.nb_aides DESC
LIMIT 1;

/* Ajouter un score */
INSERT INTO score
VALUES (
	null,
	null,
	int,
	int,
	int,
	int,
	int,
	int
);

/* Supprimer les scores d'un utilisateur (réinitialisation) */
DELETE FROM score
WHERE id_utilisateur = var0;

/*
	---
	Sauvegardes
	---
*/

/* Compter le nombre de sauvegardes d'un utilisateur */
SELECT COUNT(id)
FROM sauvegarde
WHERE id_utilisateur = var0;

/* Lister les sauvegardes d'un utilisateur */
SELECT *
FROM sauvegarde
WHERE id_utilisateur = var0;

/* Lire une sauvegarde selon son uuid */
SELECT *
FROM sauvegarde
WHERE uuid = var0
LIMIT 1;

/* Ajouter une sauvegarde */
INSERT INTO sauvegarde
VALUES (
	null,
	null,
	int,
	sting
);

/* Supprimer une sauvegarde */
DELETE FROM sauvegarde
WHERE uuid = var0
LIMIT 1;

/* Supprimer les sauvegardes d'un utilisateur (réinitialisation) */
DELETE FROM sauvegarde
WHERE id_utilisateur = var0;

/*
	---
	Grilles
	---
*/

/* Compter le nombre de grille */
SELECT COUNT(id)
FROM grille;

/* Lister les grilles */
SELECT *
FROM grille;

/* Lire une grille selon son id */
SELECT *
FROM grille
WHERE id = var0
LIMIT 1;

/*
	---
	Singleton :
	---
	
	http://www.apprendre-php.com/tutoriels/tutoriel-45-singleton-instance-unique-d-une-classe.html
	
	---
	Socket :
	---
	
	http://www.tutorialspoint.com/ruby/ruby_socket_programming.htm
	http://www.thebuzzmedia.com/programming-a-simple-clientserver-with-ruby/
	http://en.wikibooks.org/wiki/Ruby_Programming/Reference/Objects/Socket
	http://ruby-doc.org/stdlib-2.2.0/libdoc/socket/rdoc/Socket.html#M001255
	
	---
	MySQL :
	---
	
	http://zetcode.com/db/mysqlrubytutorial/
*/

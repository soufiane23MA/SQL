EXO_SQL_CINEMA

a: Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et
réalisateur ;

SELECT f.titre,f.annee_Sortie,f.duree_Filme,SEC_TO_TIME(f.duree_filme*60) AS 'duree' ,
CONCAT(p.nom_Personne,p.prenom_Personne) AS 'Realisateur' FROM film f

INNER JOIN realisateur r ON f.id_Realisateur=r.id_Realisateur
INNER JOIN personne p ON r.id_Personne = p.id_Personne
WHERE f.id_Filme=6; 

b: Liste des films dont la durée excède 2h15 classés par durée (du + long au + court)
 
SELECT f.titre AS 'TITRE', f.duree_Filme AS 'DUREE DE Filme' FROM film f 
WHERE  duree_Filme > '02:15:00'
ORDER BY  duree_Filme DESC;

c: Liste des films d’un réalisateur (en précisant l’année de sortie) 
/* ici on cherche a affiché l'enssemble de films d'un réalisateur précis, et l'année de sortie de filme 
 la methode CONCAT() permer la concaténation des chaine de caractéres
  comme nom et prenom de réalisateur ici*/


SELECT f.titre AS Titre, f.annee_Sortie AS "Année de sortie",CONCAT(nom_Personne," ",prenom_Personne) AS "nom Realisateur"
FROM film f
JOIN realisateur r ON f.id_Realisateur = r.id_Realisateur
JOIN personne p ON r.id_Personne = p.id_Personne
WHERE r.id_Realisateur = 1;

d. Nombre de films par genre (classés dans l’ordre décroissant)
/* pour compter le nombre de filme par genre, il faut utiliser la fonction d'agrégation count(), 
/* pour l'ordre décroissant on utilisra DESC
*/

 SELECT g.libelle AS genre,COUNT(f.id_Filme) AS nombre_films
FROM genre g
INNER JOIN appartenir ap ON g.id_Genre = ap.id_Genre
INNER JOIN film f ON ap.id_Filme = f.id_Filme
GROUP BY g.id_Genre
ORDER BY nombre_films DESC;

e. Nombre de films par réalisateur (classés dans l’ordre décroissant)
/*  dans la table filme , on compte le nombre de filme regrouper par le nom du realisateur, 
avec DESC on obtien l'ordre décroissant .*/


SELECT p.nom_Personne AS 'Realisateur',COUNT(f.id_Filme) AS 'nombre_films'
FROM film f
INNER JOIN realisateur r ON r.id_Realisateur = f.id_Realisateur
INNER JOIN personne p ON r.id_Personne = p.id_Personne
GROUP BY p.id_Personne
ORDER BY nombre_films DESC;

f. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe
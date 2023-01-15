SELECT movies.title FROM movies
JOIN stars ON movies.id = stars.movie_id
JOIN people ON stars.person_id = people.id
WHERE people.name = "Johnny Depp" AND movies.title IN --idk movies.title IN
(SELECT movies.title FROM movies
JOIN people ON stars.person_id = people.id
JOIN stars ON movies.id = stars.movie_id
WHERE people.name = "Helena Bonham Carter");

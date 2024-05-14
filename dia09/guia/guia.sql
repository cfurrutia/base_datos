CREATE DATABASE TestDbeaverMovies; 

\c TestDbeaverMovies; 

public.peliculas definition

Drop table

DROP TABLE public.peliculas;

CREATE TABLE public.peliculas (
	id int4 NULL,
	"Pelicula" varchar(64) NULL,
	"Año estreno" int4 NULL,
	"Director" varchar(50) NULL
);

select * from peliculas;

select id from peliculas where "Pelicula" = 'Titanic';

/* id
----
  2
(1 fila)*/

-- select max("Año estreno") from peliculas;  -- solo funciona en dbeaver

select max("A±o estreno") from peliculas; 

/* max
------
 2008
(1 fila)*/

select count(id) from peliculas where "Director" = 'Peter Jackson';

/* count
-------
     4
(1 fila) */


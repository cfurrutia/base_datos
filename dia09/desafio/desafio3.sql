/*Descripción
Se requiere crear un sitio web dedicado al mundo cinematográfico donde los usuarios
puedan buscar detalles del top 100 de películas más populares. El plus más importante de
este sitio web debe ser la variedad de filtros que ofrece para una búsqueda más efectiva.
Para este desafío necesitarás crear 2 tablas llamadas películas y reparto, sus datos los
consigues en los ficheros de extensión csv ubicados en el Apoyo Desafío.
*/

-- 1 Crear una base de datos llamada películas.

CREATE DATABASE peliculas;
\c peliculas; 

-- dll DBeaver
-- 2 Cargar ambos archivos a su tabla correspondiente.

-- public.peliculas definition

-- Drop table

-- DROP TABLE public.peliculas;

CREATE TABLE public.peliculas (
	id int4 NULL,
	pelicula varchar(64) NULL,
	"Año estreno" int4 NULL,
	director varchar(50) NULL
);

-- public.reparto definition

-- Drop table

-- DROP TABLE public.reparto;

CREATE TABLE public.reparto (
	id_pelicula int4 NULL,
	actor varchar(50) NULL
);

select * from peliculas;
select * from reparto;  

-- 3 Obtener el ID de la película “Titanic”
SELECT id FROM peliculas WHERE "pelicula" = 'Titanic';

/* id
----
  2
(1 fila) */

-- 4 Listar a todos los actores que aparecen en la película "Titanic".

SELECT r.actor
FROM peliculas p
JOIN reparto r ON p.id = r.id_pelicula
WHERE p."pelicula" = 'Titanic';

/*       actor
-------------------
 Leonardo DiCaprio
 Kate Winslet
 Billy Zane
 Kathy Bates
 Frances Fisher
 Bernard Hill
 Jonathan Hyde
 Danny Nucci
 David Warner
 Bill Paxton
 Gloria Stuart
 Victor Garber
 Suzy Amis
(13 filas)
*/

-- 5 Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT COUNT(*) AS num_peliculas
FROM reparto
WHERE actor = 'Harrison Ford';

/*  num_peliculas
---------------
             8
(1 fila)
*/

-- 6 Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.

SELECT "pelicula"
FROM peliculas
WHERE "A±o estreno" BETWEEN 1990 AND 1999  -- WHERE "Año estreno" BETWEEN 1990 AND 1999  DBeaver
ORDER BY "pelicula" ASC;
/*                  pelicula
--------------------------------------------
 American Beauty
 American History X
 Braveheart
 Cadena perpetua
 Eduardo Manostijeras
 El club de la pelea
 El Padrino. Parte III
 El profesional
 El sexto sentido
 El show de Truman
 El silencio de los corderos
 Entrevista con el vampiro
 Forest Gump
 Hombres de negro
 La lista de Schindler
 La milla verde
 Matrix
 Mejor... imposible
 Parque Jurßsico
 Pesadilla antes de navidad
 Pulp Fiction
 Salvar al soldado Ryan
 Seven
 Star Wars. Episodio I: La amenaza fantasma
 Terminator 2: el juicio final
 Titanic
 Toy Story
 Toy Story 2
 Trainspotting
 Uno de los nuestros
(30 filas)*/

-- 7 Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser
-- nombrado para la consulta como “longitud_titulo”. 

SELECT "pelicula", LENGTH("pelicula") AS longitud_titulo
FROM peliculas;

/*                      pelicula                       | longitud_titulo
------------------------------------------------------+-----------------
 Forest Gump                                          |              11
 Titanic                                              |               7
 El Padrino                                           |              10
 Gladiator                                            |               9
 El Se±or de los anillos: El retorno del rey          |              43
 El caballero oscuro                                  |              19
 Cadena perpetua                                      |              15
 Piratas del Caribe: La maldici¾n de la Perla Negra   |              50
 Braveheart                                           |              10
 La lista de Schindler                                |              21
 Toy Story                                            |               9
 Eduardo Manostijeras                                 |              20
 El Se±or de los anillos: La comunidad del anillo     |              48
 Salvar al soldado Ryan                               |              22
 Regreso al futuro                                    |              17
 Monstruos S.A.                                       |              14
 Buscando a Nemo                                      |              15
 El Se±or de los anillos: Las dos torres              |              39
 Harry Potter y el Prisionero de Azkaban              |              39
 American History X                                   |              18
 300                                                  |               3
 El sexto sentido                                     |              16
 Pulp Fiction                                         |              12
 V de Vendetta                                        |              13
 El silencio de los corderos                          |              27
 Rocky                                                |               5
 El club de la pelea                                  |              19
 E.T                                                  |               3
 Parque Jurßsico                                      |              15
 Matrix                                               |               6
 La milla verde                                       |              14
 Ratatouille                                          |              11
 Grease                                               |               6
 El Padrino. Parte II                                 |              20
 Wall-E                                               |               6
 Iron Man                                             |               8
 El exorcista                                         |              12
 Piratas del Caribe: El cofre del hombre muerto       |              46
 Seven                                                |               5
 Terminator 2: el juicio final                        |              29
 El resplandor                                        |              13
 Hombres de negro                                     |              16
 Spider-Man                                           |              10
 Regreso al futuro II                                 |              20
 El show de Truman                                    |              17
 Toy Story 2                                          |              11
 Pesadilla antes de navidad                           |              26
 Star Wars. Episodio IV: Una nueva esperanza          |              43
 Saw                                                  |               3
 Terminator                                           |              10
 Kill Bill Vol. 1                                     |              16
 Lo que el viento se llev¾                            |              25
 El Laberinto del Fauno                               |              22
 Los increÝbles                                       |              14
 El viaje de Chihiro                                  |              19
 El precio del poder                                  |              19
 King Kong                                            |               9
 Ben-Hur                                              |               7
 Indiana Jones y la ·ltima cruzada                    |              33
 Infiltrados                                          |              11
 Entrevista con el vampiro                            |              25
 Batman Begins                                        |              13
 En busca del arca perdida                            |              25
 Star Wars. Episodio III: La venganza de los Sith     |              48
 Alien                                                |               5
 El bueno el feo y el malo                            |              25
 Star Wars. Episodio V: El imperio contraataca        |              45
 El Padrino. Parte III                                |              21
 Star Wars. Episodio VI: El retorno del Jedi          |              43
 Escuela de Rock                                      |              15
 El planeta de los simios                             |              24
 Rambo                                                |               5
 Full Metal Jacket                                    |              17
 Tibur¾n                                              |               7
 El profesional                                       |              14
 American Beauty                                      |              15
 Casablanca                                           |              10
 AmÚlie                                               |               6
 Trainspotting                                        |              13
 axi driver                                           |              10
 Alguien vol¾ sobre el nido del cuco                  |              35
 Kill Bill Vol. 2                                     |              16
 Spider-Man 2                                         |              12
 X-Men 2                                              |               7
 Transformers                                         |              12
 Star Wars. Episodio I: La amenaza fantasma           |              42
 Blade Runner                                         |              12
 Apocalypse Now                                       |              14
 Mejor... imposible                                   |              18
 La vida de Brian                                     |              16
 El libro de la selva                                 |              20
 Los cazafantasmas                                    |              17
 Sweeney Todd: El barbero diab¾lico de la calle Fleet |              52
 Ocean's Eleven                                       |              14
 Blancanieves y los siete enanitos                    |              33
 Predator                                             |               8
 Indiana Jones y el templo maldito                    |              33
 Uno de los nuestros                                  |              19
 Mouling Rouge                                        |              13
 Psicosis                                             |               8
(100 filas) */

-- 8 Consultar cual es la longitud más grande entre todos los títulos de las películas.

SELECT MAX(LENGTH("pelicula")) AS longitud_maxima
FROM peliculas;

/*  longitud_maxima
-----------------
              52
(1 fila)*/
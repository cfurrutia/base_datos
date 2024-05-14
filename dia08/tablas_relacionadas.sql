
--Paso 1: Creamos las tablas libros y autores con el siguiente código.
--Ignorar la restricción de clave foránea
--tabla padre
CREATE TABLE autores (
    id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE libros (
    id INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    autor_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (autor_id) REFERENCES autores (id) ON DELETE CASCADE
);

--Paso 2: Insertamos algunos datos en ambas tablas
INSERT INTO autores (id, nombre)
VALUES
    (1, 'Juan Pérez'),
    (2, 'María García'),
    (3, 'Pedro Rodríguez');

INSERT INTO libros (id, titulo, autor_id)
VALUES
    (1, 'El Quijote', 1),
    (2, 'La Divina Comedia', 2),
    (3, 'Hamlet', 3);

--Paso 3: Consultamos los datos de ambas tablas
id |     nombre
----+-----------------
1 | Juan Pérez
2 | María García
3 | Pedro Rodríguez
(3 rows)

id |      titulo       | autor_id 
----+-------------------+----------
1 | El Quijote        |        1
2 | La Divina Comedia |        2
3 | Hamlet            |        3
(3 rows)

--Paso 4: Comprobación de la restricción de clave foránea.
delete from autores;

delete from libros;
DELETE 3

/*En este caso, sí es posible eliminar los registros de libros dado que la restricción se aplica
del lado de la referencia (la tabla padre).*/

--BORRADO EN CASCADA
drop table autores;-- esta forma no la toma

--con esa borra todo, datos, restricciones y foreign key
drop table autores CASCADE;



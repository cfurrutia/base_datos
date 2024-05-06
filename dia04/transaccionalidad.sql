--DQL: Leguaje de Consulta de datos; SELECT
--DML: Lenguaje de Manipulación de datos; INSERT, UPDATE, DELETE

--Paso 1: Creamos una base de datos de comidas típicas chilenas.
create database comidas_tipicas;

--Paso 1a: entrado a la base de datos
\c comidas_tipicas

--Paso 2: Creamos una tabla llamada cocina chilena con los campos id y nombre.
create table cocina_chilena(id int, nombre varchar(50));

--Paso 3: Insertamos 2 registros a la tabla con sus respectivos campos.
insert into cocina_chilena (id, nombre) values ('1','Pastel de choclo');
insert into cocina_chilena (id, nombre) values ('2', 'Umitas');
/*El ingreso del segundo registro tiene la intencionalidad del error, se escribe humitas,
pero ¿Qué podemos realizar ahora que ya el registro se ingresó?*/

--consultamos la tabla
select * from cocina_chilena;

--Agregamos la PK
alter table cocina_chilena add primary key(id);

--Paso 4: Para actualizar un registro utilizamos update.
UPDATE cocina_chilena 
set nombre='Humitas' 
where id = 2;
/*Con el código SQL anterior estamos:
1. Utilizamos la sentencia update.
2. Pasamos el nombre de la tabla en la cual se ejecutará el update
3. Utilizamos set, seleccionamos el nombre de la columna y el nuevo valor para el
registro.
4. Evaluamos condicionalmente con where la selección del registro cuyo ID sea 2.*/

-- Si no indicamos el ID, cambiamos toda la informacion:
UPDATE cocina_chilena set nombre='Humitas'
-- AHora las dos columnas son humitas.

-- Volvemos a actualizar el id 1
UPDATE cocina_chilena set nombre='Pastel de Choclo' where id = 1;

--Ingresa 3 registros más a la tabla e intenciona el update en al menos 2 de ellos
insert into cocina_chilena (id, nombre) values ('3','Empanadas');
insert into cocina_chilena (id, nombre) values ('4', 'Calsones rotos');
insert into cocina_chilena (id, nombre) values ('5', 'zopaipillas');

UPDATE cocina_chilena set nombre='Calzones Rotos' where id = 4;
UPDATE cocina_chilena set nombre='Sopaipillas' where id = 5;


/*Paso 5: Eliminar un registro lo podremos hacer con la sentencia Delete. Así
como hicimos con la actualización, utilizaremos el id para capturar un registro
puntual.*/
delete from cocina_chilena where id = 2;
--Aqui borramos las humitas

--Si no especificamos el ID, borramos TODOS los registros:
delete from cocina_chilena;

--Vuelvo a agregar las humitas
insert into cocina_chilena (id, nombre) values ('2', 'Humitas');


--Paso 6: Eliminar múltiples registros en la tabla. 
delete from cocina_chilena where id IN (3, 4, 5, 7);
--con el IN busca los id de la lista y borra SOLO los que encuentra (empanadas, calzones rotos y sopaipillas)

--vuelvo a agregar los datos:
insert into cocina_chilena (id, nombre) values ('3','Empanadas');
insert into cocina_chilena (id, nombre) values ('4', 'Calzones rotos');
insert into cocina_chilena (id, nombre) values ('5', 'Sopaipillas');

--prueba
delete from cocina_chilena where id = 5 and id = 3; 
--DELETE 0. No borra nada pq no puede haber un item con 2 IDs. 
--Busca un regitro que cumpla con AMBAS condiciones

delete from cocina_chilena where id = 5 or id = 3;
--Aquí borró a los 2, pq buscó un item con id 5 y id 3 por separado.

UPDATE cocina_chilena 
set nombre= nombre + ' 2024'
RETURNING *;
--HINT:  Ningún operador coincide en el nombre y tipos de argumentos. Puede ser necesario agregar conversión explícita de tipos.

UPDATE cocina_chilena 
set nombre = concat(nombre, '2024')
RETURNING *;

UPDATE usuarios
SET nombre_completo = nombre || ' ' || apellido;

UPDATE cocina_chilena 
set id = id + ' 2024'
RETURNING *;
/*  id  |      nombre
------+------------------
2025 | Pastel de Choclo
2026 | Humitas
2028 | Calzones rotos
(3 rows)
UPDATE 3*/

****************************************************

--EJERCICIO:
/*Crea una nueva base de datos, en ella deberás almacenar información de perros o
gatos, los campos deberán ser:
1. ID
2. Nombre
3. Raza
4. Edad*/
create database animales;
\c animales
create table mascotas(id int, nombre varchar(50), raza varchar, edad int);
select * from mascotas;

/*Ingresa al menos unos 5 registros e intenciona las acciones de:
● Update.
● Delete.*/

INSERT INTO mascotas VALUES (1, 'Nazir', 'Yorkie', 4);
INSERT INTO mascotas VALUES (2, 'Kai', 'Mestiso', 4);
INSERT INTO mascotas VALUES (3, 'Kira', 'Gato', 6);
INSERT INTO mascotas VALUES (4, 'Kazán', 'Westy', 12);
INSERT INTO mascotas VALUES (5, 'Farah', 'Gato', 8);

UPDATE mascotas set raza='Mestizo' where id = 2;
UPDATE mascotas set raza='Yorkshire' where id = 1;

DELETE from mascotas where id = 5 RETURNING *;
--El returning entrega la informacion de lo que estamos haciendo, en este caso me muestra el registro que eliminé
/*animales=# DELETE from mascotas where id = 5 RETURNING *;
id | nombre | raza | edad
----+--------+------+------
5 | Farah  | Gato |    8
(1 fila)


DELETE 1

*/
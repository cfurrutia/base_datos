-- lo primero a realizar es conectarse a la base de datos
psql -U postgres
--Paso 1: Accedemos al cliente de postgresql via el terminal.
--● Paso 2: Crea una base de datos llamada prueba1.
CREATE DATABASE prueba1;
--● Paso 3: Lista las bases de datos creadas.
\l;
--● Paso 4: Conéctate a la base de datos.
\c prueba1; -- Ahora está conectado a la base de datos «prueba1» con el usuario «postgres».
\q
-- Creacion de una tabla 
create table clientes(
nombre varchar(30),
apellido varchar(30)
);
-- listar las tablas de una base de datos
\d 
--
\d clientes  -- describe o detalla una tabla
--postgres=# \d cliente
--No se encontró relación llamada «cliente».
--postgres=# \d clientes
--                         Tabla ½public.clientes╗
-- Columna  |         Tipo          | Ordenamiento | Nulable | Por omisi¾n
----------+-----------------------+--------------+---------+-------------
-- nombre   | character varying(30) |              |         |
-- apellido | character varying(30) |              |         |
\d+ clientes
-- Columna  |         Tipo          | Ordenamiento | Nulable | Por omisi¾n | Almacenamiento | Compresi¾n | EstadÝsticas | Descripci¾n ----------+-----------------------+--------------+---------+-------------+----------------+------------+--------------+------------- nombre   | character varying(30) |              |         |             | extended       |            |              |
-- apellido | character varying(30) |              |         |             | extended       |            |              |
-- MÚtodo de acceso: heap

-- insertar valores a una tabla
insert into clientes (nombre, apellido) values ('Carlos','Urrutia');
insert into clientes (nombre, apellido) values ('Julio','Pslma');
insert into clientes values ('Juan','torres');
insert into clientes (apellido, nombre) values ('Gatica','Najla');
-- consutar registros en una tabla
select * from clientes;
-- consultar registros en una tabla
select * from clientes order by nombre desc;
-- borrar algun registro de la tabla
delete from clientes where --apellido = 'Palma'
delete from clientes where nombre ='Carlos' and apellido = 'Urrutia';

SELECT sum(columna) from tabla;

SELECT avg(columna) from tabla;

SELECT max(columna) from tabla;

SELECT min(columna) from tabla;

SELECT count(*) from tabla;

--in () filtrar o comprobar si un valor existe en una lista determinada

SELECT *
from productos
where id_productos in (20,1,55,3);

-- modificar una tabla
alter table clientes and primary key(rut);


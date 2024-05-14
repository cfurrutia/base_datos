Create database descripciones;
\c descripciones

--Paso 1: Creamos la tabla clientes create table clientes;
create table clientes (
    id integer unique not null, 
    name varchar(25) not null, 
    email varchar(50)
    );

--Paso 2: Insertamos al menos 3 registros, todos sin ingresar el campo email.
insert into clientes(id, name) values (1, 'Nombre 1');
insert into clientes(id, name) values (2, 'Nombre 2');
insert into clientes(id, name) values (3, 'Nombre 3');
insert into clientes(id, name, email) values (4, 'Nombre 4', 'email@correo.cl');

select * from clientes; 

--Paso 3: Modificamos el campo email a not null con alter table.
ALTER TABLE clientes ALTER COLUMN email SET NOT NULL;

--da un error 
--ERROR:  la columna «email» de la relación «clientes» contiene valores null

/*Paso 4: Debemos actualizar la tabla con el comando UPDATE, seguidamente
debemos indicar la columna a modificar y por último con WHERE definir la
condición cuando el campo sea nulo.*/
UPDATE clientes set email = '' WHERE email is null;

--Paso 5: Corremos nuevamente el comando de alteración de la columna
ALTER TABLE clientes ALTER COLUMN email SET NOT NULL;
/* id |   name   |      email
----+----------+-----------------
  1 | Nombre 1 |
  2 | Nombre 2 |
  3 | Nombre 3 |
  4 | Nombre 4 | email@correo.cl
(4 filas)*/

--Paso 6: crear una columna fecha y asignar restriccion
ALTER TABLE clientes ADD COLUMN fecha DATE NOT NULL DEFAULT now();

--COALESCE: permite seleccionar campos que sean nulos en una tabla y modificarlos con un valor
UPDATE clientes SET email = COALESCE(email, 'sin email');

--QUITAR UNA RESTRICCION
ALTER TABLE IF EXISTS public.clientes ALTER COLUMN email DROP NOT NULL;
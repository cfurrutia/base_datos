--Paso 1: Creamos la base de datos restricciones_psql. Luego debemos conectarnos a ella.
create database restricciones_psql;

--Paso 2: Creamos una tabla llamada company con los campos id y nombre.
create table company (
    id serial primary key, 
    nombre varchar not null unique);

select * from company;

--Paso 3: Hacemos dos insert a la tabla.
insert into company(nombre) values('Amazon');
insert into company(nombre) values('Apple');
insert into company(nombre) values('Microsoft');
--En el código a pesar de no definir el id este se ingresa automáticamente 
--y de manera auto incremental.


insert into company(nombre) values(' '); --no es null, está vacío
insert into company(nombre) values();
/*ERROR:  error de sintaxis en o cerca de «)»
LINE 1: insert into company(nombre) values();*/

insert into company(nombre) values(null);
/*ERROR:  el valor nulo en la columna «nombre» de la relación «company» viola la restricción de no nulo
DETAIL:  La fila que falla contiene (6, null).*/

select * from company;

insert into company(id, nombre) values(6, 'Alibaba');

insert into company(nombre) values('Ubuntu');
--Le asigna el número siguiente, en este caso 7

insert into company(id, nombre) values(9, 'Fedora');
--INserta el registro donde yo se lo pido, id 9

insert into company(nombre) values('Slack');
---Usó el id 8

insert into company(nombre) values('Debian');
-- Como el id 9 ya está ocupado, arroja un error
-- ERROR:  llave duplicada viola restricción de unicidad «company_pkey»
-- DETALLE:  Ya existe la llave (id)=(9).

---NEXTVAL
select nextval('company_id_seq'::regclass);
--Consultamos el valor de la secuencia, en este caso: 10
select nextval('company_id_seq');
--Esta consulta SIEMPRE entregara el valor siguiente aunque no se haya utilizado
--10, 11, 12, 13, 14

select * from company_id_seq;
--Con select FROM consultamos la secuenta dentro del registro en el que estamos
--En este caso el resultado siempre arrojará el id que continúa, ej: 15

insert into company(nombre) values('Asus');
--16 | Asus




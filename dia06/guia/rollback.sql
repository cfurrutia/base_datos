/*ACID, un acrónimo que representa atomicidad, consistencia, aislamiento y durabilidad, establece 
un conjunto de propiedades cruciales para mantener la integridad de los datos en entornos 
transaccionales. En este artículo, nos sumergiremos en los principios del modelo ACID en bases de datos.

PL/SQL es un lenguaje de procedimiento diseñado específicamente para abarcar sentencias SQL dentro de 
su sintaxis. El servidor de Oracle Database compila las unidades de programa PL/SQL y se almacenan dentro
de la base de datos. Y en tiempo de ejecución, tanto PL/SQL como SQL se ejecutan dentro del mismo proceso
de servidor, brindando una eficiencia óptima. PL/SQL hereda automáticamente la robustez, la seguridad y 
la portabilidad de Oracle Database.
Commit de transacciones en una cuenta bancaria

Paso 1: Creamos la base de datos transacciones y nos conectamos.*/
create database transacciones;
\c transacciones;

--Paso 2: Creamos una tabla llamada cuentas con los campos numero_cuenta y balance.
create table cuentas (
    numero_cuenta int primary key, 
    balance float check(balance >= 0.00));

--Paso 3: Insertamos dos registros a la tabla.
insert into cuentas (numero_cuenta, balance) values (1, 1000);
insert into cuentas (numero_cuenta, balance) values (2, 1000);


/*Paso 4: Si quisiéramos hacer una transferencia de $1000 desde nuestra cuenta
1 a la cuenta 2, una forma de asegurarnos que el monto de nuestro balance
disminuya en $1000 y el de la segunda cuenta aumenta en la misma cifra,
podría escribirse de la siguiente manera:*/
begin transaction;
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 1;
UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 2;


--Paso 5: Verificamos el estado de la tabla.
select * from cuentas;

/* numero_cuenta | balance
---------------+---------
            1 |       0
            2 |    2000
(2 rows)*/


--Paso 6: Confirmamos la transacción con commit.
commit;
--Con COMMIT damos por finalizada la transacción y hacer permanente el cambio.
--la terminal cambia de *# a =#

********************************************************
--Si intentamos volver a restar saldo en la cuenta 1 nos da error 
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 1;
/*ERROR:  el nuevo registro para la relación «cuentas» viola la restricción «check» «cuentas_balance_check»
DETAIL:  La fila que falla contiene (1, -1000).
pq el saldo no puede ser menor a 0*/
********************************************************

/*Paso 7: Continuemos con el ejercicio anterior y apliquemos el uso de ROLLBACK.
Para ello haremos un nuevo insert a la base de datos.*/
insert into cuentas (numero_cuenta, balance) values (3, 1000);

--Paso 8: Iniciamos una transacción para transferir 1000 de la cuenta 3 a la 1.
begin transaction;
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 3;
UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;
---aqui la cuenta 1 quedó con mil

--Paso 9: 
ROLLBACK;
--retrocedemos hasta el ultimo commit y la cuenta 1 volvió a quedar en 0

--SAVE POINT:
begin transaction;
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 3;

SAVEPOINT descuento3;
--creamos un punto de guardado para retornar a él más tarde

UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;
--Aqui estamos forzando un error, añadir plata a una cuenta que no era

ROLLBACK TO descuento3;
--Aquí volvemos a como estaba antes de agregar los mil a la cuenta 1

UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 2;
--ahora la cuenta 2 quedó con 3 lukas

commit;
--guardamos lo que hicimos y salimos de la transacción.

UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;

*********************************************************************************

--BORRADO FISICO
--elimina permanentemente los registros de la base de datos
DELETE FROM cuentas WHERE numero_cuenta = 3;

--agregamos una nueva columna para filtar si las cuentas estan activas o no
ALTER TABLE cuentas add column activa boolean;
UPDATE cuentas SET activa = true;

--BORRADO LOGICO:
--implica marcar los registros como inactivos sin eliminarlos físicamente
UPDATE cuentas set activa = false where numero_cuenta = 1;
--Esto significa que el registro aún existe en la base de datos, pero se considera inactivo.

/*Actividad guiada: Aplicando rollback en cuentas bancarias.

Para este ejercicio seguiremos trabajando en la base de datos de cuentas bancarias,
recuerda que la trabajamos en la sesión anterior. La acción de volver atrás las transacciones
que se realicen sobre una tabla la realizaremos a través de save point y rollback.
Resumen de códigos: */

\c transacciones;

-- 1. Creación de la tabla

create table cuentas (numero_cuenta int not null unique primary key,
balance float check(balance >= 0.00));

-- 2. Inserción de registros:

into cuentas (numero_cuenta, balance) values (1, 1000);
into cuentas (numero_cuenta, balance) values (2, 1000);

-- 3. Transacción controlada donde pasamos los $1000 de la cuenta 1 a la cuenta 2.

begin transaction;
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 1;
UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 2;

-- 4. Confirmamos la transacción:

commit;

/***********************************************************************************/
-- create database transacciones;

-- Paso 1: Nos conectamos a la base de datos
\c transacciones;

-- Paso 2: En la tabla cuentas realizamos una transacción en donde transferimos
/* $1000 de la cuenta 1 a la cuenta 2 y no obtuvimos ningún error. Sin embargo,
podemos verificar que en las transacciones que terminan en error no se altera el
estado de nuestros datos. ¿Y cómo lo hacemos? */

-- Ejecuta el siguiente código en tu terminal.

BEGIN TRANSACTION;
UPDATE cuentas SET balance = balance + 1000 WHERE numero_cuenta = 2;
UPDATE cuentas SET balance = balance - 1000 WHERE numero_cuenta = 1;
ROLLBACK;

/* Al ejecutarlo veremos el siguiente error debido a la restricción de la columna balance que
realizamos con check al momento de crear la tabla.
DETAIL: Failing row contains (1, -1000). */

-- Paso 3: Verificamos el estado de la tabla.

select * from cuentas;

/* Paso 4: Intentemos registrar una nueva cuenta de número 3 en nuestra tabla
“cuentas” con un saldo de $5000 y justo luego guardemos ese punto de la
transacción con un SAVEPOINT de nombre “nueva_cuenta”.*/ 

BEGIN TRANSACTION;
INSERT INTO cuentas(numero_cuenta, balance) VALUES (3,5000);
SAVEPOINT nueva_cuenta;

/* Paso 5: Hasta este punto tenemos la transacción en curso y hemos fijado que
podríamos volver a este estado en cualquier circunstancia. Ahora, intentemos
transferir a esta nueva cuenta $3000 desde la cuenta 2. Para esto continua la
transacción de la siguiente manera.*/

UPDATE cuentas SET balance = balance + 3000 WHERE numero_cuenta = 3;
UPDATE cuentas SET balance = balance - 3000 WHERE numero_cuenta = 2;

-- Justo acá deberás recibir un error

ROLLBACK TO nueva_cuenta;
COMMIT;

-- insertar al menos 10 registros más en la base de datos de transacciones.

INSERT INTO cuentas (numero_cuenta, balance) VALUES (4, 3000);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (5, 1500);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (6, 6000);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (7, 800);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (8, 4500);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (9, 12000);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (10, 2500);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (11, 300);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (12, 7000);
INSERT INTO cuentas (numero_cuenta, balance) VALUES (13, 9500);

/*INSERT INTO cuentas (numero_cuenta, balance) VALUES (4,7000);
INSERT 0 1
postgres=# INSERT INTO cuentas(numero_cuenta, balance) VALUES (5,
500);
INSERT 0 1
postgres=# INSERT INTO cuentas(numero_cuenta, balance) VALUES (6,
12000);
INSERT 0 1
postgres=# INSERT INTO cuentas(numero_cuenta, balance) VALUES (7,
900);
INSERT 0 1
postgres=# INSERT INTO cuentas(numero_cuenta, balance) VALUES (8,
100);
INSERT 0 1
postgres=# INSERT INTO cuentas(numero_cuenta, balance) VALUES (9,
20000);
INSERT 0 1
postgres=# INSERT INTO cuentas(numero_cuenta, balance) VALUES (10,
50);
INSERT 0 1 */

-- Reporta aquellas cuentas cuyo balance sea mayor a 2000.
-- SELECT * FROM cuentas WHERE balance > 2000;
select * from cuentas where balance >= 2000;

/* numero_cuenta | balance | activa
---------------+---------+--------
             2 |    4000 | t
             3 |    5000 |
             4 |    3000 |
             6 |    6000 |
             8 |    4500 |
             9 |   12000 |
            10 |    2500 |
            12 |    7000 |
            13 |    9500 |
(9 filas) */

-- Reporta cuántas tienen un balance inferior a 1000.
--SELECT COUNT(*) AS cuentas_con_balance_inferior_a_1000 FROM cuentas WHERE balance < 1000;
select * from cuentas where balance <= 1000;

/*  numero_cuenta | balance | activa
---------------+---------+--------
             1 |       0 | f
             7 |     800 |
            11 |     300 |
(3 filas) */

-- Reporta el promedio total de las cuentas registradas según su balance.
-- SELECT AVG(balance) AS promedio_total_de_cuentas FROM cuentas;
select avg(balance) from cuentas;


-- Reporta el promedio de cuentas cuyo balance sea mayor o igual a 10000.
select avg(balance) from cuentas where balance >= 2000;

        avg
-------------------
 5944.444444444444
(1 fila)



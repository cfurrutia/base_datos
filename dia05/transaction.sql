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



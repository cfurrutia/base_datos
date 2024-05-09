create database desafio2_carlos_urrutia_123; 
\c desafio2_carlos_urrutia_123;  

CREATE TABLE IF NOT EXISTS INSCRITOS(cantidad INT, fecha DATE, fuente VARCHAR);

INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );


-- 1. ¿Cuántos registros hay?  en total hay 16 registros 
select * from INSCRITOS;

/*cantidad |   fecha    | fuente
----------+------------+--------
       44 | 2021-01-01 | Blog
       56 | 2021-01-01 | Página
       39 | 2021-02-01 | Blog
       81 | 2021-02-01 | Página
       12 | 2021-03-01 | Blog
       91 | 2021-03-01 | Página
       48 | 2021-04-01 | Blog
       45 | 2021-04-01 | Página
       55 | 2021-05-01 | Blog
       33 | 2021-05-01 | Página
       18 | 2021-06-01 | Blog
       12 | 2021-06-01 | Página
       34 | 2021-07-01 | Blog
       24 | 2021-07-01 | Página
       83 | 2021-08-01 | Blog
       99 | 2021-08-01 | Página
(16 filas) */

SELECT COUNT(*) AS total_registros FROM INSCRITOS;

/* total_registros
-----------------
              16
(1 fila)  */


-- 2. ¿Cuántos inscritos hay en total?

SELECT fuente, SUM(cantidad) AS total_inscritos FROM INSCRITOS GROUP BY fuente;

/* fuente | total_inscritos
--------+-----------------
 Página |             441
 Blog   |             333
(2 filas) */

SELECT SUM(cantidad) AS total_inscritos FROM INSCRITOS;

/* total_inscritos
-----------------
             774  */

SELECT SUM(cantidad) FROM inscritos;

/* sum
-----
 774
(1 fila)*/             

/* 3. ¿Cuál o cuáles son los registros de mayor antigüedad?
 HINT: ocupar subconsultas */

SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) AS fecha_mas_antigua FROM inscritos);


/* cantidad |   fecha    | fuente
----------+------------+--------
       44 | 2021-01-01 | Blog
       56 | 2021-01-01 | Página
(2 filas)*/

SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) FROM inscritos);

 cantidad |   fecha    | fuente
----------+------------+--------
       44 | 2021-01-01 | Blog
       56 | 2021-01-01 | Página
(2 filas)


-- 4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)

SELECT fecha, SUM(cantidad) AS inscritos_por_dia FROM inscritos GROUP BY fecha ORDER BY fecha ASC;

/*   fecha    | inscritos_por_dia
------------+-------------------
 2021-01-01 |               100
 2021-02-01 |               120
 2021-03-01 |               103
 2021-04-01 |                93
 2021-05-01 |                88
 2021-06-01 |                30
 2021-07-01 |                58
 2021-08-01 |               182
(8 filas) */

SELECT fecha, SUM(cantidad) AS inscritos_por_dia FROM inscritos GROUP BY fecha;

   fecha    | inscritos_por_dia
------------+-------------------
 2021-02-01 |               120
 2021-08-01 |               182
 2021-05-01 |                88
 2021-04-01 |                93
 2021-06-01 |                30
 2021-07-01 |                58
 2021-03-01 |               103
 2021-01-01 |               100
(8 filas)


-- 5. ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?

SELECT fecha, SUM(cantidad) AS inscritos_por_dia FROM inscritos GROUP BY fecha ORDER BY inscritos_por_dia DESC LIMIT 1;

/* fecha    | inscritos_por_dia
------------+-------------------
 2021-08-01 |               182
(1 fila) */

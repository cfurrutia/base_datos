--esto es un comentario 

SELECT * FROM demo;
-- solo obtener la columna name
SELECT NAME FROM demo;
SELECT ID FROM demo;
SELECT HINT FROM demo;
-- mezclar varias columnas
SELECT NAME, HINT FROM demo;
SELECT HINT, name from demo;

-- CLAUSUSLA WHERE --> filtra, condicionademo
--where con or
SELECT * FROM demo WHERE ID = 5 OR id = 8;
SELECT * FROM demo WHERE HINT = '300';
--where con and AND
SELECT * FROM demo WHERE ID < 5 AND id >= 2;
-- clausula limit
SELECT * FROM demo LIMIT 3;
-- clausula where y limit
SELECT * FROM demo WHERE id < 6 LIMIT 3;
-- clausula order by
SELECT * from demo ORDER by id DESC;
SELECT * from demo ORDER by NAME DESC;
SELECT * from demo ORDER by HINT ASC;

SELECT HINT,NAME FROM demo ORDER by 1 ASC;


-- 5432  Admin1234

-- psql -U nombreDeUsuario

-- sudo -u postgres psql



CREATE DATABASE "Carlos"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;















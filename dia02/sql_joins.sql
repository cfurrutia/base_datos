-- INNER JOIN
/* esta es la base:
SELECT *
FROM TablaA A      -- SE RECOMIENDA AGREGAR COMO TablaA AQUELLA TABLA QUE TENGA LA PK
INNER JOIN TablaB B
ON A.KEY = B.KEY;
*/

--JOIN saca información donde se juntan las tablas, en la intersección de datos.

select * from productos;
select * from pedidos_detalle;

-- a las tablas se le asignan los alias de A y B
-- con el * le pregunto por ambas tablas = A.*, B.*
SELECT  * -- A.*, B.* con .* le pido que solo me muestre la info de la tabla solicitada
FROM productos A
INNER JOIN pedidos_detalle B
ON A.id_producto = B.id_producto;
--- aqui muestra la union de las 2 tablas

--Aquí le puedo pedir informacion filtrada de cada tabla
--le estamos pidiendo que traiga solo lo de la intersección
SELECT  A.nombre, A.precio, B.id_pedido, B.cantidad
FROM productos A
INNER JOIN pedidos_detalle B
ON A.id_producto = B.id_producto;


INSERT INTO productos (id_producto, nombre, precio)
VALUES (14, 'Producto 14', 25.74);
--el id de producto es distinto al pedido_detalle, aunque compartan el mismo numero

INSERT INTO productos (id_producto, nombre, precio)
VALUES (15, 'Producto 15', 50.74);


-- LEFT JOIN
/*
SELECT *
FROM TABLAA A      -- SE RECOMIENDA AGREGAR COMO TABLAA AQUELLA TABLA QUE TENGA LA PK
LEFT JOIN TABLAB B
ON A.KEY = B.KEY
WHERE B.KEY IS NULL
;
*/

SELECT *
FROM productos A     
LEFT JOIN pedidos_detalle B
ON A.id_producto = B.id_producto
WHERE B.id_producto IS NULL
;

-- RIGHT JOIN
/*
SELECT *
FROM TABLAA A      -- SE RECOMIENDA AGREGAR COMO TABLAA AQUELLA TABLA QUE TENGA LA PK
RIGHT JOIN TABLAB B
ON A.KEY = B.KEY
WHERE A.KEY IS NULL
;
*/

SELECT *
FROM productos A     
RIGHT JOIN pedidos_detalle B
ON A.id_producto = B.id_producto
WHERE A.id_producto IS NULL
;
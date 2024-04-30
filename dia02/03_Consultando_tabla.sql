-- Crear la tabla con el nombre 'PRODUCTOS'
CREATE TABLE PRODUCTOS (
    id INT,
    nombre_producto VARCHAR(50),
    precio INT,
    en_stock BOOLEAN,
    categoria VARCHAR(50)
);

-- Insertar datos en la tabla 'PRODUCTOS'
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (1, 'Cápsulas para Hornear', 298, TRUE, 'Panadería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (2, 'Mollejas de Ternera', 6552, FALSE, 'Carnicería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (3, 'Sistema Automático de Jabón Oneshot', 6667, TRUE, 'Higiene');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (4, 'Galletas de la Fortuna', 882, TRUE, 'Panadería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (5, 'Aceite de Trufa Blanca', 5900, FALSE, 'Gourmet');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (6, 'Aperitivo de Salmón Ahumado con Eneldo', 1263, TRUE, 'Aperitivos');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (7, 'Baguette Pequeña', 5366, FALSE, 'Panadería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (8, 'Copas de Licor de Chocolate con Papel de Aluminio', 2797, FALSE, 'Gourmet');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (9, 'Jugo de Manzana, 341 Ml', 3654, FALSE, 'Bebidas');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (10, 'Mero Fresco', 1266, FALSE, 'Pescadería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (11, 'Leche Condensada', 5998, FALSE, 'Lácteos');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (12, 'Pajitas - Regulares', 9688, FALSE, 'Utensilios de Bebida');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (13, 'Cerveza - Alexander Kieths, Pale Ale', 4173, FALSE, 'Bebidas Alcohólicas');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (14, 'Arroz - Basmati', 1036, TRUE, 'Abarrotes');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (15, 'Arándanos Congelados', 2462, TRUE, 'Congelados');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (16, 'Ecolab - Limpiador de Cal', 8092, FALSE, 'Limpieza');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (17, 'Vermut - Dulce, Cinzano', 6639, FALSE, 'Bebidas Alcohólicas');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (18, 'Kohlrabi', 7868, FALSE, 'Verduras');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (19, 'Champiñón - Morilla Congelada', 7208, FALSE, 'Congelados');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (20, 'Sirope - Monin, Amaretto', 5486, FALSE, 'Bebidas');

-- Crear la tabla de ventas
CREATE TABLE VENTAS (
    id_venta INT,
    fecha DATE,
    producto VARCHAR(50),
    cantidad INT,
    precio_unitario INT
);

-- Insertar datos en la tabla 'VENTAS'
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (1, '2024-01-01', 'Camiseta', 3, 150);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (2, '2024-01-03', 'Pantalón', 2, 300);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (3, '2024-01-04', 'Sudadera', 1, 250);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (4, '2024-01-04', 'Zapatillas', 1, 500);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (5, '2024-01-05', 'Camiseta', 2, 150);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (6, '2024-01-07', 'Gorra', 4, 100);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (7, '2024-01-08', 'Bufanda', 3, 120);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (8, '2024-01-09', 'Pantalón', 1, 300);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (9, '2024-01-10', 'Camiseta', 1, 150);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (10, '2024-01-11', 'Sudadera', 2, 250);

-- cargando dataset
SELECT * FROM productos LIMIT 10;

--funciones 
SELECT * FROM productos order by LENGTH(nombre_producto);

-- cual es el tamaño, cual es la cantidad 
SELECT *, LENGTH(nombre_producto) FROM productos order by LENGTH(nombre_producto);

SELECT *, LEFT(categoria,3) AS codigo from productos;  

-- funciones de agregado
-- suma
select SUM(precio) FROM PRODUCTOS;

-- FUNCIOENS DE AGREGADO

SELECT SUM(Columna) FROM TABLA;  -- EJEMPLO
SELECT AVG (Columna) FROM TABLA;  -- EJEMPLO
SELECT MAX(Columna) FROM TABLA;  -- EJEMPLO
SELECT MIN(Columna) FROM TABLA;  -- EJEMPLO
SELECT COUNT(*) FROM TABLA;  -- EJEMPLO

-- CUENTA LA CANTIDAD DE PRODUCTOS CON STOCK
(PISTA : puedes combinar, las funciones de agregado con where)
select COUNT(en_stock) from PRODUCTOS where en_stock = 't';

- 1 cuenta la cantidad de precio sobre 7000
select COUNT(precio) from productos where precio > 7000;

- 2 calcula el promedio de los productos que tienen stock
select avg(precio) from productos where en_stock = 't';

-- Group by 

SELECT max(precio) from productos GROUP BY categoria;

-- Podemos mostrar la categoría junto al precio.
SELECT categoria, max(precio) from productos GROUP BY categoria;

-- nombre_producto es un campo no agrupado, al intentar esta consulta obtendremos 
-- el error: 
-- Regla importante !!
-- ERROR: column "productos.nombre_producto" must appear in 
-- the GROUP BY clause or be used in an aggregate function
-- ERROR:  la columna «productos.nombre_producto» debe aparecer en la cláusula GROUP BY o ser usada en una función de agregación
-- LÍNEA 1: SELECT nombre_producto, max(precio) from productos GROUP BY ...

SELECT nombre_producto, max(precio) from productos GROUP BY categoria;

1. ¿Cuál es el promedio de ventas?
select * from ventas;
select avg(precio_unitario) from ventas;

select *,(cantidad * precio_unitario) AS venta from ventas;
select avg(cantidad * precio_unitario) from ventas;

2. ¿Cuál es el promedio de ventas por producto?
select * from ventas;
select producto from ventas Group by producto;
select producto, avg(cantidad * precio_unitario ) from ventas Group by producto;

3. ¿Cuál es el promedio de ventas por producto después del '2024-01-05'?
select producto, avg(cantidad * precio_unitario ) from ventas where fecha > '2024-01-05' Group by producto;






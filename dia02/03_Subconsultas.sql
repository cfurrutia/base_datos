CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(255),
    precio DECIMAL(10, 2)
);
    -- Otros campos según tus necesidades


-- Inserción de datos en la tabla 'productos'
INSERT INTO productos (id_producto, nombre, precio)
VALUES
    (1, 'Producto A', 20.99),
    (2, 'Producto B', 15.50),
    (3, 'Producto C', 25.75),
    (4, 'Producto D', 18.50),
    (5, 'Producto E', 30.25),
    (6, 'Producto F', 12.75),
    (7, 'Producto G', 22.99),
    (8, 'Producto H', 15.00),
    (9, 'Producto I', 28.50),
    (10, 'Producto J', 19.99),
    (11, 'Producto K', 10.50),
    (12, 'Producto L', 24.75),
    (13, 'Producto M', 16.50);

-- Creación de la tabla 'pedidos_detalle'
CREATE TABLE pedidos_detalle (
    id_pedido_detalle INT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT
);
    -- Otros campos según tus necesidades


-- Inserción de datos en la tabla 'pedidos_detalle'
INSERT INTO pedidos_detalle (id_pedido_detalle, id_pedido, id_producto, cantidad)
VALUES
    (1, 101, 1, 3),
    (2, 101, 2, 2),
    (3, 102, 1, 1),
    (4, 103, 3, 4),
    (5, 104, 4, 2),
    (6, 104, 5, 1),
    (7, 105, 6, 3),
    (8, 105, 7, 2),
    (9, 106, 8, 1),
    (10, 107, 9, 4),
    (11, 107, 10, 2),
    (12, 108, 11, 3),
    (13, 109, 12, 2),
    (14, 110, 13, 1);

--SUBCONSULTAS
select * from productos;
select * from pedidos_detalle;


--1) Obtener todos los productos que el precio este sobre el precio promedio
--Primero hay que sacar el promedio de todos los productos
select AVG(precio) from productos;-- 20.1515384615384615

--Esta forma no es practica pq el promedio puede cambiar si se modifica el valor de algun producto
select * from productos where precio > 20.1515384615384615;

--Por eso se recomienda trabajar con subconsultas y no con valor estático:
select * from productos where precio > (select AVG(precio) from productos);


--2) Encontrar los productos que se han vendido más de una vez
select * from productos;
select * from pedidos_detalle;

---agrupar por producto
select id_producto, count(id_producto) from pedidos_detalle group by id_producto;
--aqui nos muestra todos los productos vendidos y solo hay uno que se vendió 2 veces

--aqui sigue mostrando la cantidad igua a 1
select id_producto, count(id_producto) as cantidad
from pedidos_detalle 
where cantidad > 1
group by id_producto; ---no funciona pq no se puede agregar una función en el where

--con esto si funciona pero se debe hacer de otra forma(from)
select id_producto, count(id_producto) as cantidad
from pedidos_detalle 
group by id_producto;


---Consulta variante con la subconsulta usando FROM
--con esto tratamos el resultado correcto como una tabla temporal
--dentro del parentesis del from se le agrega la query anterior, pero sin el ;
select *
from (
    select id_producto, count(id_producto) as cant
    from pedidos_detalle 
    group by id_producto
) as temporal
where cant > 1
;
-- le asignamos un alias "temporal" y ejecutamos
-- y le pedimos que solo filtre el item con 2 cantidades usando where

select * 
from productos
where id_producto = (
    select id_producto
    from (
        select id_producto, count(id_producto) as cant
        from pedidos_detalle 
        group by id_producto
    ) as temporal
    where cant > 1
);
-- Aquí nos entrega el detalle del producto más vendido
-- idproducto:    1 | nombre: Producto A |  precio: 20.99
-- Aquí se hicieron 3 consultas


--El IN busca los numeros entregados y entrega SOLO los que encuentra
select * 
from productos
where id_producto IN (20,1,55,3 );
-- me muestra solo 2 productos, uno con id 1 y otro de id 3.
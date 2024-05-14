CREATE TABLE productos (
  id serial PRIMARY KEY,
  nombre varchar(255) NOT NULL,
  precio numeric(10,2) NOT NULL,
  sku text
);

INSERT INTO productos (nombre, precio, sku)
VALUES
  ('Televisor 50 pulgadas', 1500.00, NULL),
  ('Celular de alta gama', 1000.00, NULL),
  ('Laptop de última generación', 2000.00, NULL),
  ('Nevera con congelador', 500.00, NULL),
  ('Lavadora automática', 300.00, NULL),
  ('Cocina a gas', 400.00, NULL),
  ('Horno microondas', 250.00, NULL),
  ('Juego de ollas', 100.00, NULL),
  ('Set de cubiertos', 50.00, NULL),
  ('Cafetera eléctrica', 75.00, NULL),
  ('Tostadora', 50.00, NULL),
  ('Plancha de vapor', 100.00, NULL),
  ('Secadora de ropa', 200.00, NULL),
  ('Aspiradora', 150.00, NULL),
  ('Robot aspirador', 300.00, NULL),
  ('Silla de oficina', 200.00, NULL),
  ('Mesa de escritorio', 150.00, NULL),
  ('Escritorio para computadora', 250.00, NULL),
  ('Sillón para sala', 300.00, NULL),
  ('Sofá cama', 400.00, NULL),
  ('Mesa de centro', 200.00, NULL),
  ('Silla para comedor', 150.00, NULL),
  ('Mesa para comedor', 250.00, NULL),
  ('Cama matrimonial', 400.00, NULL),
  ('Cabecera para cama', 250.00, NULL),
  ('Mesa de noche', 150.00, NULL),
  ('Armario ropero', 300.00, NULL),
  ('Espejo para baño', 200.00, NULL),
  ('Inodoro', 150.00, NULL),
  ('Lavabo', 250.00, NULL),
  ('Grifería para baño', 100.00, NULL),
  ('Ducha', 75.00, NULL),
  ('Bañera', 50.00, NULL),
  ('Cocina de inducción', 400.00, NULL),
  ('Campana extractora', 300.00, NULL),
  ('Microondas', 250.00, NULL),
  ('Lavavajillas', 1000.00, NULL),
  ('Lavadora secadora', 2000.00, NULL);

-- modificamos la tabla y para los valores nulos del sku le asignamos el valor de "Dato no ingresado"
-- Este cliente nos solicita que modifiquemos la tabla y para los valores nulos del SKU
-- le asignemos el valor de “Dato no ingresado”.
UPDATE productos SET sku = COALESCE(sku, 'Dato no ingresado');

/*Por último, el cliente nos solicita que no quiere que sigan ingresando datos con el
SKU en nulo. En este sentido nos da la libertad de modificar la base de datos para
impedir dicho inconveniente*/
ALTER TABLE productos ALTER COLUMN sku SET NOT NULL;

/*
select * from productos;  
 id |           nombre            | precio  |        sku
----+-----------------------------+---------+-------------------
  1 | Televisor 50 pulgadas       | 1500.00 | Dato no ingresado
  2 | Celular de alta gama        | 1000.00 | Dato no ingresado
  3 | Laptop de última generación | 2000.00 | Dato no ingresado
  4 | Nevera con congelador       |  500.00 | Dato no ingresado
  5 | Lavadora automática         |  300.00 | Dato no ingresado
  6 | Cocina a gas                |  400.00 | Dato no ingresado
  7 | Horno microondas            |  250.00 | Dato no ingresado
  8 | Juego de ollas              |  100.00 | Dato no ingresado
  9 | Set de cubiertos            |   50.00 | Dato no ingresado
 10 | Cafetera eléctrica          |   75.00 | Dato no ingresado
 11 | Tostadora                   |   50.00 | Dato no ingresado
 12 | Plancha de vapor            |  100.00 | Dato no ingresado
 13 | Secadora de ropa            |  200.00 | Dato no ingresado
 14 | Aspiradora                  |  150.00 | Dato no ingresado
 15 | Robot aspirador             |  300.00 | Dato no ingresado
 16 | Silla de oficina            |  200.00 | Dato no ingresado
 17 | Mesa de escritorio          |  150.00 | Dato no ingresado
 18 | Escritorio para computadora |  250.00 | Dato no ingresado
 19 | Sillón para sala            |  300.00 | Dato no ingresado
 20 | Sofá cama                   |  400.00 | Dato no ingresado
 21 | Mesa de centro              |  200.00 | Dato no ingresado
 22 | Silla para comedor          |  150.00 | Dato no ingresado
 23 | Mesa para comedor           |  250.00 | Dato no ingresado
 24 | Cama matrimonial            |  400.00 | Dato no ingresado
 25 | Cabecera para cama          |  250.00 | Dato no ingresado
 26 | Mesa de noche               |  150.00 | Dato no ingresado
 27 | Armario ropero              |  300.00 | Dato no ingresado
 28 | Espejo para baño            |  200.00 | Dato no ingresado
 29 | Inodoro                     |  150.00 | Dato no ingresado
 30 | Lavabo                      |  250.00 | Dato no ingresado
 31 | Grifería para baño          |  100.00 | Dato no ingresado
 32 | Ducha                       |   75.00 | Dato no ingresado
 33 | Bañera                      |   50.00 | Dato no ingresado
 34 | Cocina de inducción         |  400.00 | Dato no ingresado
 35 | Campana extractora          |  300.00 | Dato no ingresado
 36 | Microondas                  |  250.00 | Dato no ingresado
 37 | Lavavajillas                | 1000.00 | Dato no ingresado
 38 | Lavadora secadora           | 2000.00 | Dato no ingresado
(38 filas) */
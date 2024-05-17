DROP database IF EXISTS productos_feria;

create database productos_feria;
\c productos_feria;

/*con el paso de borrar la bd no ahorramos esto
drop table IF EXISTS compras;
drop table IF EXISTS clientes;
drop table IF EXISTS productos;*/

create table clientes(
    cliente_id serial primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    direccion varchar(250) not null,
    dni varchar(50) not null unique
);

create table productos(
    producto_id serial primary key,
    codigo varchar(250) not null unique
);

create table compras(
    compra_id serial primary key,
    cliente_id int,
    producto_id int,
    foreign key(cliente_id) references clientes(cliente_id),
    foreign key(producto_id) references productos(producto_id) 
);

----INSERT
INSERT INTO public.clientes (nombre,apellido,direccion,dni)
VALUES ('JULIO','PALMA’,’DIRECCION 1','12345678K');


INSERT INTO public.productos (codigo) VALUES ('PRODUCTO');
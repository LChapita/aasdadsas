create database bd_segundo_parcial_2021;
use bd_segundo_parcial_2021;

create table cliente(
	id_cliente int primary key not null auto_increment ,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    dni varchar(8) not null,
    telefono varchar(10) not null,
    direccion varchar(100) not null
);

create table marca(
	id_marca int auto_increment,
	nombre varchar(100) not null unique,
	constraint pk_id_marca primary key (id_marca)
);

create table auto(
	id_auto  int not null auto_increment unique,
	id_marca int not null,
    color varchar(100) not null,
	matricula varchar(100) not null unique,
    modelo int not null,
    precioxhora double not null,
    constraint pk_auto primary key (id_auto),
	constraint fk_id_marca foreign key (id_marca) references marca(id_marca)
);

create table reserva(
	id_reserva int not null auto_increment,
	id_cliente int not null,
    id_clienteAval int,
	precioTotal int,
    fechaInicio date,
    fechaFin date,
    constraint pk_reserva primary key (id_reserva),
	constraint fk_id_cliente foreign key (id_cliente) references cliente(id_cliente),
    constraint fk_id_cliente_aval foreign key (id_clienteAval) references cliente(id_cliente)
);

create table detalleReserva(
	id_auto int not null unique,
	id_detalleReserva int not null auto_increment,
    id_reserva int not null unique,
	litros double,
    constraint pk_detalleReserva primary key (id_detalleReserva),
	constraint fk_id_auto foreign key (id_auto) references auto(id_auto),
    constraint fk_id_reserva foreign key (id_reserva) references reserva(id_reserva)
);

insert into marca (nombre) values ("BMW"),("Fiat"),("Ford Fiesta"),("Toyota"),("Renault");

insert into cliente (nombre,apellido,direccion,dni,telefono) 
	values ('nombre 1','apellido 1','direccion 1', '12345678', '1234567899'),
			('nombre 2','apellido 2','direccion 2', '12345671', '1334567899'),
			('nombre 3','apellido 3','direccion 3', '12345672', '1434567899'),
			('nombre 4','apellido 4','direccion 4', '12345673', '1534567899'),
			('nombre 5','apellido 5','direccion 5', '12345674', '1634567899'),
			('nombre 6','apellido 6','direccion 6', '12345675', '1734567899');

insert into auto (id_marca, matricula, modelo, color, precioxhora) 
	values (1,'matricula 123',2020, 'rojo', 800),
			(2,'matricula 13',2020, 'rojo', 1200),
			(3,'matricula 1323',2020, 'azul', 1100),
            (3,'matricula 1423',2020, 'violeta', 1800),
            (3,'matricula 1253',2019, 'rosa', 1700),
            (3,'matricula 1263',2021, 'magenta', 500),
            (3,'matricula 1273',2021, 'amarillo', 400),
            (3,'matricula 1283',2021, 'naranja', 300),
            (4,'matricula 1293',2020, 'verde', 200),
            (5,'matricula 1123',2020, 'gris', 1030),
            (5,'matricula 2123',2020, 'negro', 1500),
            (4,'matricula 3123',2020, 'blanco', 1000);
            
insert into reserva (id_cliente, id_clienteAval, precioTotal, fechaInicio, fechaFin)
	values (1,2,100,'2020-01-02','2020-02-03'),
			(2,1,500,'2020-01-02','2020-02-03'),
            (3,null,400,'2020-01-02','2020-02-03'),
            (4,2,300,'2020-01-02','2020-02-03'),
            (5,2,200,'2020-01-02','2020-02-03'),
            (6,null,2200,'2020-01-02','2020-02-03'),
            (2,null,1080,'2020-01-02','2020-02-03'),
            (3,2,1500,'2020-01-02','2020-02-03'),
            (3,2,2500,'2020-01-02','2020-02-03'),
            (3,2,3500,'2020-01-02','2020-02-03'),
            (3,null,4500,'2020-01-02','2020-02-03'),
            (4,2,1600,'2020-01-02','2020-02-03');
            

insert into detalleReserva (id_auto,id_reserva,litros)
	values (13,1,1000),
			(2,2,200),
            (3,3,200),
            (4,4,300),
            (5,5,300),
            (6,6,400),
            (7,7,100),
            (8,8,100),
            (9,9,500),
            (10,10,10),
            (11,11,50),
            (12,12,150);

create table pieza(
	id_pieza int not null auto_increment,
    nombre varchar(100) not null,
    constraint pk_id_pieza primary key (id_pieza)
);

create table proveedor(
	id_Proveedor int auto_increment,
    nombre varchar(100) not null unique,
    constraint pk_id_proveedor primary key(id_Proveedor)
);

create table suministra(
	id_suministra int not null auto_increment,
	id_pieza int,
    id_proveedor int,
    precio int,
    constraint pkSuministra primary key(id_suministra,id_pieza,id_proveedor),
    constraint fk_id_pieza foreign key (id_pieza) references pieza(id_pieza),
    constraint fk_id_Proveedor foreign key (id_Proveedor) references proveedor(id_Proveedor)
);

drop table pieza;
drop table suministra;
drop table proveedor;
/*1. Crear un procedimiento almacenado para dar de alta una nueva pieza. 
Se debe agregar la pieza y el precio de la misma. Realice la llamada al procedimiento.*/

/*
drop procedure if exists Almacenado;

delimiter $$
create procedure Almacenado(in nombre varchar(100),in precio int)
begin
 /*aca se hace el procedimiento
 end;
$$
*/
##drop procedure if exists altaPieza;
/*
delimiter $$
create procedure altaPieza (nombre varchar (100))
begin
    insert into pieza (nombre) values (nombre);
end; 
$$
*/

##call altaPieza ('sp_alta_pieza_test');

##select * from pieza;

insert into proveedor(nombre)value('Pedro Gonzales');
insert into proveedor(nombre)value('Juan Gonzales de Godoy');
insert into proveedor(nombre)value('Carlos Gonzales');
insert into proveedor(nombre)value('Guillermo Gonzales Pereira');
insert into proveedor(nombre)value('Mauricio Gonzales');
insert into proveedor(nombre)value('Pablo Gonzales Acuña');

/*2. Mostrar todos los proveedores que tengan en el nombre la palabra “Gonzalez”*/
select * from proveedor where nombre like '%Gonzales';


/*3. Mostrar el nombre del proveedor, nombre de la pieza y precio de todas las piezas. Mostrar todos los  proveedores, si no suministran piezas, mostrar en su lugar “sin piezas”*/

insert into pieza (nombre) values ('Llantas direccionales');
insert into pieza (nombre) values ('Paragolpes tracero');
insert into pieza (nombre) values ('volante de marca frod');
select * from pieza;

insert into suministra(id_suministra,id_pieza,id_proveedor,precio)value(1,7,2,2000);
insert into suministra(id_suministra,id_pieza,id_proveedor,precio)value(2,8,4,3000);
insert into suministra(id_suministra,id_pieza,id_proveedor,precio)value(3,9,6,4000);

insert into suministra(id_suministra,id_pieza,id_proveedor,precio)value(3,1,6,8000);
insert into suministra(id_suministra,id_pieza,id_proveedor,precio)value(3,2,6,1000);
insert into suministra(id_pieza,id_proveedor)value(4,1);
insert into suministra(id_pieza,id_proveedor)value(5,3);
insert into suministra(id_pieza,id_proveedor)value(6,5);

select * from suministra;


select r.nombre,ifnull(p.nombre,'sin piezas'),precio from suministra s
inner join proveedor p
on s.id_proveedor=p.id_Proveedor
inner join pieza r
on r.id_pieza=s.id_pieza; 

select p.nombre, pi.nombre, s.precio
from suministra s
join pieza pi
on pi.id_pieza = s.id_pieza
join proveedor p
on p.id_Proveedor = s.id_proveedor
where s.precio is not null;

/*4. Mostrar las piezas más caras de cada proveedor. (sin subconsultas) */

select pi.nombre, max(s.precio)
from suministra s
join pieza pi
on pi.id_pieza = s.id_pieza
join proveedor p
on p.id_Proveedor = s.id_proveedor
where s.precio is not null
group by s.precio desc;

/*5. Mostrar la cantidad de piezas suministradas por cada proveedor, pero solamente de aquellos que suministran más de 100 piezas. (sin subconsultas) */
select p.nombre, count(s.id_pieza)
from suministra s
join proveedor p
on p.id_proveedor = s.id_proveedor
group by p.id_proveedor
having count(s.id_pieza) > 2
;
/*6. Mostrar el nombre de los proveedores que suministran piezas con precio mayor a la media de todas las piezas 
(con subconsultas).*/

select p.nombre 
from suministra s
inner join proveedor p
on p.id_Proveedor=s.id_proveedor
where s.precio>(select avg(precio) from suministra)
group by p.id_proveedor;

select p.nombre
from suministra s
join proveedor p
on p.id_Proveedor = s.id_proveedor
where s.precio > (select avg(sum.precio) from suministra sum)
group by p.id_proveedor











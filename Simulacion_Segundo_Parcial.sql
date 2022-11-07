create database  simulacion_segundo_parcial;
use simulacion_segundo_parcial;



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
            
            
insert into detalleReserva (id_auto,id_reserva,litros)
values (1,13,2000);
			
insert into auto (id_marca, matricula, modelo, color, precioxhora) 
values (2,'789',2022, 'blanco', 2000);       
            
insert into auto (id_marca, matricula, modelo, color, precioxhora) 
values (1,'777',2023, 'Azul Electrico', 5000);       
 
 
/*1. Realizar las siguientes consultas en SQL:*/
/* a. Mostrar la la cantidad de reservas (segun fecha de inicio) que tuvo un auto, en los trimestres
del año 2022 con el siguiente formato:
Matricula 1erSemestre 2doSemestre
AC00BB 10 5
AB99ZZ 23 2
*/
select a.matricula,
	count(case when r.fechaInicio between '20200101' and '20200630' then 1 end) as Primer_semestre,
    count(case when r.fechaInicio between '20200601' and '20201231' then 1 end) as Segundo_semestre
    from reserva r
    inner join detallereserva d
    on d.id_reserva=r.id_reserva
    inner join auto a
    on a.id_auto=d.id_auto
    where year(r.fechaInicio)=2020
    group by a.matricula
;
select a.matricula,
Count(case when r.fechainicio between '20200101' and '20200630' then 1  end) as '1erSemestre',
Count(case when r.fechainicio between '20200601' and '20201231' then 1  end) as '2doSemestre'
from reserva r
join detallereserva dr on dr.id_reserva = r.id_reserva
join auto a on a.id_auto=dr.id_auto
where year(r.fechainicio) =2020
group by a.matricula;
/*b. Mostrar apellido y nombre de clientes y total abonado de reservas realizadas. 
Mostrar solamente aquellos que abonaron un total superior a 100.000$*/
select c.apellido, c.nombre,r.precioTotal  from cliente c
inner join reserva r on c.id_cliente=r.id_cliente
group by c.apellido
having r.precioTotal>=500
;
/*
c. Listar id_reserva, fechaInicio, apellido y nombre del cliente y marca y modelo de los autos de
las reservas realizadas con los autos más caros.*/
select r.id_reserva,r.fechaInicio,c.apellido,c.nombre,m.nombre,a.modelo,max(a.precioxhora) from reserva r
left join cliente c
on c.id_cliente=r.id_cliente
left join detallereserva d
on d.id_reserva=r.id_reserva
left join auto a
on a.id_auto=d.id_auto
join marca m
on m.id_marca=a.id_marca
group by a.precioxhora desc
;
/*2. Crear un procedimiento almacenado que permita eliminar autos 
de una marca pasada por parámetro,tener en cuenta que se eliminen autos que no hayan sido reservados.*/
/*
drop procedure if exists deleteAuto;

delimiter $$
create procedure deleteAuto(in marca varchar(50))
begin
delete a from auto a
left join detallereserva d
 on d.id_auto=a.id_auto
 left join marca m
 on m.id_marca=a.id_marca
where d.id_auto is null and  m.nombre like marca;
end
$$

*/
##select * from auto;
##call deleteAuto('BMW');






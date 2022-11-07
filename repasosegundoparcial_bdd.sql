create database repasoSegundoParcial_bdd;
use repasoSegundoParcial_bdd;


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
            

insert into reserva (id_cliente, id_clienteAval, precioTotal, fechaInicio, fechaFin)
	values (1,2,100,'2021-01-02','2020-02-03'),
			(2,1,500,'2021-01-02','2020-02-03'),
            (3,null,400,'2021-01-02','2020-02-03'),
            (4,2,300,'2021-01-02','2020-02-03'),
            (5,2,200,'2021-01-02','2020-02-03'),
            (6,null,2200,'2021-01-02','2020-02-03'),
            (2,null,1080,'2021-01-02','2020-02-03'),
            (3,2,1500,'2021-01-02','2020-02-03'),
            (3,2,2500,'2021-01-02','2020-02-03'),
            (3,2,3500,'2021-01-02','2020-02-03'),
            (3,null,4500,'2021-01-02','2020-02-03'),
            (4,2,1600,'2021-01-02','2020-02-03');
            
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
###
/*1. Realizar las siguientes consultas en SQL:*/
/*a. Listar Apellido, nombre , fecha Inicio, Fecha Fin y matrícula de todos los
clientes que realizaron alguna reserva en el año 2020 de autos de la marca
“Ford Fiesta”. (Sin Subconsulta)*/
select c.apellido,c.nombre,r.fechaInicio,r.fechaFin,a.matricula,m.nombre from cliente c
inner join reserva r
on r.id_cliente=c.id_cliente
inner join detallereserva d
on d.id_reserva=r.id_reserva
inner join auto a
on a.id_auto=d.id_auto
inner join marca m
on m.id_marca=a.id_marca
where year(r.fechaInicio)='2020' and m.nombre like 'BMW'
;

/*b. Listar marca, modelo y matrícula de autos que nunca fueron reservados. (Sin Subconsulta)*/

    
select m.nombre,a.modelo,a.matricula,a.id_auto from auto a
left join marca m
on m.id_marca=a.id_marca
left join detallereserva d
on d.id_auto=a.id_auto
where d.id_auto is null
;
/*c. Mostrar la cantidad de autos reservados por marca y modelo de aquellos
autos que superaron los 200 litros en cada reserva. (Sin Subconsulta)
Marca Modelo cantidad de autos
Ford Fiesta 2019 10
Fiat Palio 2020 5
Fiat Palio 2021 8
*/
select m.nombre,a.modelo,count(d.id_detalleReserva),
	case
		when litros>200 then 'los litros son mayor a 200'
        when litros=200 then 'los litros son igual a 200'
        when litros<200 then 'los litros son menor a 200'
		else 'no hay litros'
	end as 'cuantos litros'
from auto a
inner join detallereserva d on d.id_auto=a.id_auto
inner join marca m on m.id_marca=a.id_marca
group by m.nombre;


/*d. Mostrar el nombre, apellido de clientes que abonaron un precio total superior
a la media de todas las reservas realizadas con un cliente aval asignado
(distinto a null). Mostrar también el nombre y apellido del cliente aval.*/

select c.nombre,c.apellido,sum(r.precioTotal) from cliente c
inner join reserva r
on c.id_cliente=r.id_cliente
group by c.nombre
having sum(r.precioTotal)>(select avg(precioTotal) from cliente c inner join reserva r on r.id_cliente=c.id_cliente);


select c.*,r.* from reserva r
inner join cliente c
on c.id_cliente=r.id_cliente;

/*2. Crear un procedimiento almacenado que permita actualizar el precio x hora de los
autos de una marca específica. Pasar por parámetro el id de la marca y el porcentaje
a incrementar.*/
/*
drop procedure if exists actualizar;
delimiter $$
create procedure actualizar(in id_marca int,in porsentaje int)
begin
	update auto a
	set a.precioxhora = a.precioxhora+(porsentaje/100)*a.precioxhora
	where a.id_marca=id_marca;
end;
$$
*/
/*
update auto
set precioxhora = precioxhora+(7/100)*precioxhora
where id_marca=3;
/****/
update auto
set precioxhora = 5000
where id_marca=3;

call actualizar(3,10);
select * from auto;
/*
delimiter $$
create procedure Add_nombre(in nombre varchar(50))
begin
	insert into persona(persona.nombre)value(nombre);
end
$$
*/
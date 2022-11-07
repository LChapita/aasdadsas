create database subconsulta;

use subconsulta;

create table departamento(
	codigo int(10),
    nombre varchar(100),
    presupuesto double
);

create table empleado(
	codigo int(10),
    nif varchar(9),
    nombre varchar(100),
    apellido1 varchar(100),
    apellido2 varchar(100),
    codigo_departamento int(10)
);

alter table departamento
add primary key(codigo);

alter table empleado
add foreign key(codigo_departamento) references departamento(codigo);

alter table departamento
add column gastos double;


INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);


INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero',NULL);

/*Con operadores básicos de comparación*/
/*1. Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN).*/
select e.* from empleado e 
where e.codigo_departamento=(select d.codigo from departamento d where d.nombre='Sistemas');
/*2. Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.*/
select d.nombre,d.presupuesto from departamento d where d.presupuesto>=(select max(presupuesto) from departamento);
/*3. Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.*/
select d.nombre,d.presupuesto from departamento d where d.presupuesto<=(select min(presupuesto) from departamento);

/*Subconsultas con ALL y ANY*/

/*4. Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. 
Sin hacer uso de MAX, ORDER BY ni LIMIT.*/
select d.nombre,d.presupuesto from departamento d
where d.presupuesto>= all(select presupuesto from departamento);
/*5. Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. 
Sin hacer uso de MIN, ORDER BY ni LIMIT.*/
select d.nombre,d.presupuesto from departamento d
where d.presupuesto<= all(select presupuesto from departamento);
/*6. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).*/
select d.nombre from departamento d 
where d.codigo= any(select e.codigo_departamento from empleado e);
/*7. Devuelve los nombres de los departamentos que no tienen empleados
asociados. (Utilizando ALL o ANY).*/
select d.nombre from departamento d 
where d.codigo <> all(select e.codigo_departamento from empleado e where e.codigo_departamento = d.codigo);

/* Subconsultas con IN y NOT IN*/

/*8. Devuelve los nombres de los departamentos que tienen empleados
asociados. (Utilizando IN o NOT IN).*/
select d.nombre from departamento d
where d.codigo in (select codigo_departamento from empleado);
/*9. Devuelve los nombres de los departamentos que no tienen empleados
asociados. (Utilizando IN o NOT IN).*/
SELECT nombre
FROM departamento
WHERE codigo NOT IN (
  SELECT codigo_departamento
  FROM empleado
  WHERE codigo_departamento IS NOT NULL);

/*Subconsultas con EXISTS y NOT EXISTS*/

/*10.Devuelve los nombres de los departamentos que tienen empleados
asociados. (Utilizando EXISTS o NOT EXISTS).*/
select d.nombre from departamento d
where exists(select e.codigo_departamento from empleado e where d.codigo=e.codigo_departamento );
/*11. Devuelve los nombres de los departamentos que tienen empleados
asociados. (Utilizando EXISTS o NOT EXISTS).*/
select d.nombre from departamento d
where not exists(select e.codigo_departamento from empleado e where d.codigo=e.codigo_departamento );
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/





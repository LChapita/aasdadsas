create database Guia3;
use Guia3;

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


/*1. Lista el primer apellido de todos los empleados.*/
select apellido1 Primer_apellido from empleado;
/*2. Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.*/
select distinct apellido1 Primer_apellido from empleado;
/*3. Lista todas las columnas de la tabla empleado.*/
select * from empleado;
/*4. Lista el nombre y los apellidos de todos los empleados.*/
select nombre,apellido1,apellido2 from empleado;
/*5. Lista el código de los departamentos de los empleados que aparecen en la tabla empleado.*/
select codigo_departamento from empleado;
/*6. Lista el código de los departamentos de los empleados que aparecen en la
tabla empleado, eliminando los códigos que aparecen repetidos.*/
select distinct codigo_departamento from empleado;
/*7. Lista el nombre y apellidos de los empleados en una única columna.*/
select concat_ws(' ', e.nombre, e.apellido1, e.apellido2) as 'Nombre y Apellido'
from empleado e;
select e.codigo, concat(e.nombre,' ', 
	case when e.apellido1 is null Then ''
    else e.apellido1 end,
    ' ',
    case when e.apellido2 is null then ' '
    else e.apellido2 end) as nombre_apellidos
from empleado e;
/* ************************************** */
select nombre nombre_apellidos from empleado 
union 
select apellido1 from empleado 
union 
select apellido2 from empleado;

/*8. Lista el nombre y apellidos de los empleados en una única columna,
convirtiendo todos los caracteres en mayúscula.*/
select ucase(nombre) nombre_apellidos from empleado
union
select ucase(apellido1) from empleado
union
select ucase(apellido2) from empleado;

select concat(ucase(e.nombre),' ', 
	case when e.apellido1 is null Then ''
    else ucase(e.apellido1) end,
    ' ',
    case when e.apellido2 is null then ' '
    else ucase(e.apellido2) end) as nombre_apellidos
from empleado e;
/*9. Lista el nombre y apellidos de los empleados en una única columna,
convirtiendo todos los caracteres en minúscula.*/

select concat(lcase(e.nombre),' ',
	case when e.apellido1 is null then ''
    else lcase(e.apellido1) end,
    '',
    case when e.apellido2 is null then ' '
    else lcase(e.apellido2) end) as nombre_apellido
from empleado e;

/*10.Lista el código de los empleados junto al nif, pero el nif deberá aparecer en
dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra*/
select right(nif,1) letra,
left(nif,8) numero from empleado;
/*11. Lista el nombre de cada departamento y el valor del presupuesto actual del
que dispone. Para calcular este dato tendrá que restar al valor del
presupuesto inicial (columna presupuesto) los gastos que se han generado
(columna gastos). Tenga en cuenta que en algunos casos pueden existir
valores negativos. Utilice un alias apropiado para la nueva columna columna
que está calculando.*/

select nombre nombre_Depto,presupuesto Presupuesto,gastos Gasto,presupuesto-gastos total from departamento;

/*12.Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.*/
select nombre nombre_Depto,presupuesto Presupuesto,gastos Gasto,presupuesto-gastos total from departamento
order by total asc;

/*13.Lista el nombre de todos los departamentos ordenados de forma ascendente.*/
select nombre nombre_Depto from departamento order by nombre asc;
/*14.Lista el nombre de todos los departamentos ordenados de forma descendente.*/
select nombre nombre_Depto from departamento order by nombre desc;
/*15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma
alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su
nombre.*/
select apellido1,apellido2,nombre from empleado order by apellido1 asc;
/*16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.*/
select nombre, presupuesto from departamento order by presupuesto desc limit 3;
/*17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos
que tienen menor presupuesto.*/
select nombre, presupuesto from departamento order by presupuesto asc limit 3;
/*18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que
tienen mayor gasto.*/
select nombre, gastos from departamento order by presupuesto desc limit 2;
/*19.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que
tienen menor gasto.*/
select nombre, gastos from departamento order by gastos asc limit 2;
/*20.Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La
tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las
columnas de la tabla empleado.*/
select * from empleado limit 2,5;
/*21.Devuelve una lista con el nombre de los departamentos y el presupuesto, de
aquellos que tienen un presupuesto mayor o igual a 150000 euros.*/
select nombre, presupuesto from departamento
where presupuesto>=150000;
/*22.Devuelve una lista con el nombre de los departamentos y el gasto, de
aquellos que tienen menos de 5000 euros de gastos.*/
select nombre, gastos from departamento where gastos<5000;
/*23.Devuelve una lista con el nombre de los departamentos y el presupuesto, de
aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar
el operador BETWEEN.*/
select nombre, presupuesto from departamento where presupuesto>99999 and presupuesto<200001;

select nombre, presupuesto from departamento where presupuesto>=100000 and presupuesto<=200000;
/*24.Devuelve una lista con el nombre de los departamentos que no tienen un
presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.*/
select nombre from departamento where presupuesto<100000 or presupuesto>200000;
/*25.Devuelve una lista con el nombre de los departamentos que tienen un
presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.*/
select nombre,presupuesto from departamento where presupuesto between 100000 and 200000;
/*26.Devuelve una lista con el nombre de los departamentos que no tienen un
presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.*/
select nombre, presupuesto from departamento where not presupuesto between 100000 and 200000;
/*27.Devuelve una lista con el nombre de los departamentos, gastos y
presupuesto, de aquellos departamentos donde los gastos sean mayores que
el presupuesto del que disponen.*/
select nombre,gastos, presupuesto from departamento where gastos>presupuesto;
/*28.Devuelve una lista con el nombre de los departamentos, gastos y
presupuesto, de aquellos departamentos donde los gastos sean menores que
el presupuesto del que disponen.*/
select nombre,gastos,presupuesto from departamento where gastos<presupuesto;
/*29.Devuelve una lista con el nombre de los departamentos, gastos y
presupuesto, de aquellos departamentos donde los gastos sean iguales al
presupuesto del que disponen.*/
select nombre,gastos,presupuesto from departamento where gastos=presupuesto;
/*30.Lista todos los datos de los empleados cuyo segundo apellido sea NULL*/
select * from empleado where apellido2 is null;
/*31.Lista todos los datos de los empleados cuyo segundo apellido no sea NULL*/
select * from empleado where apellido2 is not null;
/*32.Lista todos los datos de los empleados cuyo segundo apellido sea López.*/
select * from empleado where apellido2 like 'López';
/*33.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o
Moreno. Sin utilizar el operador IN.*/
select * from empleado where apellido2 like 'Díaz' or apellido2 like'Moreno';
/*34.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o
Moreno. Utilizando el operador IN.*/
select * from empleado where apellido2 in
('Díaz') or apellido2 in('Moreno');
/*35.Lista los nombres, apellidos y nif de los empleados que trabajan en el
departamento 3.*/
select nombre,apellido1,apellido2,nif from empleado where codigo_departamento=3;
/*36.Lista los nombres, apellidos y nif de los empleados que trabajan en los
departamentos 2, 4 o 5.*/
select nombre,apellido1,apellido2,nif, codigo_departamento from empleado where codigo_departamento=2 or codigo_departamento=4 or codigo_departamento=5;
/*********************************************************************************************************************************************************************/

/*1. Devuelve un listado con los empleados y los datos de los departamentos
donde trabaja cada uno.*/
select e.*,d.* from empleado e
inner join departamento d
where e.codigo_departamento = d.codigo;
/*2. Devuelve un listado con los empleados y los datos de los departamentos
donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre
del departamento (en orden alfabético) y en segundo lugar por los apellidos y
el nombre de los empleados.*/
select * from empleado e inner join departamento d on d.codigo = e.codigo_departamento order by d.nombre,e.apellido1,e.apellido2,e.nombre asc;
/*3. Devuelve un listado con el código y el nombre del departamento, solamente
de aquellos departamentos que tienen empleados.*/
select d.codigo,d.nombre from departamento d
inner join empleado e on d.codigo=e.codigo_departamento;
/*4. Devuelve un listado con el código, el nombre del departamento y el valor del
presupuesto actual del que dispone, solamente de aquellos departamentos
que tienen empleados. El valor del presupuesto actual lo puede calcular
restando al valor del presupuesto inicial (columna presupuesto) el valor de los
gastos que ha generado (columna gastos).*/
select d.codigo,d.nombre,(d.presupuesto-d.gastos) Presupuesto_Actual from departamento d
inner join empleado e on d.codigo=e.codigo_departamento;
/*5. Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.*/

select d.nombre from departamento d
inner join empleado e on e.codigo_departamento=d.codigo
where e.nif='38382980M';
/*6. Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.*/
select d.nombre from departamento d
inner join empleado e on e.codigo_departamento=d.codigo
where e.nombre='Pepe' and e.apellido1='Ruiz' and e.apellido2='Santana';
/*7. Devuelve un listado con los datos de los empleados que trabajan en el
departamento de I+D. Ordena el resultado alfabéticamente.*/

select e.* from empleado e
inner join departamento d on d.codigo=e.codigo_departamento
where d.nombre like 'I+D'
order by e.nombre asc;
/*8. Devuelve un listado con los datos de los empleados que trabajan en el
departamento de Sistemas, Contabilidad o I+D. Ordena el resultado
alfabéticamente.*/
select * from empleado e
inner join departamento d on d.codigo=e.codigo_departamento
where d.nombre in ('I+D','Sistemas','Contabilidad')
order by e.nombre asc;
/*9. Devuelve una lista con el nombre de los empleados que tienen los
departamentos que no tienen un presupuesto entre 100000 y 200000 euros.*/
select * from empleado e
inner join departamento d on d.codigo=e.codigo_departamento
where d.presupuesto not between 100000 and 200000;
/*10.Devuelve un listado con el nombre de los departamentos donde existe algún
empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe
mostrar nombres de departamentos que estén repetidos.*/
select distinct * from departamento d
inner join empleado e on e.codigo_departamento = d.codigo
where e.apellido2 is null;
/*************************************************************************************************************************************************************************************************/
/*1. Devuelve un listado con todos los empleados junto con los datos de los
departamentos donde trabajan. Este listado también debe incluir los
empleados que no tienen ningún departamento asociado*/
select * from empleado e
left join departamento d on d.codigo=e.codigo_departamento;
/*2. Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen
ningún departamento asociado.*/
select * from empleado e
left join departamento d on d.codigo=e.codigo_departamento
where d.codigo is null;
/*3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no
tienen ningún empleado asociado.*/
select * from empleado e
left join departamento d on d.codigo=e.codigo_departamento
where e.codigo_departamento is null;
/*4. Devuelve un listado con todos los empleados junto con los datos de los
departamentos donde trabajan. El listado debe incluir los empleados que no
tienen ningún departamento asociado y los departamentos que no tienen
ningún empleado asociado. Ordene el listado alfabéticamente por el nombre
del departamento.*/
select * from empleado e
left join departamento d 
on d.codigo=e.codigo_departamento
union
select * from empleado e
right join departamento d 
on e.codigo_departamento=d.codigo
order by 1;
/*el numero indica el lugar de la columna 1=codigo 2=nif 3=nombre*/

/*5. Devuelve un listado con los empleados que no tienen ningún departamento
asociado y los departamentos que no tienen ningún empleado asociado.
Ordene el listado alfabéticamente por el nombre del departamento.*/
select * from empleado e
left join departamento d
on e.codigo_departamento=d.codigo
where d.codigo is null
union
select * from empleado e
right join departamento d
on e.codigo_departamento=d.codigo
where e.codigo_departamento is null
order by 7;
/******************************************************************************************************************************/
/*1. Calcula la suma del presupuesto de todos los departamentos.*/
select sum(presupuesto) from departamento;
/*2. Calcula la media del presupuesto de todos los departamentos.*/
select round(avg(presupuesto)) from departamento;
/*3. Calcula el valor mínimo del presupuesto de todos los departamentos.*/
select min(presupuesto) from departamento;
/*4. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.*/
select d.nombre,d.presupuesto from departamento d where presupuesto in (select min(presupuesto) from departamento);
/*5. Calcula el valor máximo del presupuesto de todos los departamentos.*/
select max(presupuesto) from departamento;
/*6. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.*/
select d.nombre, d.presupuesto from departamento d where presupuesto in(select max(presupuesto) from departamento);
/*7. Calcula el número total de empleados que hay en la tabla empleado.*/
select count(codigo) from empleado;
/*8. Calcula el número de empleados que no tienen NULL en su segundo apellido.*/
select count(codigo) from empleado where apellido1 is not null and apellido2 is not null;
/*9. Calcula el número de empleados que hay en cada departamento. 
Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.*/
select d.nombre, count(e.codigo) from departamento d
left join empleado e
on d.codigo=e.codigo_departamento
group by d.nombre;
/*10.Calcula el nombre de los departamentos que tienen más de 2 empleados. 
El resultado debe tener dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.*/
select d.nombre,count(e.codigo) from departamento d
left join empleado e
on d.codigo=e.codigo_departamento
group by d.nombre having count(e.codigo)>1.5;
/*11. Calcula el número de empleados que trabajan en cada uno de los departamentos. 
El resultado de esta consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.*/
select count(e.codigo),d.nombre from empleado e
right join departamento d on e.codigo_departamento=d.codigo
group by d.nombre;
select d.nombre, count(e.codigo) from departamento d left join empleado e on d.codigo = e.codigo_departamento group by d.nombre;
/*12.Calcula el número de empleados que trabajan en cada unos de los
departamentos que tienen un presupuesto mayor a 200000 euros.*/
select count(e.codigo),d.nombre from empleado e
left join departamento d
on e.codigo_departamento=d.codigo
where d.presupuesto>=200000
group by d.nombre,d.presupuesto;

select d.nombre, d.presupuesto, count(e.codigo) as "NUMERO EMPLEADOS" from departamento d join empleado e on d.codigo = e.codigo_departamento where d.presupuesto > 200000 group by d.nombre, d.presupuesto;
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
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/

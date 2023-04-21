use master
go

Create database TPO_GOT_REENTREGA

use TPO_GOT_REENTREGA
go

create table REINO (
	NOMBRE varchar(30) primary key,
	CANT_HABITANTES int,
	CONTINENTE varchar(30),
	POSICION varchar(10)
)

create table CASAS (
	NOMBRE varchar(30) primary key,
	LEMA varchar(30) not null,
	ANIMAL varchar(30) not null,
	COLOR varchar(30) not null,
	FECHA_DE_CREACION date not null,
	RELIGION varchar(50) not null,
	REINO varchar(30) not null,
	Foreign key (REINO) references REINO(NOMBRE)
)

create table CIUDADES(
	NOMBRE_REINO varchar(30),
	CIUDAD varchar(30),
	primary key(NOMBRE_REINO, CIUDAD),
	Foreign key (NOMBRE_REINO) references REINO(NOMBRE)
)

create table CASTILLO (
	NOMBRE varchar(30),
	REINO varchar(30),
	FORTIFICACION varchar(50),
	CANT_SIRVIENTES int,
	primary key(NOMBRE, REINO),
	Foreign key (REINO) references REINO(NOMBRE) 
)

create table GUERRAS (
	LUGAR varchar(50),
	AÑO_INICIO int,
	CANT_MUERTES int not null,
	primary key(LUGAR, AÑO_INICIO)
)

create table PARTICIPACION(
	LUGAR varchar(50) ,
	AÑO_INICIO int ,
	GANADOR bit not null,
	NOMBRE_INVOLUCRADOS varchar(30) not null,
	primary key(LUGAR, AÑO_INICIO, NOMBRE_INVOLUCRADOS),
	Foreign key (LUGAR, AÑO_INICIO) references GUERRAS (LUGAR, AÑO_INICIO),
	Foreign key (NOMBRE_INVOLUCRADOS) references CASAS(NOMBRE)
)

create table PERSONAJES (
	NOMBRE varchar(30),
	AÑO_NACIMIENTO int,
	BASTARDO bit not null,
	TIPO_ESTATUS varchar(8) not null,
	NOMBRE_PADRE varchar(30),
	AÑO_PADRE int,
	NOMBRE_MADRE varchar(30),
	AÑO_MADRE int,
	NOMBRE_HIJOS varchar(30),
	AÑO_HIJOS int,
	Constraint CHK_ESTATUS check (TIPO_ESTATUS in ('VIVO', 'MUERTO', 'INACTIVO')),
	primary key(NOMBRE, AÑO_NACIMIENTO),
	Foreign key (NOMBRE_PADRE,AÑO_PADRE) references PERSONAJES(NOMBRE, AÑO_NACIMIENTO),
	Foreign key (NOMBRE_MADRE,AÑO_MADRE) references PERSONAJES(NOMBRE, AÑO_NACIMIENTO),
	Foreign key (NOMBRE_HIJOS,AÑO_HIJOS) references PERSONAJES(NOMBRE, AÑO_NACIMIENTO)
)

create table PERSONAJESCASAS(
	NOMBRE_PERSONAJES varchar(30),
	AÑO_NACIMIENTO int,
	NOMBRE_CASA varchar(30),
	primary key(NOMBRE_PERSONAJES, AÑO_NACIMIENTO,NOMBRE_CASA),
	Foreign key (NOMBRE_PERSONAJES,AÑO_NACIMIENTO) references PERSONAJES(NOMBRE,AÑO_NACIMIENTO),
	Foreign key (NOMBRE_CASA) references CASAS(NOMBRE)
)

create table PROFESIONES (
	NOMBRE_PROFESION varchar(30),
	TIPO_PROFESION varchar(50),
	primary key(NOMBRE_PROFESION)
)

create table MAESTROS (
	NOMBRE_PROFESION varchar(30) not null,
	NOMBRE varchar(30) not null,
	AÑO_NACIMIENTO int not null,
	primary key(NOMBRE, AÑO_NACIMIENTO, NOMBRE_PROFESION),
	Foreign key (NOMBRE, AÑO_NACIMIENTO) references PERSONAJES(NOMBRE, AÑO_NACIMIENTO),
	Foreign key (NOMBRE_PROFESION) references PROFESIONES(NOMBRE_PROFESION)
)

create table EJERCEPROFESION (
	NOMBRE_PROFESION varchar(30),
	AÑO_NACIMIENTO int,
	NOMBRE varchar(30),
	FECHA_INICIO date not null,
	primary key(NOMBRE, AÑO_NACIMIENTO, NOMBRE_PROFESION),
	Foreign key (NOMBRE, AÑO_NACIMIENTO) references PERSONAJES(NOMBRE, AÑO_NACIMIENTO),
	Foreign key (NOMBRE_PROFESION) references PROFESIONES(NOMBRE_PROFESION)
)

create table ESPECIE (
	NOMBRE varchar(30),
	HOSTIL bit ,
	EXTINCTA bit ,
	primary key(NOMBRE)
)

create table HABILIDADES (
	NOMBRE_ESPECIE varchar(30),
	HABILIDADES varchar(255)
	primary key(NOMBRE_ESPECIE)
	Foreign key (NOMBRE_ESPECIE) references ESPECIE(NOMBRE)
)

create table ESPECIEPERSONAJES (
	NOMBRE varchar(30) ,
	AÑO_NACIMIENTO int ,
	ESPECIE varchar(30) ,
	primary key(NOMBRE, AÑO_NACIMIENTO, ESPECIE),
	Foreign key (NOMBRE, AÑO_NACIMIENTO) references PERSONAJES(NOMBRE, AÑO_NACIMIENTO),
	Foreign key (ESPECIE) references ESPECIE(NOMBRE),
)

--------------------------------------------------------------------------------------------------------------------

insert into REINO values
	('Kingdom of The Rock', 100000, 'Westeros', 'Norte'),
	('Kingdom of The North', 10000, 'Westeros', 'Norte'),
	('Kingdom of The Reach', 100000, 'Westeros', 'Sur'),
	('Kingdom of The Stormlands', 125000, 'Westeros', 'Este'),
	('Kingdom of The Domain', 43000, 'Westeros', 'Oeste')

insert into CASAS values
	('Stark', 'Winter is coming', 'Lobo Huargo', 'Gris', '0100/01/01', 'Antiguos Dioses', 'Kingdom of The North'),
	('Bolton', 'Our Blades Are Sharp', 'Humano', 'Rojo', '0200/04/16','Fe de los Siete', 'Kingdom of The North'),
	('Targaryen', 'Growing Strong', 'Dragon 3 cabezas', 'Rojo', '0211/02/13', 'Fe de los Siete' ,'Kingdom of The Reach'),
	('Lannister', 'Hear me roar', 'Leon', 'Rojo', '0214/07/21', 'Fe de los Siete', 'Kingdom of The Rock'),
	('Greyjoy', 'We do not sow', 'Pulpo', 'Amarillo', '0123/09/10', 'Dios Ahogado', 'Kingdom of The Domain'),
	('Baratheon', 'Ours is the fury', 'Ciervo', 'Negro', '0175/05/25', 'Señor de la Luz', 'Kingdom of The Stormlands')

insert into CIUDADES values
	('Kingdom of The Rock', 'Dorne'),
	('Kingdom of The North', 'White Harbor'),
	('Kingdom of The Reach', 'The Eyrie'),
	('Kingdom of The Stormlands', 'Casterly Rock'),
	('Kingdom of The Domain', 'Riverrun')

insert into CASTILLO values
	('Casterly Rock', 'Kingdom of The Rock', 'Piedra', 1000),
	('Winterfell', 'Kingdom of The North', 'Muralla', 100),
	('High Garden', 'Kingdom of The Reach', 'Triple Muralla', 4000),
	('Harrenhal', 'Kingdom of The Domain', 'Edificios altas', 2000),
	('Bastion de las Tormentas', 'Kingdom of The Stormlands', 'Edificio alto', 1500)

insert into GUERRAS values
	('Astapor', 300, 2000),
	('Meeren', 300, 5000),
	('Yunkai', 299, 5000),
	('Poniente', 261, 10000),
	('Poniente', 195, 10000)

insert into PARTICIPACION values
	('Astapor', 300, 1, 'Stark'),
	('Meeren', 300, 0, 'Bolton'),
	('Yunkai', 299, 1, 'Targaryen'),
	('Poniente', 261, 1, 'Lannister'),
	('Poniente', 195, 0, 'Greyjoy')

insert into PERSONAJES values
	('Daenerys Targaryen', 284, 0, 'VIVO', null, null, null, null, null, 300),
	('Cersei Lannister', 262, 0, 'VIVO', null, null, null, null, null, 280),
	('Jon Snow', 283, 1, 'VIVO', null, null, null, null, null, null),
	('Jamie Lannister', 262, 0, 'VIVO', null, null, null, null, null, 280),
	('Renly Baratheon', 277, 0, 'VIVO', null, null, null, null, null, null)

insert into PERSONAJESCASAS values
	('Daenerys Targaryen', 284, 'Targaryen'),
	('Cersei Lannister', 262, 'Lannister'),
	('Jon Snow', 283, 'Stark'),
	('Jamie Lannister', 262, 'Lannister'),
	('Renly Baratheon', 277, 'Baratheon')

insert into PROFESIONES values
	('Herrero', 'Forja'),
	('Carnicero', 'Venta'),
	('Mano del Rey', 'Realeza'),
	('Lider de Guerra', 'Ejercito'),
	('Explorador', 'Ejercito')

insert into MAESTROS values
	('Lider de Guerra', 'Daenerys Targaryen', 284),
	('Carnicero', 'Cersei Lannister', 262),
	('Explorador', 'Jon Snow', 283),
	('Mano del rey', 'Jamie Lannister', 262),
	('Herrero', 'Renly Baratheon', 277)

insert into EJERCEPROFESION values
	('Lider de Guerra', 284, 'Daenerys Targaryen', '0300/01/01'),
	('Carnicero', 262, 'Cersei Lannister', '0280/01/01'),
	('Explorador', 283, 'Jon Snow', '0293/01/01'),
	('Mano del rey', 262, 'Jamie Lannister', '0280/01/01'),
	('Herrero', 277, 'Renly Baratheon', '0290/01/01')

insert into ESPECIE values
	('Humano', 0, 0),
	('Dragon', 1, 0),
	('Gigante', 0, 1),
	('White walker', 1, 1),
	('Espectro', 1, 0)

insert into HABILIDADES values
	('Humano', null),
	('Dragon', 'Vuelo'),
	('Gigante', 'Fuerza'),
	('White walker', 'Resistencia'),
	('Espectro', 'Resistencia')

insert into ESPECIEPERSONAJES values
	('Daenerys Targaryen', 284, 'Humano'),
	('Cersei Lannister', 262, 'Humano'),
	('Jon Snow', 283, 'Humano'),
	('Jamie Lannister', 262, 'Humano'),
	('Renly Baratheon', 277, 'Humano')

--------------------------------------------------------------------------------------

EXEC CREATE_CASTILLO 'BASTION DE LOS TORNADOS', 'Kingdom of The South', 'EDIFICIO ALTO', 2000

EXEC READ_CASAS 'Stark'

EXEC UPDATE_PROFESIONES 'Herrero', 'Metalurgia'

EXEC DELETE_PERSONAJE 'Daenerys Targaryen', 284

--------------------------------------------------------------------------------------

-- Muestra los nombres y edades de los personajes
select NOMBRE, AÑO_NACIMIENTO 
from PERSONAJES;

--Muestra los personajes que no son bastardos
select *
from PERSONAJES 
where BASTARDO = 0;

--Muestra los nombres de los personajes que pertenezcan  a una casa con fecha de creacion 214/07/21
select NOMBRE 
from PERSONAJES 
where NOMBRE IN
(SELECT NOMBRE_PERSONAJES FROM PERSONAJESCASAS WHERE NOMBRE_CASA IN 
(SELECT NOMBRE FROM CASAS WHERE FECHA_DE_CREACION = '0214/07/21'));

--Muestra los personajes que en su nombre contengan una vocal
select *
from PERSONAJES 
where NOMBRE LIKE '%a%' OR NOMBRE LIKE '%e%' OR NOMBRE LIKE '%i%' OR NOMBRE LIKE '%o%' OR NOMBRE LIKE '%u%';

--Muestra las casas que pertenezcan a un reino con mas de 43000 habitantes
select *
from CASAS 
where REINO IN 
(SELECT NOMBRE FROM REINO  WHERE CANT_HABITANTES > 43000);

-- Muestra todos los personajes que su especie no tenga habilidades
select *
from PERSONAJES 
where NOMBRE IN 
(SELECT NOMBRE FROM ESPECIEPERSONAJES WHERE ESPECIE IN
(SELECT NOMBRE  FROM ESPECIE WHERE NOMBRE IN 
(SELECT NOMBRE_ESPECIE FROM HABILIDADES WHERE HABILIDADES IS NULL)));

-- Muestra los personajes que pertenezcan a un castillo con mas de 1000 sirvientes
select *
from PERSONAJES 
where NOMBRE IN 
(SELECT NOMBRE FROM PERSONAJESCASAS WHERE NOMBRE_CASA IN 
(SELECT NOMBRE FROM CASAS WHERE REINO IN 
(SELECT REINO FROM CASTILLO WHERE CANT_SIRVIENTES > 1000)));


-- Drops en orden para las foreigns

--drop table HABILIDADES
--drop table ESPECIEPERSONAJES
--drop table ESPECIE
--drop table MAESTROS
--drop table EJERCEPROFESION
--drop table PROFESIONES
--drop table PARTICIPACION
--drop table GUERRAS
--drop table PERSONAJESCASAS
--drop table CASTILLO
--drop table CIUDADES
--drop table CASAS
--drop table REINO
--drop table PERSONAJES



drop database if exist Plan_gym;

create database Plan_gym;

use Plan_gym;


create table Sede(id int primary key, nombre varchar(20), direccion varchar(20));
Query OK, 0 rows affected (0,03 sec)


create table Clase(id int primary key, nombre varchar(20), horarios date, cant_max_personas int);
Query OK, 0 rows affected (0,03 sec)

create table Socios(dni int primary key, nombre varchar (20), apellido varchar(20), fecha_registro date, id_clase int, consraint id_clase foreign key (id_clases) references Clase(id));

create table Planes(id int primary key, nombre varchar (20), fecha_inicio date, fecha_final date, estado_plan varchar(20));

create table Sesiones(id int primary key, nombre varchar (20), conj_ejercicio varchar(20), id_plan int, consraint id_plan foreign key (id_clases) references Planes(id));

create table Observaciones(id int primary key, nombre varchar (20), fecha datetime, peso int, cant_series int, cant_repeticiones int);

create table Circuitos(id int primary key, nombre varchar (20), repeticiones varchar(20), series int, repeticiones int, id_observaciones, consraint id_observaciones foreign key (id_observaciones) references Observaciones(id));

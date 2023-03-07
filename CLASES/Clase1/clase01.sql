create database imdb;
Query OK, 1 row affected (0,00 sec)

use imdb
Database changed

create table film(film_id int primary key, title varchar(20), description varchar(40), realease_year date);
Query OK, 0 rows affected (0,03 sec)

create table actor(actor_id int primary key, first_id varchar(20), last_name varchar(40));
Query OK, 0 rows affected (0,02 sec)

create table film_actor (actor_id int, constraint foreign key (actor_id) references actor(actor_id), film_id int, constraint foreign key (film_id) references film(film_id));
Query OK, 0 rows affected (0,02 sec)

alter table film add last_update varchar(20);
Query OK, 0 rows affected (0,04 sec)


alter table actor add last_update varchar(20);
Query OK, 0 rows affected (0,03 sec)


alter table actor auto_increment=1;
Query OK, 0 rows affected (0,07 sec)


alter table film auto_increment=1;
Query OK, 0 rows affected (0,02 sec)

insert into actor(actor_id, first_id, last_name) values ('1', 'Emma', 'Myers');
Query OK, 1 row affected (0,00 sec)

insert into actor(actor_id, first_id, last_









name) values ('2','Leonardo', 'DiCaprio');
Query OK, 1 row affected (0,00 sec)

insert into film(film_id, title, description, realease_year) values ('1','Wednsday', 'ill dance dance dance', '2022-11-12');
Query OK, 1 row affected (0,04 sec)

mysql> insert into film(film_id, title, description, realease_year) values ('2','El Mati', 'el pepe', '2021-02-01');
Query OK, 1 row affected (0,01 sec)



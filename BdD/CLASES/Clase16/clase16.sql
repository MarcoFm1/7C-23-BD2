-- 1- Insert a new employee to , but with a null email. Explain what happens.
CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

insert into employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) values (777, 'Myers', 'Emma', 'extendida', null, 'USA', 1, 'Actriz');

No es posible insertar un correo electrónico nulo debido a que al momento de crear la tabla de empleados se estableció que todos los campos deben contener valores (NOT NULL).

-- 2- Run the first the query
-- UPDATE employees SET employeeNumber = employeeNumber - 20
-- What did happen? Explain. Then run this other
-- UPDATE employees SET employeeNumber = employeeNumber + 20
-- Explain this case also.


En la primera consulta:
Se ejecuta sin problemas al restar 20 de cada "employeeNumber" secuencialmente, sin colisiones.

En la segunda consulta:
Genera un error al sumar 20 a cada "employeeNumber" debido a superposiciones entre valores, especialmente cuando la diferencia entre números consecutivos es pequeña.


-- 3- Add an age column to the table employee where and it can only accept values from 16 up to 70 years old.
alter table employees
add age tinyint unsigned default 30;

alter table employees
add constraint age check (age >= 16 and age <= 70);

-- 4- Describe the referential integrity between tables film, actor and film_actor in sakila db.
En Sakila, las tablas "actor" y "film" tienen IDs únicos para actores y películas. La tabla intermedia "film_actor" conecta actores con películas usando estos IDs, manteniendo la relación. Las "foreign keys" aseguran que solo se puedan agregar combinaciones válidas, garantizando la coherencia de las relaciones.


-- 5- Create a new column called lastUpdate to table employee and use trigger(s) to keep the date-time updated on inserts and updates operations. Bonus: add a column lastUpdateUser and the respective trigger(s) to specify who was the last MySQL user that changed the row (assume multiple users, other than root, can connect to MySQL and change this table).
alter table employees
add column lastUpdate datetime; 

alter table employees
add column lastUpdateUser varchar(255); 

create trigger before_employee_update 
    before update on employees
    for each row 
begin
     set new.lastUpdate = now();
     set new.lastUpdateUser = CURRENT_USER;
end;

update employees set lastName = 'Myers' where employeeNumber = 777;


-- 6- Find all the triggers in sakila db related to loading film_text table. What do they do? Explain each of them using its source code for the explanation.

-- INS_FILM
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
END

-- UPD_FILM
BEGIN
	IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
	THEN
	    UPDATE film_text
	        SET title=new.title,
	            description=new.description,
	            film_id=new.film_id
	    WHERE film_id=old.film_id;
	END IF;
END

-- sDEL_FILM
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
END
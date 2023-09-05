--1 Create a user data_analyst
CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'daleteo1234';

--2 Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

--3 Login with this user and try to create a table. Show the result of that operation.
CREATE TABLE test (id INT PRIMARY KEY,nombre VARCHAR(50));

--4 Try to update a title of a film. Write the update script.
UPDATE sakila.film
SET title = 'Changed'
WHERE title = 'ACADEMY DINOSAUR';

UPDATE sakila.film
SET title = 'ACADEMY DINOSAUR'
WHERE title = 'Changed';

--5 With root or any admin user revoke the UPDATE permission. Write the command
REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';
UPDATE sakila.film
SET title = 'Changed'
WHERE title = 'ACADEMY DINOSAUR';

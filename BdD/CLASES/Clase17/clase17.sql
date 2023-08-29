-- Create two or three queries using address table in sakila db:

-- include postal_code in where (try with in/not it operator)
SELECT * FROM address WHERE postal_code IN ('12345', '54321');

SELECT * FROM address WHERE postal_code NOT IN ('12345', '54321');

-- eventually join the table with city/country tables.
SELECT a.*, c.city, co.country
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code = '12345';

-- measure execution time.
SET SESSION profiling = 1;
SELECT * FROM address WHERE postal_code IN ('12345', '54321');
SHOW PROFILES;

-- Then create an index for postal_code on address table.
CREATE INDEX idx_postal_code ON address(postal_code);

-- measure execution time again and compare with the previous ones.
SET SESSION profiling = 1;
SELECT * FROM address WHERE postal_code IN ('12345', '54321');
SHOW PROFILES;


-- Explain the results
Antes de hacer el cambio, la base de datos tenía que revisar cada dirección para encontrar las que coincidieran con los códigos postales. Después del cambio, la base de datos tenía una especie de lista de códigos postales, lo que la hizo más rápida para encontrar las direcciones correctas. Así que, después del cambio, las búsquedas fueron más veloces. ¡Esto muestra cómo pequeñas mejoras pueden hacer las cosas mucho más rápidas en una base de datos!

-- Run queries using actor table, searching for first and last name columns independently. Explain the differences and why is that happening?
SELECT * FROM actor WHERE first_name = 'Johnny';
SELECT * FROM actor WHERE last_name = 'Cage';
Las diferencias en los resultados provienen de la naturaleza de la coincidencia exacta.


-- Compare results finding text in the description on table film with LIKE and in the film_text using MATCH ... AGAINST. Explain the results.
MATCH ... AGAINST tiende a proporcionar resultados más precisos debido a que considera la relevancia de las palabras
LIKE es más simple y funciona para búsquedas de texto simples
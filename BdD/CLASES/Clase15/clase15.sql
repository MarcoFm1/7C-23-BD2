-- Create a view named list_of_customers, it should contain the following columns: customer id customer full name, address zip code phone city country status (when active column is 1 show it as 'active', otherwise is 'inactive') store id
CREATE VIEW list_of_customers AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    a.address,
    a.postal_code AS zip_code,
    a.phone,
    ci.city,
    co.country,
    CASE WHEN c.active = 1 THEN 'active' ELSE 'inactive' END AS status,
    c.store_id
FROM 
    customer c
    JOIN address a ON c.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id;

SELECT * FROM list_of_customers;



--Create a view named film_details, it should contain the following columns: film id, title, description, category, price, length, rating, actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT
CREATE VIEW film_details AS
SELECT
    f.film_id,
    f.title,
    f.description,
    c.name AS category,
    f.rental_rate AS price,
    f.length,
    f.rating,
    GROUP_CONCAT(DISTINCT a.first_name, ' ', a.last_name ORDER BY a.first_name ASC SEPARATOR ', ') AS actors
FROM
    film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN film_actor fa ON f.film_id = fa.film_id
    JOIN actor a ON fa.actor_id = a.actor_id;


SELECT * FROM film_details;



--Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.
CREATE VIEW sales_by_film_category AS
SELECT
    c.name AS category,
    SUM(p.amount) AS total_rental
FROM
    film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id;


SELECT * FROM sales_by_film_category;


--Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.
CREATE or REPLACE VIEW actor_information AS
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS film_count
FROM
    actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id;

SELECT * FROM actor_information;


--Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each.

La consulta crea una vista llamada "actor_information", que es como una tabla virtual que almacenará el resultado de la consulta para que podamos usarla más fácilmente en el futuro.

En la consulta, queremos mostrar información sobre los actores, como su ID, primer nombre, apellido y la cantidad de películas en las que han actuado.

Para hacerlo, combinamos los datos de dos tablas: "actor" y "film_actor". La tabla "actor" contiene información sobre los actores, y la tabla "film_actor" contiene información sobre qué actores han actuado en qué películas.

El truco es usar un "LEFT JOIN", que nos permite combinar la tabla "actor" con la tabla "film_actor" usando el ID del actor. Esto asegura que incluso si un actor no ha actuado en ninguna película, aún aparecerá en la vista con un recuento de películas igual a cero.

Después de combinar las tablas, usamos "GROUP BY" para agrupar los resultados por actor. Esto significa que veremos una fila para cada actor con su ID, primer nombre, apellido y el recuento total de películas en las que ha actuado, evitando duplicados para un mismo actor.

Una vez que ejecutamos esta consulta y creamos la vista "actor_information", podremos usarla para obtener rápidamente la información de los actores sin tener que escribir la consulta completa cada vez que necesitemos esos datos. Es una forma de simplificar nuestras consultas futuras y tener la información organizada de manera más clara.



--Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.
Vistas Materializadas: Una Explicación Sencilla

Las vistas materializadas son como "fotografías" precalculadas de los datos de una o más tablas en una base de datos. A diferencia de las vistas normales que muestran datos en tiempo real, las vistas materializadas almacenan los resultados de una consulta como una tabla física.

¿Por qué se usan?
1. Mejora del rendimiento: Ayudan a acelerar las consultas complicadas o frecuentes, evitando repetir cálculos costosos en grandes conjuntos de datos.
2. Resumen de datos: Son útiles para mostrar información resumida, agregada o transformada, lo que facilita el acceso a datos importantes de manera rápida.
3. Procesamiento sin conexión: Se pueden utilizar para análisis y reportes sin necesidad de acceder a la base de datos en tiempo real.
4. Reducir carga: Al proporcionar una fuente de datos alternativa, alivian la carga en las tablas principales, especialmente en sistemas con muchas consultas de lectura.
5. Trabajar con datos remotos: También son útiles para almacenar datos de bases de datos remotas, lo que facilita la gestión de sistemas distribuidos.

Alternativas:
1. Vistas Regulares: Son tablas virtuales que no almacenan datos, sino que consultan los datos en tiempo real cada vez que se accede a ellas.
2. Caché: Guardar resultados de consultas en memoria para agilizar futuras consultas repetidas.
3. Indexación: Crear índices en columnas frecuentemente consultadas para mejorar el rendimiento.

DBMS que las soportan:
Las vistas materializadas son compatibles con varios sistemas de bases de datos, como Oracle Database, PostgreSQL, Microsoft SQL Server y IBM Db2, entre otros. Sin embargo, en mi última actualización en septiembre de 2021, MySQL no tenía soporte incorporado para vistas materializadas, aunque algunas soluciones de terceros podrían proporcionar funcionalidad similar.


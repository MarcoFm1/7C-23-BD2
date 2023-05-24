use sakila;


/* Get the amount of cities per country in the database. Sort them by country, country_id. */
SELECT country.country as Pais, count(city) as Ciudades
FROM country
JOIN city on country.country_id = city.country_id
GROUP BY country.country_id
ORDER BY country.country, count(city);


/* Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest */
SELECT country.country as Pais, count(city) as Ciudades
FROM country
JOIN city on country.country_id = city.country_id
GROUP BY country.country_id
HAVING count(city) >10
ORDER BY count(city) DESC;


/* Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films. */
SELECT SUM(p.amount) AS TodaLaPlataGastada, concat(c.last_name, ' ', c.first_name) as nombre, a.address as direccion, COUNT(r.rental_id) as CantPEliculasRentadas
FROM customer c
JOIN address a on c.address_id = a.address_id
JOIN rental r on c.customer_id = r.customer_id
JOIN payment p on c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY TodaLaPlataGastada DESC;


/*Which film categories have the larger film duration (comparing average)?*/
SELECT c.name as Categoria, AVG(f.length) as DuracionPromedio
FROM film_category fc
JOIN category c on fc.category_id = c.category_id
JOIN film f on fc.film_id = f.film_id 
GROUP BY c.category_id
ORDER BY DuracionPromedio DESC;



/*Show sales per film rating*/
SELECT f.rating as ClasificacionFCBM, count(r.rental_id) as CantVentas, SUM(p.amount) as PrecioTotalVentas
FROM film f
JOIN inventory i on f.film_id = i.film_id
JOIN rental r on i.inventory_id = r.inventory_id
JOIN payment p on r.rental_id = p.rental_id
GROUP BY f.rating;

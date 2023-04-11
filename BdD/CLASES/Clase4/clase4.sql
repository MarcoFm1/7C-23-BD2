use sakila

/*Show title and special_features of films that are PG-13*/
SELECT title, special_features FROM film WHERE rating = 'PG-13';



/*Get a list of all the different films duration.*/
SELECT DISTINCT length FROM film;


/*Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00*/
SELECT title, rental_rate, replacement_cost FROM film WHERE replacement_cost BETWEEN 20 AND 24;


/*Show title, category and rating of films that have 'Behind the Scenes' as special_features*/
SELECT title, category.name, rating FROM film INNER JOIN film_category ON film.film_id = film_category.film_id INNER JOIN category ON film_category.category_id = category.category_id WHERE special_features LIKE '%Behind the Scenes%';


/*Show first name and last name of actors that acted in 'ZOOLANDER FICTION'*/
SELECT actor.first_name, actor.last_name FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id INNER JOIN film ON film.film_id = film_actor.film_id WHERE film.title = 'ZOOLANDER FICTION';


/*Show the address, city and country of the store with id 1*/
SELECT address, city, country FROM store INNER JOIN address ON store.address_id = address.address_id INNER JOIN city ON address.city_id = city.city_id INNER JOIN country ON city.country_id = country.country_id WHERE store.store_id = 1;


/*Show pair of film titles and rating of films that have the same rating.*/
SELECT f1.title, f1.rating, f2.title, f2.rating FROM film f1, film f2 WHERE f1.film_id < f2.film_id AND f1.rating = f2.rating;


/*Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).*/
SELECT film.title, manager.first_name, manager.last_name FROM inventory INNER JOIN film ON inventory.film_id = film.film_id INNER JOIN store ON inventory.store_id = store.store_id INNER JOIN staff manager ON store.manager_staff_id = manager.staff_id WHERE store.store_id = 2 AND inventory.available = 1;





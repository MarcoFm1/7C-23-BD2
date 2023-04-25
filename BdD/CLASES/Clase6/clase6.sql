/*List all the actors that share the last name. Show them in order*/
SELECT first_name, last_name  FROM actor WHERE last_name IN (SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) > 1) ORDER BY last_name, first_name;

/*Find actors that don't work in any film*/
SELECT first_name, last_name FROM actor WHERE actor_id NOT IN (SELECT DISTINCT actor_id FROM film_actor);

/*Find customers that rented only one film*/
SELECT first_name, last_name FROM customer WHERE customer_id IN (SELECT customer_id FROM rental GROUP BY customer_id HAVING COUNT(*) = 1);

/*Find customers that rented more than one film*/
SELECT first_name, last_name FROM customer WHERE customer_id IN (SELECT customer_id FROM rental GROUP BY customer_id HAVING COUNT(*) > 1);

/*List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'*/
SELECT a.first_name, a.actor_id FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id JOIN film f ON f.film_id = fa.film_id WHERE f.title = 'BETRAYED REAR' OR a.actor_id IN (SELECT a2.actor_id FROM actor a2 JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id JOIN film f2 ON f2.film_id = fa2.film_id WHERE f2.title = 'CATCH AMISTAD' group by actor_id ) group by actor_id; 

/*List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'*/
SELECT a.first_name, a.actor_id FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id JOIN film f ON f.film_id = fa.film_id WHERE f.title = 'BETRAYED REAR' AND a.actor_id NOT IN (SELECT a2.actor_id FROM actor a2 JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id JOIN film f2 ON f2.film_id = fa2.film_id WHERE f2.title = 'CATCH AMISTAD');

/*List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'*/
SELECT a.first_name, a.actor_id FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id JOIN film f ON f.film_id = fa.film_id WHERE f.title = 'BETRAYED REAR' AND a.actor_id IN (SELECT a2.actor_id FROM actor a2 JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id JOIN film f2 ON f2.film_id = fa2.film_id WHERE f2.title = 'CATCH AMISTAD');

/*List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'*/
SELECT a.first_name, a.actor_id FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id JOIN film f ON f.film_id = fa.film_id WHERE a.actor_id NOT IN (SELECT a2.actor_id FROM actor a2 JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id JOIN film f2 ON f2.film_id = fa2.film_id WHERE f2.title = 'BETRAYED REAR' or f2.title = 'CATCH AMISTAD' group by a.actor_id ) group by a.actor_id;




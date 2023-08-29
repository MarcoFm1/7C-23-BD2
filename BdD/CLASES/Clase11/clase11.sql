-- 4 Find all the film titles that are not in the inventory.
SELECT f.title, i.film_id FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id IS NULL;

-- 5 Find all the films that are in the inventory but were never rented.
    -- Show title and inventory_id.
    -- This exercise is complicated.
    -- hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null

SELECT f.title, i.inventory_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE i.inventory_id NOT IN (
SELECT inventory_id FROM rental);

-- 6 Generate a report with:
    -- customer (first, last) name, store id, film title,
    -- when the film was rented and returned for each of these customers
    -- order by store_id, customer last_name
SELECT CONCAT(c.first_name, ' ', c.last_name), c.store_id, f.title, r.rental_date, r.return_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY c.store_id, c.last_name;

-- 7 Show sales per store (money of rented films)
    -- show store's city, country, manager info and total sales (money)
    -- (optional) Use concat to show city and country and manager first and last name
SELECT CONCAT(s.city, ', ', s.country), CONCAT(m.first_name, ' ', m.last_name), SUM(p.amount)
FROM store s
JOIN staff m ON s.manager_staff_id = m.staff_id
LEFT JOIN customer c ON s.store_id = c.store_id
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- 8 Which actor has appeared in the most films?
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name), COUNT(fa.film_id)
FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY COUNT(fa.film_id);

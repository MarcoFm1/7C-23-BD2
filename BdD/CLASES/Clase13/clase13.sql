-- Write the statements with all the needed subqueries, do not use hard-coded ids unless is specified. Check which fields are mandatory and which ones can be ommited (use default value).

--Add a new customer   To store 1. For address use an existing address. The one that has the biggest address_id in 'United States'

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active)
select 1, 'Emma', 'Myers', 'em2000@gmail.com', MAX(a.address_id), 1 from address a
where (select c.country_id from country c, city c1
		where c.country = "United States"
		and c.country_id = c1.country_id and c1.city_id = a.city_id);
		
select * from customer
where last_name = "Myers";


-- 2. Add a rental   Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.  Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.  select any staff_id from Store 2.

INSERT INTO rental
(rental_date, inventory_id, customer_id, return_date, staff_id)
select CURRENT_TIMESTAMP, 
		(select MAX(i.inventory_id) from inventory i
		 inner join film f on f.film_id = i.film_id
		 where f.title = "ZOOLANDER FICTION" 
		 limit 1), 
		 600, 
		 null,
		 (select x.staff_id from staff x
		  inner join store s on s.store_id = x.store_id
		  where s.store_id = 2
		  limit 1);

-- 3. update film year based on the rating   For example if rating is 'G' release date will be '2001   You can choose the mapping between rating and year   Write as many statements are needed.

update film
set release_year = '2001' 
where rating = "G";

update film
set release_year = '1977'
where rating = "PG-13";

update film
set release_year = '1980'
where rating = "PG";

update film
set release_year = '1983'
where rating = "R";

update film
set release_year = '1998'
where rating = "NC-17";


-- 4. Return a film   Write the necessary statements and queries for the following steps   Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example   Use the id to return the film.

SELECT rental_id, rental_rate, customer_id, staff_id FROM film f
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id = i.inventory_id 
where r.return_date is null 
limit 1; 

update rental
set return_date = CURRENT_TIMESTAMP
where rental_id = 11496;


-- 5. Try to delete a film   Check what happens, describe what to do   Write all the necessary delete statements to entirely remove the film from the DB.

delete from payment
where rental_id in (select rental_id  from rental
                    inner join inventory using (inventory_id) 
                    where film_id = 1);

delete from rental where inventory_id in (select inventory_id from inventory
                       where film_id = 1);                    
delete from inventory where film_id = 1;
delete film_actor from film_actor where film_id = 1;
delete film_category from film_category where film_id = 1;
delete film from film where film_id = 1;


-- 6. Rent a film   Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere   Add a rental entr   Add a payment entr   Use sub-queries for everything, except for the inventory id that can be used directly in the queries.

SELECT inventory_id, film_id FROM inventory
WHERE inventory_id not in (select inventory_id
                           from inventory
	                       inner join rental using (inventory_id)
	                       where return_date is null)
INSERT INTO rental
(rental_date, inventory_id, customer_id, staff_id)
VALUE( CURRENT_DATE(), 10,
(SELECT customer_id FROM customer ORDER BY customer_id DESC limit 1),
(SELECT staff_id FROM staff WHERE store_id = (SELECT store_id FROM inventory WHERE inventory_id = 10))
);
INSERT INTO payment
(customer_id, staff_id, rental_id, amount, payment_date)
VALUE(
(SELECT customer_id FROM customer ORDER BY customer_id DESC limit 1),
(SELECT staff_id FROM staff LIMIT 1),
(SELECT rental_id FROM rental ORDER BY rental_id DESC limit 1) ,
(SELECT rental_rate FROM film WHERE film_id = 2),
CURRENT_DATE());

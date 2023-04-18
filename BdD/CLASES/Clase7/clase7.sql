use sakila

/*Find the films with less duration, show the title and rating.*/

SELECT title, rating FROM film WHERE length = (SELECT MIN(length) from film);

/*Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty resultset.*/

SELECT title, length FROM film WHERE length = (SELECT MIN(length) FROM film);

/*Generate a report with list of customers showing the lowest payments done by each of them. Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.*/



/*Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.*/

SELECT customer_id, first_name, last_name FROM customer WHERE payment = (SELECT MAX(amount) FROM payment);
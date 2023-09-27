-- 1. Write a function that returns the amount of copies of a film in a store in sakila-db. Pass either the film id or the film name and the store id.
select f.title, count(i.film_id) as amount, group_concat(s.store_id) as avaiable_stores from film f
join inventory i on i.film_id = f.film_id
join store s on s.store_id = i.store_id
group by f.title;

select s.store_id, f.title, count(i.film_id) as amount from store s
join inventory i on i.store_id = s.store_id
join film f on f.film_id = i.film_id
group by s.store_id, f.title
order by f.title asc;

select f.title as film, s.store_id as store, count(i.film_id) as amount from film f
join inventory i on i.film_id = f.film_id
join store s on s.store_id = i.store_id
where f.title = "ZORRO ARK" 
and s.store_id = 2
group by f.title, s.store_id;

-- 2. Write a stored procedure with an output parameter that contains a list of customer first and last names separated by ";", that live in a certain country. You pass the country it gives you the list of people living there. USE A CURSOR, do not use any aggregation function (ike CONTCAT_WS.DELIMITER //

drop procedure if exists countryClients;
create procedure countryClients(
    in pais varchar(50), 
    out client_list varchar(255)
)
begin
    declare done int default 0;
    declare name varchar(45);
    declare surname varchar(45);

    declare cur cursor for
        select first_name, last_name
        from customer
        where address_id in (
            select address_id
            from address
            where city_id in (
                select city_id
                from city
                where country_id = (
                    select country_id
                    from country
                    where country = pais
                )
            )
        );
    declare continue handler for not found set done = 1;

    set client_list = '';
    open cur;

    read_loop: loop
        fetch cur into name, surname;
        if done then
            leave read_loop; end if;

        if client_list = '' then
            set client_list = concat(name, ' ', surname);
        else
            set client_list = concat(client_list, ';', name, ' ', surname);
        end if;
    end loop;

    close cur;
end;


DELIMITER ;

-- 3. Review the function inventory_in_stock and the procedure film_in_stock explain the code, write usage examples.

-- inventory_in_stock: Esta función necesita dos cosas como entrada: el ID de una película y el ID de una tienda. Luego, devuelve un valor que es verdadero si la película está disponible en stock en la tienda seleccionada, o falso si no lo está. Ejemplo: Puedes usarlo así para verificar si la película con ID 1 está en stock en la tienda con ID 1:
-- Ejemplo:
SELECT inventory_in_stock(1, 1);


-- film_in_stock: Este procedimiento se utiliza para revisar si una película está disponible en una tienda específica. Si está disponible, te mostrará la información de la película y de la tienda. Por ejemplo, puedes llamar a este procedimiento de la siguiente manera para verificar si la película con ID 1 está en stock en la tienda con ID 1:
-- Ejemplo"
CALL film_in_stock(1, 1);

-- El resultado puede ser uno de dos posibles:

-- Si la película está disponible: mostrará la información de la película y la tienda.
-- Si la película no está disponible: mostrará un mensaje diciendo que la película no está en stock en esa tienda debido a la falta de existencias.




CREATE DATABASE imdb;
USE imdb;

CREATE TABLE film (film_id INT AUTO_INCREMENT PRIMARY KEY,title VARCHAR(255),description TEXT,release_year INT,last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE actor (actor_id INT AUTO_INCREMENT PRIMARY KEY,first_name VARCHAR(255),last_name VARCHAR(255),last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE film_actor (actor_id INT,film_id INT,PRIMARY KEY (actor_id, film_id),FOREIGN KEY (actor_id) REFERENCES actor(actor_id),FOREIGN KEY (film_id) REFERENCES film(film_id));


INSERT INTO actor (first_name, last_name) VALUES
('Tom', 'Hanks'),
('Emma', 'Watson'),
('Leonardo', 'DiCaprio');

INSERT INTO film (title, description, release_year) VALUES
('Forrest Gump', 'Un hombre con un coeficiente intelectual bajo ha logrado grandes cosas en su vida y ha estado presente durante eventos históricos significativos, superando en cada caso lo que cualquiera imaginaba que podría hacer. Sin embargo, a pesar de todas las cosas que ha logrado, su verdadero amor se le escapa. "Forrest Gump" es la historia de un hombre que superó sus desafíos, y que demostró que la determinación, el coraje y el amor son más importantes que la capacidad.', 1994),
('Sueño de fuga', 'Enmarcado en la década de 1940 por el doble asesinato de su esposa y su amante, el respetable banquero Andy Dufresne comienza una nueva vida en la prisión de Shawshank, donde pone sus habilidades contables al servicio de un director amoral. Durante su largo tiempo en prisión, Dufresne es admirado por los otros reclusos, incluido un preso mayor llamado Red, por su integridad y su inquebrantable sentido de la esperanza.', 1994),
('Titanic', '84 años después, una mujer de 101 años llamada Rose DeWitt Bukater le cuenta la historia a su nieta Lizzy Calvert, Brock Lovett, Lewis Bodine, Bobby Buell y Anatoly Mikailavich en el Keldysh sobre su vida en el Titanic, el 10 de abril de 1912, cuando la joven Rose aborda el barco')

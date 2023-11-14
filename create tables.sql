CREATE TABLE IF NOT EXISTS country_cleaned 
(country_id SERIAL PRIMARY KEY, 
country VARCHAR(255) NOT NULL);

CREATE TABLE IF NOT EXISTS city_cleaned(
city_id SERIAL PRIMARY KEY,
city VARCHAR(50) NOT NULL,
country_id SMALLINT,
CONSTRAINT fk_city
FOREIGN KEY(country_id) 
REFERENCES country_cleaned(country_id));

CREATE TABLE IF NOT EXISTS address_cleaned 
(address_id SERIAL PRIMARY KEY, 
address VARCHAR(50) NOT NULL,
address2 VARCHAR(50) NOT NULL,
district VARCHAR(20) NOT NULL,
city_id SMALLINT,
postal_code VARCHAR(10) NOT NULL,
phone VARCHAR(20) NOT NULL,
CONSTRAINT fk_city
FOREIGN KEY(city_id) 
REFERENCES city_cleaned(city_id));

CREATE TABLE IF NOT EXISTS customer_cleaned 
(customer_id SERIAL PRIMARY KEY, 
full_name VARCHAR(255) NOT NULL,
email VARCHAR(50) NOT NULL,
address_id SMALLINT, 
activebool BOOLEAN NOT NULL,
active INT NOT NULL,
CONSTRAINT fk_address
FOREIGN KEY(address_id) 
REFERENCES address_cleaned(address_id));


CREATE TABLE IF NOT EXISTS rental_cleaned
(rental_id SERIAL PRIMARY KEY,
 rental_date TIMESTAMP NOT NULL,
 rental_year INT,
 rental_month INT,
 rental_day INT,
 customer_id SMALLINT, 
 return_date TIMESTAMP NOT NULL,
CONSTRAINT fk_customer
FOREIGN KEY(customer_id) 
REFERENCES customer_cleaned(customer_id));


CREATE TABLE IF NOT EXISTS payment_cleaned
(payment_id SERIAL PRIMARY KEY,
 customer_id SMALLINT,
 rental_id SMALLINT,
 amount NUMERIC (5,2),
 payment_date TIMESTAMP NOT NULL,
 payment_year INT,
 payment_month INT,
 payment_day INT,
CONSTRAINT fk_customer
FOREIGN KEY(customer_id) 
REFERENCES customer_cleaned(customer_id),
CONSTRAINT fk_rental
FOREIGN KEY(rental_id) 
REFERENCES rental_cleaned(rental_id));

CREATE TABLE IF NOT EXISTS language_cleaned
(language_id SERIAL PRIMARY KEY, 
name VARCHAR(20) NOT NULL);


CREATE TABLE IF NOT EXISTS category_cleaned
(category_id SERIAL PRIMARY KEY, 
name VARCHAR(20) NOT NULL);


CREATE TABLE IF NOT EXISTS actor_cleaned
(actor_id SERIAL PRIMARY KEY, 
full_name VARCHAR(255) NOT NULL);

CREATE TABLE IF NOT EXISTS film_cleaned
(film_id SERIAL PRIMARY KEY, 
title VARCHAR(255) NOT NULL,
description TEXT NOT NULL,
 release_year INT,
 language_id SMALLINT NOT NULL,
 rental_duration SMALLINT NOT NULL, 
 rental_rate NUMERIC (5,2) NOT NULL,
 length SMALLINT,
 replacement_cost NUMERIC (5,2) NOT NULL,
 rating VARCHAR(10),
CONSTRAINT fk_language
FOREIGN KEY(language_id) 
REFERENCES language_cleaned(language_id));

CREATE TABLE IF NOT EXISTS film_actor_cleaned
(actor_id SMALLINT NOT NULL, 
film_id SMALLINT NOT NULL, 
CONSTRAINT fk_actor
FOREIGN KEY(actor_id) 
REFERENCES actor_cleaned(actor_id),
CONSTRAINT fk_film
FOREIGN KEY(film_id) 
REFERENCES film_cleaned(film_id));


CREATE TABLE IF NOT EXISTS film_category_cleaned
(category_id SMALLINT NOT NULL, 
film_id SMALLINT NOT NULL, 
CONSTRAINT fk_category
FOREIGN KEY(category_id) 
REFERENCES category_cleaned(category_id),
CONSTRAINT fk_film
FOREIGN KEY(film_id) 
REFERENCES film_cleaned(film_id));



CREATE OR REPLACE FUNCTION insert_amount()
RETURNS TRIGGER
AS
$$
BEGIN
    IF NEW.amount> 0 THEN
    		new.amount = 0;
    END IF;

RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_amount
  BEFORE INSERT
  ON payment_cleaned
  FOR EACH ROW
  EXECUTE PROCEDURE insert_amount();
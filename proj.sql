-- PART B: custom transformation with a user-defined function to transform the date field in the detailed table to a written format for better readability.  
CREATE OR REPLACE FUNCTION fn_format_rental_date(date_input DATE) 
RETURNS TEXT AS $$ 
BEGIN 
 RETURN TO_CHAR(date_input, 'Mon FMDDth, YYYY'); 
END; 
$$ LANGUAGE plpgsql;  

-- PART C: creates detailed and summary tables.  
-- Detailed report table 
CREATE TABLE genre_rental_detailed ( 
 rental_id INTEGER, 
 rental_date TEXT, 
 title TEXT, 
 genre TEXT 
);  

-- Summary report table 
CREATE TABLE genre_rental_summary ( 
 genre TEXT PRIMARY KEY, 
 total_rentals INTEGER 
);  

-- PART D: extracts raw data needed for the detailed data table. 
INSERT INTO genre_rental_detailed (rental_id, rental_date, title, genre) 
SELECT 
 r.rental_id, 
 fn_format_rental_date(r.rental_date::DATE), 
 f.title, c.name AS genre 
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id;  

-- PART E: creates a trigger on the detailed table that continually updates the summary table as data is added to the detailed table.  
CREATE OR REPLACE FUNCTION trg_update_summary() 
RETURNS TRIGGER AS $$ 
BEGIN 
 INSERT INTO genre_rental_summary (genre, total_rentals) 
 VALUES ( NEW.genre, 1 ) 
 ON CONFLICT (genre) 
 DO UPDATE SET total_rentals = genre_rental_summary.total_rentals + 1;  
RETURN NEW;   
END; 
$$ LANGUAGE plpgsql;  

-- Trigger CREATE TRIGGER trg_after_insert_detailed AFTER INSERT ON genre_rental_detailed 
FOR EACH ROW 
EXECUTE FUNCTION trg_update_summary();  

-- PART F: stored procedure to refresh both the detailed table and summary table. Clears the contents of the detailed table and summary table and performs the raw data extraction from part D.  
CREATE OR REPLACE PROCEDURE refresh_genre_report() 
LANGUAGE plpgsql 
AS $$ 
BEGIN 
 TRUNCATE TABLE genre_rental_detailed; 
 TRUNCATE TABLE genre_rental_summary;  

INSERT INTO genre_rental_detailed (rental_id, rental_date, title, genre)   
SELECT   
    r.rental_id,   
    fn_format_rental_date(r.rental_date),   
    f.title, c.name   
FROM  
    rental r 
JOIN  
    inventory i ON r.inventory_id = i.inventory_id   
JOIN  
    film f ON i.film_id = f.film_id   
JOIN  
    film_category fc ON f.film_id = fc.film_id   
JOIN  
    category c ON fc.category_id = c.category_id;   
END;
$$; 

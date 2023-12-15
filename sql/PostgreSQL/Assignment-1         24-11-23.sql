--ASSIGNMENT 1
--USE test DB

SELECT * FROM tbldirectors
SELECT * FROM tblactors
SELECT * FROM tblmovies

INSERT INTO public.directors(director_id, first_name, last_name) 
VALUES  
(101,'Joshna','Priya'), 
(102,'Sri','Krishna'), 
(103,'Varsha','Mahadev'), 
(104,'Sandhya','Shree'), 
(105,'Anusha','Gowda'), 
(106'Joyline','Maxima');


INSERT INTO public.tblmovies( 
movie_id, movie_name, movie_length, movie_lang,movie_certificate, release_date, 
director_id) 
VALUES  

(1, 'Leo', 250, 'Tamil', 'B', '2023-11-08', 101), 
(2, 'Mersal', 250, 'Tamil', 'B', '2023-10-08', 102), 
(3, 'Ghili', 250, 'Tamil', 'B', '2023-09-08', 103), 
(4, 'Master', 250, 'Tamil', 'B', '2023-08-08', 104), 
(5, 'Bigil', 250, 'Tamil', 'B', '2023-07-08',105), 
(6, 'Thuppakki', 250, 'Tamil', 'B', '2023-06-08', 106), 
(7, 'Theri', 250, 'Tamil', 'B', '2023-05-08', 106), 
(8, 'Kushi', 250, 'Tamil', 'B', '2023-04-08', 101), 
(9, 'Thalaivaa', 250, 'Tamil', 'B', '2023-03-08', 102), 
(10, 'Nanban', 250, 'Tamil', 'B', '2023-02-08', 103); 


INSERT INTO public.tblactors( 
actor_id, first_name, last_name, gender, date_of_birth, movie_id) 
VALUES  
(1, 'Vijay', 'Joseph', 'M', '1980-11-08', 10), 
(2, 'vijay', 'Sethupathi', 'M', '1981-11-08', 9), 
(3, 'Medona', 'Sebastin', 'F', '1982-11-08', 8), 
(4, 'Samantha', 'RuthPrabhu', 'F', '1983-11-08', 7), 
(5, 'Rajini', 'Kanth', 'M', '1984-11-08', 6), 
(6, 'Jesmitha', 'Vegus', 'F', '1985-11-08', 5), 
(7, 'Dilip', 'Raju', 'M', '1986-11-08', 4), 
(8, 'Sanjay', 'Datt', 'M', '1987-11-08', 3), 
(9, 'Priya', 'Peter', 'F', '1988-11-08', 2), 
(10, 'Joshna', 'John', 'F', '1989-11-08', 1);


-- Queries 
 
-- 1.Display Movie name, movie language and release date from movies table. 
SELECT * FROM tbldirectors
SELECT * FROM tblactors
SELECT * FROM tblmovies


SELECT movie_name,movie_lang,release_date
FROM tblmovies ;

-- 2.Display only 'Kannada' movies from movies table.

SELECT movie_name,movie_lang,release_date
FROM tblmovies WHERE movie_lang='Kannada';

-- 3.Display movies released before 1st Jan 2011. 

SELECT movie_name,movie_lang,release_date
FROM tblmovies WHERE EXTRACT(YEAR FROM release_date)<2011

-- 4.Display Hindi movies with movie duration more than 150 minutes. 

SELECT movie_name,movie_lang,release_date
FROM tblmovies WHERE movie_lang='Hindi' AND movie_length>150;

-- 5.Display movies of director id 3 or Kannada language. 

SELECT movie_name,movie_lang,release_date
FROM tblmovies WHERE movie_lang='Kannada' OR director_id=103;

-- 6.Display movies released in the year 2023. 

SELECT movie_name
FROM tblmovies WHERE EXTRACT(YEAR FROM release_date)=2023;

-- 7.Display movies that can be watched below 15 years. 

SELECT movie_name
FROM tblmovies WHERE movie_certificate='U';

-- 8.Display movies that are released after the year 2015 and directed by directorid 3. 

SELECT movie_name
FROM tblmovies WHERE EXTRACT(YEAR FROM release_date)>2015 AND director_id=103;

-- 9.Display all other language movies except Hindi language. 

SELECT movie_name,movie_lang
FROM tblmovies WHERE movie_lang!='Hindi';

-- 10.Display movies whose language name ends with 'u'. 


SELECT movie_name,movie_lang
FROM tblmovies WHERE movie_lang LIKE '%u';


-- 11.Display movies whose language starts with 'm'. 

SELECT movie_name,movie_lang
FROM tblmovies WHERE movie_lang LIKE 'm%';

-- 12.Display movies with language name that has only 5 characters. 

SELECT movie_name,movie_lang
FROM tblmovies WHERE movie_lang like '_____';
================================================== OR =====================================================
LENGTH(movie_lang)=5 ;

-- 13.Display the actors who were born before the year 1980. 

SELECT actor_id,first_name,last_name
FROM tblactors
WHERE EXTRACT(YEAR FROM date_of_birth)<1980;


-- 14.Display the youngest actor from the actors table. 

SELECT actor_id,first_name,last_name
FROM tblactors
ORDER BY date_of_birth DESC
OFFSET 0 ROWS
FETCH FIRST 1 ROWS WITH TIES;
============================================ OR ============================================================
SELECT MIN(date_of_birth),first_name FROM tblactors GROUP BY first_name
SELECT * FROM tblactors


-- 15.Display the oldest actor from the actors table. 

SELECT actor_id,first_name,last_name
FROM tblactors
ORDER BY date_of_birth 
OFFSET 0 ROWS
FETCH FIRST 1 ROWS WITH TIES;


-- 16.Display all the female actresses whose ages are between 30 and 35. 
SELECT * FROM tbldirectors
SELECT * FROM tblactors
SELECT * FROM tblmovies

SELECT * FROM tblactors
WHERE gender='F' AND EXTRACT(YEAR FROM AGE(NOW(),DATE_OF_BIRTH)) BETWEEN 30 AND 35

--- 17.Display the actors whose movie ids are in 1 to 5. 

SELECT * FROM tblactors
WHERE movie_id BETWEEN 1 AND 5

-- 18.Display the longest duration movie from movies table. 

SELECT *
FROM tblmovies
ORDER BY movie_length DESC
OFFSET 0 ROWS
FETCH FIRST 1 ROWS WITH TIES;


-- 19.Display the shortest duration movie from movies table. 

SELECT *
FROM tblmovies
ORDER BY movie_length 
OFFSET 0 ROWS
FETCH FIRST 1 ROWS WITH TIES;

-- 20.Display the actors whose name starts with vowels. 
SELECT * FROM tbldirectors
SELECT * FROM tblactors
SELECT * FROM tblmovies

-- SELECT *
-- FROM tblactors
-- WHERE first_name ~ '^[aeiouAEIOU].+$';

SELECT *
FROM tblactors
WHERE first_name ~ '^[aeiouAEIOU].$';
--WHERE first_name ILIKE '[AEIOU]%'


-- 21.Display all the records from tblactors by sorting the data based on the fist_name in the 
-- ascending order and date of birth in the descending order. 

SELECT * 
FROM tblactors
ORDER BY first_name,date_of_birth DESC


-- 22.Write a query to  return the data related to movies by arranging the data in ascending order 
-- based on the movie_id and also fetch the data from the fifth value to the twentieth value. 
 
SELECT * FROM tbldirectors
SELECT * FROM tblactors
SELECT * FROM tblmovies


SELECT * 
FROM tblmovies
ORDER BY movie_id
OFFSET 5 ROWS
FETCH FIRST 20 ROWS WITH TIES;

======================================== OR ===========================================================

------------------------------------------------------------------------------------------------------
-- PATTERN MATCHING :

-- select 1
-- where 'gre%' not like 'gre/%'

SELECT TRUE	
WHERE 'POSTgre' ~~* 'pos%' ESCAPE '%'

SELECT 1
WHERE 'string' SIMILAR TO 'str%' ESCAPE '%'

SELECT true
WHERE 'sTRING' like starts_with('s') '^@sTRING'




 
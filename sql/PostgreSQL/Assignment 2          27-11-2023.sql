
-- Module 7: 

-- 1.List the different languages of movies. 

SELECT DISTINCT movie_lang
FROM tblmovies
 
-- 2.Display the unique first names of all directors in ascending order by 
-- their first name and then for each group of duplicates, keep the first row in the 
-- returned result set. 

SELECT DISTINCT ON (first_name)*
FROM tbldirectors
ORDER BY first_name

 
-- 3. write a query to retrieve 4 records starting from the fourth one, to 
-- display the actor ID, name (first_name, last_name) and date of birth, and 
-- arrange the result as Bottom N rows from the actors table according to their 
-- date of birth.   

 SELECT actor_id,CONCAT(first_name,' ',last_name) AS "Name",date_of_birth
 FROM tblactors
 ORDER BY date_of_birth,actor_id
 LIMIT 3 OFFSET 4 ROWS 
 
-- 4.Write a query to get the first names of the directors who holds the letter 
-- 'S' or 'J' in the first name.     

SELECT first_name
FROM tbldirectors
WHERE first_name LIKE '%S%' OR first_name LIKE '%J%'
 
-- 5.Write a query to find the movie name and language of the movie of all 
-- the movies where the director name is Joshna. 


SELECT movie_name,movie_lang
FROM tblmovies m INNER JOIN tbldirectors d ON m.director_id=d.director_id
WHERE d.first_name='Joshna'

 
-- Module 8: 
 
-- 6.Write a query to find the number of directors available in the movies 
-- table. 

 
 SELECT COUNT(DISTINCT director_id) AS "Number of Directors"
 FROM tblmovies
 
-- 7. Write a query to find the total length of the movies available in the 
-- movies table. 

 SELECT SUM(movie_length) as "Total Length"
 FROM tblmovies
 
-- 8.Write a query to get the average of movie length for all the directors 
-- who are working for more than 1 movie. 


 SELECT director_id,AVG(movie_length) as "Average Length"
 FROM tblmovies
 GROUP BY director_id
 HAVING COUNT(movie_id)>1
 
-- 9.Write a query to find the age of the actor vijay for the year 2001-04-10. 

 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 

 
 SELECT first_name,AGE('2001-04-10',date_of_birth)
 FROM tblactors
 WHERE first_name='Vijay' 
 
 --SELECT AGE(NOW(),'2020-10-22')
 
-- 10.Write a query to fetch the week of this release date 2020-10-10 
-- 13:00:10. 
--pending
--SELECT TO_TIMESTAMP('2020-10-10','YYYY-MM-DD')

--SELECT EXTRACT('Week' FROM DATE '2020-10-10 13:00:10')

SELECT to_char( release_date, 'w') AS "Week",EXTRACT(YEAR FROM release_date) AS "Year"
FROM tblmovies
WHERE release_date='2020-10-10'

		
-- 11.Write a query to fetch the day of the week and year for this release date 
-- 2020-10-10 13:00:10.        

SELECT to_char( release_date, 'Day') AS "Week",EXTRACT(YEAR FROM release_date) AS "Year"
FROM tblmovies
WHERE release_date='2020-10-10'
 
-- 12.Write a query to convert the given string '20201114' into date and time. 

SELECT '20201114'::timestamp

-- 13.Display Today's date. 
          
SELECT NOW()::DATE AS "Today's Date"
SELECT CURRENT_TIMESTAMP ::DATE;


-- 14.Display Today's date with time. 

 SELECT NOW();
 
 SELECT CURRENT_TIMESTAMP;
 
-- 15.Write a query to add 10 Days 1 Hour 15 Minutes to the current date. 

SELECT NOW() + INTERVAL '10 Days 1 HOURS 15 Minutes'
       
-- 16.Write a query to find the details of those actors who contain eight or 
-- more characters in their first name. 

 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 
SELECT *
FROM tblactors
WHERE LENGTH(first_name)>=8
 
-- 17.Write a query to join the text 'movie' with the movie_name column. 
 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 
SELECT movie_name||' '||'movie' as "Movie Name" FROM tblmovies


-- 18.Write a query to get the actor id, first name and birthday month of an 
-- actor. 
 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies

SELECT actor_id,first_name,EXTRACT(MONTH FROM date_of_birth) AS "DOB Month"
FROM tblactors

-- 19.Write a query to get the actor id, last name to discard the last three 
-- characters. 
  SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 
 SELECT actor_id,left(last_name,length(last_name)-3)
 FROM tblactors

-- 20.Write a query that displays the first name and the character length of 
-- the first name for all directors whose name starts with the letters 'A', 'J' or 'V'. 
-- Give each column an appropriate label. Sort the results by the directors' first 
-- names. 
 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 
 SELECT first_name,length(first_name) AS "Length Of Name"
 FROM tbldirectors
-- WHERE first_name LIKE 'A%' OR first_name LIKE 'J%' OR first_name LIKE 'V%'
 WHERE first_name SIMILAR TO '[AJV]%'
 ORDER BY first_name
 
-- 21.Write a query to display the first word in the movie name if the movie 
-- name contains more than one words. 
--pending
 SELECT * FROM tblmovies
 --pending
 SELECT SPLIT_PART(movie_name,' ',2)
 FROM tblmovies
 
-- Module 9: 

-- 22.Write a query to display the actors name with movie name.   

 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 
 SELECT a.first_name,m.movie_name
 FROM tblactors a LEFT JOIN tblmovies m ON a.movie_id = m.movie_id
 
-- 23.Write a query to make a join with three tables movies, actors, and 
-- directors to display the movie name, director name, and actors date of birth. 
  SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 
 SELECT m.movie_name,d.first_name || ' ' || d.last_name AS "Director Name",
 a.date_of_birth AS "Actor''s DOB"
 FROM tblactors a INNER JOIN tblmovies m ON a.movie_id = m.movie_id
 INNER JOIN tbldirectors d ON m.director_id = d.director_id
 
 
-- 24.Write a query to make a join with two tables directors and movies to 
-- display the status of directors who is currently working for the movies above 
-- 1. 

 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies

 
 SELECT m.director_id,d.first_name || ' '|| d.last_name AS "Director Name",COUNT(m.movie_id) AS "Status"
 FROM tblmovies m RIGHT JOIN tbldirectors d ON m.director_id = d.director_id
 GROUP BY  m.director_id,d.first_name,d.last_name
 ORDER BY m.director_id
 
-- 25.Write a query to make a join with two tables movies and actors to get 
-- the movie name and number of actors working in each movie. 

 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 
 SELECT m.movie_name,COUNT(a.actor_id) AS "No.Of Actors"
 FROM tblmovies m LEFT JOIN tblactors a ON m.movie_id=a.movie_id
 GROUP BY a.movie_id,m.movie_name
 
-- 26.Write a query to display actor id, actors name (first_name, last_name)  
-- and movie name to match ALL records from the movies table with each 
-- record from the actors table.      
 
 SELECT * FROM tblactors
 SELECT * FROM tbldirectors
 SELECT * FROM tblmovies
 
 SELECT m.movie_name,a.actor_id,a.first_name || ' ' || a.last_name AS "Actor Name"
 FROM tblmovies m LEFT JOIN tblactors a ON m.movie_id=a.movie_id
 

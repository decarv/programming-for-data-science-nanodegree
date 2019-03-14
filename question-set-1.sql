/* Udacity 1st project: Investigate a Relational Database */


/* Question Set # 1 */

/* 
Question 1:
We want to understand more about the movies that families are watching. 
The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.
Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out. 
*/

SELECT f.title, c.name, COUNT(r.rental_id) rental_count
FROM category c
JOIN film_category fc
ON 	c.category_id = fc.category_id AND 
    c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY 1, 2
ORDER BY 2, 1;


/* 
Question 2:
Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for. Can you provide a table with the movie titles and divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter) based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories? Make sure to also indicate the category that these family-friendly movies fall into.
*/





SELECT	DISTINCT f.title, 
		c.name, 
		DATE_PART('day', r.return_date - r.rental_date) AS rental_duration, 
		NTILE(4) OVER(ORDER BY (r.return_date - r.rental_date)) AS standard_quartile
FROM category c
JOIN film_category fc
ON 	c.category_id = fc.category_id AND
    c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
ORDER BY 4, 3;


SELECT t1.name,
		CASE
			WHEN t1.standard_quartile = 0 THEN 'first_quarter'
			WHEN t1.standard_quartile = 1 THEN 'second_quarter'
			WHEN t1.standard_quartile = 2 THEN 'third_quarter'
			ELSE 'forth_quarter'
			END AS quarter
FROM (
SELECT	DISTINCT f.title, 
		c.name, 
		DATE_PART('day', r.return_date - r.rental_date) AS rental_duration, 
		NTILE(4) OVER(ORDER BY (r.return_date - r.rental_date)) AS standard_quartile
FROM category c
JOIN film_category fc
ON 	c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
ORDER BY 4, 3
								) t1
WHERE t0.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
					  order by 1;











/* 
Question 2:
Finally, provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category. 
*/


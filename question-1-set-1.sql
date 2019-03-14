/* Udacity 1st project: Investigate a Relational Database */


/* Question Set # 1

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
Question 2: Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for. Can you provide a table with the movie titles and divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter) based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories? Make sure to also indicate the category that these family-friendly movies fall into.

Answer: The question is rather ambiguous about how one subset of data (duration of these family-friendly movies) should be compared to another subset of data (duration that all movies are rented for). As the first possible answer, the two groups could be plotted in a Histogram, which would provide a comparison of how the data is distributed in both datasets. As a third possible answer, a Histogram could provide a comparison of the average rental duration for each film. As the second possible answer, a Bar Chart or a Pie Chart could provide a comparison of the average rental duration for each film category. 
*/

/* 1 */

SELECT	*,
	NTILE(4) OVER(ORDER BY t1.rental_duration) AS standard_quartile
FROM (SELECT f.title, 
			 c.name,
	  		 f.rental_duration
	FROM category c
	JOIN film_category fc
	ON 	c.category_id = fc.category_id AND 
    	c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	JOIN film f
	ON f.film_id = fc.film_id
	ORDER BY 2, 1) t1;

SELECT	*,
	NTILE(4) OVER(ORDER BY t1.rental_duration) AS standard_quartile
FROM (SELECT f.title, 
			 c.name,
	  		 f.rental_duration
	FROM category c
	JOIN film_category fc
	ON 	c.category_id = fc.category_id
	JOIN film f
	ON f.film_id = fc.film_id
	ORDER BY 2, 1) t1;

/* 2 */

SELECT 	t1.title,
		t1.name,
		t1.avg_dur_by_title,
		t1.avg_dur_by_category,
		NTILE(4) OVER(ORDER BY t1.avg_dur_by_category) AS standard_quartile
FROM (	SELECT	f.title, 
		c.name, 
		AVG(f.rental_duration) OVER (PARTITION BY f.title) AS avg_dur_by_title, 
		AVG(f.rental_duration) OVER (PARTITION BY c.name) AS avg_dur_by_category
	FROM category c
	JOIN film_category fc
	ON c.category_id = fc.category_id
	JOIN film f
	ON f.film_id = fc.film_id
	ORDER BY 4, 3) t1
ORDER BY 4, 5;

/* 2 */

SELECT 	t1.title,
		t1.name,
		AVG(t1.avg_dur_by_category),
		NTILE(4) OVER(ORDER BY t1.avg_dur_by_category) AS standard_quartile
FROM (	SELECT	f.title, 
		c.name, 
		AVG(f.rental_duration) OVER (PARTITION BY f.title) AS avg_dur_by_title, 
		AVG(f.rental_duration) OVER (PARTITION BY c.name) AS avg_dur_by_category
	FROM category c
	JOIN film_category fc
	ON c.category_id = fc.category_id
	JOIN film f
	ON f.film_id = fc.film_id
	ORDER BY 4, 3) t1
GROUP BY 1, 2, t1.avg_dur_by_category
ORDER BY 3, 1;

/* 
Question 3:
Finally, provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category. 
*/


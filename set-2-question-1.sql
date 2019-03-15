

/*
We want to find out how the two stores compare in their count of rental orders during every month for all the years 
we have data for. Write a query that returns the store ID for the store, the year and month and the number of rental
orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, 
store ID and count of rental orders fulfilled during that month.
*/

SELECT 	DATE_PART('month', rental_date) AS rental_month, 
		DATE_PART('year', rental_date) AS rental_year,
		se.store_id,
		COUNT(*)
FROM store se
JOIN staff sf
ON se.store_id = sf.store_id
JOIN payment pt
ON sf.staff_id = pt.staff_id
JOIN rental rl
ON rl.rental_id = pt.rental_id
GROUP BY 1, 2, 3
ORDER BY 2, 1;

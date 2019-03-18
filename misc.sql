
/* Search Query 1 */

SELECT sub.title, 
       sub.rental_count, 
	   NTILE(4) OVER(ORDER BY sub.rental_count)
FROM(
SELECT f.title,
       COUNT(*) AS rental_count
  FROM payment AS p
       JOIN rental AS r
	    ON r.rental_id = p.rental_id
	   JOIN inventory AS i
	    ON i.inventory_id = r.inventory_id
	   JOIN film f
	    ON f.film_id = i.film_id
 GROUP BY 1
 ORDER BY 2 DESC) sub;





SELECT f.title,
       c.name,
       COUNT(r.rental_id) AS rental_count
  FROM category AS c
       JOIN film_category AS fc
        ON c.category_id = fc.category_id

       JOIN film AS f
        ON f.film_id = fc.film_id

       JOIN inventory AS i
        ON f.film_id = i.film_id

       JOIN rental AS r
        ON i.inventory_id = r.inventory_id
 GROUP BY 1, 2
 ORDER BY 3 DESC
 LIMIT 20;



/* Set1Question2 */


SELECT f.title, 
       c.name,
	    f.rental_duration, 
	    NTILE(4) OVER(ORDER BY f.rental_duration) AS standard_quartile
  FROM category AS c
	    JOIN film_category AS fc
        ON c.category_id = fc.category_id 
        AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	
       JOIN film AS f
	     ON f.film_id = fc.film_id
 ORDER BY 3;

/* Set1Question2 (for comparison) */

SELECT *,
       NTILE(4) OVER(ORDER BY t1.rental_duration) AS standard_quartile
  FROM (SELECT f.title, 
			     c.name,
	  		     f.rental_duration
	       FROM category AS c
                JOIN film_category AS fc
                 ON c.category_id = fc.category_id
	              
                JOIN film AS f
                 ON f.film_id = fc.film_id
	      ORDER BY 2, 1) AS t1;



/* Set1Question3 */

SELECT t.name,
       t.standard_quartile,
       COUNT(*) AS count_bycategory
  FROM (SELECT c.name,
               f.rental_duration,
               NTILE(4) OVER(ORDER BY f.rental_duration) AS standard_quartile
          FROM category AS c
               JOIN film_category AS fc
                ON c.category_id = fc.category_id 
                AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
               JOIN film AS f
                ON f.film_id = fc.film_id) AS t
 GROUP BY 1, 2
 ORDER BY 1, 2;


/* Set2Question1 */

SELECT DATE_PART('month', DATE_TRUNC('month', r1.rental_date)) AS rental_month, 
       DATE_PART('year', DATE_TRUNC('year', r1.rental_date)) AS rental_year,
       s1.store_id,
       COUNT(*)
  FROM store AS s1
       LEFT JOIN staff AS s2
        ON s1.store_id = s2.store_id
       LEFT JOIN rental r1
        ON s2.staff_id = r1.staff_id
 GROUP BY 1, 2, 3
 ORDER BY 2, 1;


/* Set2Question2 */

WITH t1 AS (SELECT (first_name || ' ' || last_name) AS name, 
                   c.customer_id, 
                   p.amount, 
                   p.payment_date
              FROM customer AS c
                   JOIN payment AS p
                    ON c.customer_id = p.customer_id),

     t2 AS (SELECT t1.customer_id
              FROM t1
             GROUP BY 1
             ORDER BY SUM(t1.amount) DESC
             LIMIT 10)

SELECT t1.name,
       DATE_PART(‘month', t1.payment_date) AS pay_mon, 
       COUNT (*) AS pay_countpermon,
       SUM(t1.amount) AS pay_amount
  FROM t1
       JOIN t2
        ON t1.customer_id = t2.customer_id
 WHERE t1.payment_date BETWEEN '20070101' AND '20080101'
 GROUP BY 1, 2;




/* Set2Question3 */

WITH t1 AS (SELECT (first_name || ' ' || last_name) AS name, 
                   c.customer_id, 
                   p.amount, 
                   p.payment_date
              FROM customer AS c
                   JOIN payment AS p
                    ON c.customer_id = p.customer_id),

     t2 AS (SELECT t1.customer_id
              FROM t1
             GROUP BY 1
             ORDER BY SUM(t1.amount) DESC
             LIMIT 10),


t3 AS (SELECT t1.name,
              DATE_TRUNC('month', t1.payment_date) AS pay_mon, 
              COUNT(*) AS pay_countpermon,
              SUM(t1.amount) AS pay_amount,
              LEAD(SUM(t1.amount)) OVER(PARTITION BY t1.name ORDER BY DATE_TRUNC('month', t1.payment_date)) - SUM(t1.amount) AS lead_dif
         FROM t1
              JOIN t2
               ON t1.customer_id = t2.customer_id
        WHERE t1.payment_date BETWEEN '20070101' AND '20080101'
        GROUP BY 1, 2
        ORDER BY 1, 3, 2)

SELECT t3.name,
       t3.pay_mon,
       t3.pay_countpermon,
       t3.pay_amount,
	   ROUND(AVG(t3.pay_amount) OVER (PARTITION BY t3.name), 2) AS avg_amount,
       t3.lead_dif,
       CASE
           WHEN t3.lead_dif = (SELECT MAX(t3.lead_dif) FROM t3 ORDER BY 1 DESC LIMIT 1) THEN 'Maximum difference!'
           ELSE NULL
           END AS is_max					
  FROM t3
 ORDER BY 1, 2, 5;

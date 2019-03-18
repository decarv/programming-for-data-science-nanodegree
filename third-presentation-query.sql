
WITH t1 AS (SELECT (first_name || ' ' || last_name) AS name, 
                   c.customer_id, 
                   p.amount, 
                   DATE_TRUNC('month', p.payment_date) AS payment_date,
			       p.rental_id
              FROM customer AS c
                   JOIN payment AS p
                    ON c.customer_id = p.customer_id),
t2 AS (SELECT 
t1.name,
              t1.payment_date,
              SUM(t1.amount),
              LEAD(SUM(t1.amount)) OVER(PARTITION BY t1.name ORDER BY DATE_TRUNC('month', t1.payment_date)) AS lead,
              LEAD(SUM(t1.amount)) OVER(PARTITION BY t1.name ORDER BY DATE_TRUNC('month', t1.payment_date)) - SUM(t1.amount) AS lead_dif,
			        CASE 
           WHEN LEAD(SUM(t1.amount)) OVER(PARTITION BY t1.name ORDER BY DATE_TRUNC('month', t1.payment_date)) - SUM(t1.amount) < 0 THEN 0
           WHEN LEAD(SUM(t1.amount)) OVER(PARTITION BY t1.name ORDER BY DATE_TRUNC('month', t1.payment_date)) - SUM(t1.amount) >= 0 THEN 1
           END AS progress
FROM t1
JOIN rental AS r
ON r.rental_id = t1.rental_id
AND t1.customer_id = r.customer_id
GROUP BY 1, 2)
										  
SELECT t2.payment_date,
       COUNT(*) AS total_count,
       SUM(t2.progress) AS progress_bymon,
       COUNT(*) - SUM(t2.progress) AS regress_bymon
FROM t2
GROUP BY 1
ORDER BY 1;

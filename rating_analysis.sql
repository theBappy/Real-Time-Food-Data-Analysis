-- Rating analysis

-- Distribution of dish ratings from 1–5
SELECT
	rating,
	COUNT(*) AS rating_count
FROM fact_swiggy_orders 
GROUP BY rating
ORDER BY rating DESC;
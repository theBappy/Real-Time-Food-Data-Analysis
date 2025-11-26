-------------------------------------------
-- KPI METRICS
-------------------------------------------

-- 1. Total Orders
SELECT 
    COUNT(*) AS Total_Orders
FROM fact_swiggy_orders;
-- Result Example: 197,401


-------------------------------------------
-- 2. Total Revenue (INR Million)
-------------------------------------------
SELECT 
    FORMAT(
        SUM(CONVERT(FLOAT, price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders;
-- Result Example: 53.00 INR Million


-------------------------------------------
-- 3. Average Dish Price
-------------------------------------------
SELECT 
    FORMAT(
        AVG(CONVERT(FLOAT, price_inr)),
        'N2'
    ) + ' INR' AS Avg_Dish_Price
FROM fact_swiggy_orders;
-- Result Example: 268.50 INR


-------------------------------------------
-- 4. Average Rating
-------------------------------------------
SELECT 
    CAST(AVG(rating) AS DECIMAL(10, 3)) AS Avg_Rating
FROM fact_swiggy_orders;
-- Result Example: 4.342

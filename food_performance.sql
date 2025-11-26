/******************************************************************************
    FOOD PERFORMANCE ANALYSIS
    Author      : theBappy
    Description : Restaurant, Category, and Dish level performance with 
                  revenue, orders, and ratings.
******************************************************************************/


/***********************************************
    1. TOP 10 RESTAURANTS BY ORDERS & REVENUE
***********************************************/
SELECT TOP 10
    dr.Restaurant_Name,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue,
    AVG(CONVERT(FLOAT, f.rating)) AS Avg_Rating
FROM fact_swiggy_orders f
JOIN dim_restaurant dr 
    ON dr.restaurant_id = f.restaurant_id
GROUP BY dr.Restaurant_Name
ORDER BY COUNT(*) DESC;    -- Ranking by demand (orders)


/***********************************************
    2. TOP 10 FOOD CATEGORIES (Cuisine Type)
***********************************************/
SELECT TOP 10
    dc.Category,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_category dc 
    ON f.category_id = dc.category_id
GROUP BY dc.Category
ORDER BY Total_Orders DESC;


/***********************************************
    3. MOST ORDERED DISHES (TOP 10)
***********************************************/
SELECT TOP 10
    dsh.Dish_Name,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_dish dsh 
    ON f.dish_id = dsh.dish_id
GROUP BY dsh.Dish_Name
ORDER BY Total_Orders DESC;


/***********************************************
    4. CUISINE PERFORMANCE ? ORDERS + AVG RATING
***********************************************/
SELECT
    dc.Category,
    COUNT(*) AS Total_Orders,
    AVG(CONVERT(FLOAT, f.rating)) AS Avg_Rating,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_category dc 
    ON f.category_id = dc.category_id
GROUP BY dc.Category
ORDER BY Total_Orders DESC;


/******************************************************************************
    END OF FOOD PERFORMANCE ANALYSIS
******************************************************************************/ 

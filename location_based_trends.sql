/******************************************************************************
    LOCATION-BASED ANALYSIS (CITY & STATE PERFORMANCE)
    Author      : theBappy
    Description : City-wise and State-wise ranking by Orders & Revenue.
******************************************************************************/


/***********************************************
    1. TOP 10 CITIES BY ORDER VOLUME & REVENUE
***********************************************/

-- Top 10 Cities by Total Orders
SELECT TOP 10
    dl.City,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_location dl ON dl.location_id = f.location_id
GROUP BY dl.City
ORDER BY Total_Orders DESC;


-- Top 10 Cities by Revenue
SELECT TOP 10
    dl.City,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue,
    COUNT(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN dim_location dl ON dl.location_id = f.location_id
GROUP BY dl.City
ORDER BY SUM(f.price_inr) DESC;



/***********************************************
    2. BOTTOM 10 CITIES BY ORDERS & REVENUE
***********************************************/

-- Bottom 10 Cities by Total Orders
SELECT TOP 10
    dl.City,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_location dl ON dl.location_id = f.location_id
GROUP BY dl.City
ORDER BY Total_Orders ASC;


-- Bottom 10 Cities by Revenue
SELECT TOP 10
    dl.City,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue,
    COUNT(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN dim_location dl ON dl.location_id = f.location_id
GROUP BY dl.City
ORDER BY SUM(f.price_inr) ASC;



/***********************************************
    3. STATE-WISE REVENUE CONTRIBUTION
***********************************************/
SELECT
    dl.State,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue,
    COUNT(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN dim_location dl ON dl.location_id = f.location_id
GROUP BY dl.State
ORDER BY SUM(f.price_inr) DESC;


/******************************************************************************
    END OF LOCATION-BASED ANALYSIS
******************************************************************************/ 

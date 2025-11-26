/******************************************************************************
    DEEP DIVE ANALYSIS QUERIES (TREND ANALYSIS)
    Author      : <Your Name>
    Description : Monthly, Quarterly, Yearly, and Weekday trends 
                  including Total Orders + Revenue.
******************************************************************************/


/**************************************
    1. MONTHLY ORDER TRENDS
**************************************/
SELECT
    dd.Year,
    dd.Month,
    dd.Month_Name,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_date dd ON f.date_id = dd.date_id
GROUP BY
    dd.Year,
    dd.Month,
    dd.Month_Name
ORDER BY
    dd.Year,
    dd.Month;


/**************************************
    2. MONTHLY REVENUE (Sorted by Revenue DESC)
**************************************/
SELECT
    dd.Year,
    dd.Month,
    dd.Month_Name,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue,
    COUNT(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN dim_date dd ON f.date_id = dd.date_id
GROUP BY
    dd.Year,
    dd.Month,
    dd.Month_Name
ORDER BY
    SUM(f.price_inr) DESC;


/**************************************
    3. QUARTERLY ORDER TRENDS
**************************************/
SELECT
    dd.Year,
    dd.Quarter,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_date dd ON f.date_id = dd.date_id
GROUP BY
    dd.Year,
    dd.Quarter
ORDER BY
    dd.Year,
    dd.Quarter;


/**************************************
    4. YEARLY ORDER TRENDS
**************************************/
SELECT
    dd.Year,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_date dd ON f.date_id = dd.date_id
GROUP BY
    dd.Year
ORDER BY
    dd.Year;


/**************************************
    5. DAY-OF-WEEK ORDER TRENDS
**************************************/
SELECT
    DATENAME(WEEKDAY, dd.Full_Date) AS Day_Name,
    DATEPART(WEEKDAY, dd.Full_Date) AS Day_Number,
    COUNT(*) AS Total_Orders,
    FORMAT(
        SUM(CONVERT(FLOAT, f.price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_date dd ON f.date_id = dd.date_id
GROUP BY
    DATENAME(WEEKDAY, dd.Full_Date),
    DATEPART(WEEKDAY, dd.Full_Date)
ORDER BY
    Day_Number;  -- Monday ? Sunday depending on SQL Server settings


/******************************************************************************
    END OF TREND ANALYSIS SCRIPT
******************************************************************************/

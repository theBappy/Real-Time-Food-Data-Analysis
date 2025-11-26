/******************************************************************************
    CUSTOMER SPENDING INSIGHTS
    Author      : theBappy
    Description : Order distribution across spending ranges (price buckets).
******************************************************************************/

--------------------------------------------------------------
-- 1. CUSTOMER SPENDING BUCKETS (ORDER DISTRIBUTION)
--------------------------------------------------------------
SELECT
    CASE
        WHEN price_inr < 100 THEN 'Under 100'
        WHEN price_inr BETWEEN 100 AND 199 THEN '100 – 199'
        WHEN price_inr BETWEEN 200 AND 299 THEN '200 – 299'
        WHEN price_inr BETWEEN 300 AND 499 THEN '300 – 499'
        WHEN price_inr >= 500 THEN '500+'
    END AS Spending_Bucket,

    COUNT(*) AS Total_Orders,

    FORMAT(
        SUM(CONVERT(FLOAT, price_inr)) / 1000000,
        'N2'
    ) + ' INR Million' AS Total_Revenue,

    FORMAT(
        AVG(CONVERT(FLOAT, price_inr)),
        'N2'
    ) + ' INR' AS Avg_Spend

FROM fact_swiggy_orders
GROUP BY
    CASE
        WHEN price_inr < 100 THEN 'Under 100'
        WHEN price_inr BETWEEN 100 AND 199 THEN '100 – 199'
        WHEN price_inr BETWEEN 200 AND 299 THEN '200 – 299'
        WHEN price_inr BETWEEN 300 AND 499 THEN '300 – 499'
        WHEN price_inr >= 500 THEN '500+'
    END
ORDER BY MIN(price_inr);   


/******************************************************************************
    END OF CUSTOMER SPENDING INSIGHTS
******************************************************************************/

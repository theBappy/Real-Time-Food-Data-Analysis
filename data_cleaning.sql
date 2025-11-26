/******************************************************************************
    Indian food data(real time data of last 3 months for swiggy) – CLEANING & VALIDATION PIPELINE
    Author  : theBappy
    Purpose : Perform data quality checks, identify nulls/empties,
              detect duplicates, and remove duplicate rows.
******************************************************************************/

-- Preview the raw dataset
SELECT * FROM swiggy_data;



/******************************************************************************
    1. NULL VALUE CHECKS
    Description:
        Check for NULLs in all key columns to ensure data completeness.
******************************************************************************/

SELECT
    SUM(CASE WHEN State            IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN City             IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN Order_Date       IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN Restaurant_Name  IS NULL THEN 1 ELSE 0 END) AS null_restaurant_name,
    SUM(CASE WHEN Location         IS NULL THEN 1 ELSE 0 END) AS null_location,
    SUM(CASE WHEN Category         IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN Dish_Name        IS NULL THEN 1 ELSE 0 END) AS null_dish_name,
    SUM(CASE WHEN Price_INR        IS NULL THEN 1 ELSE 0 END) AS null_price_inr,
    SUM(CASE WHEN Rating           IS NULL THEN 1 ELSE 0 END) AS null_rating,
    SUM(CASE WHEN Rating_Count     IS NULL THEN 1 ELSE 0 END) AS null_rating_count
FROM swiggy_data;



/******************************************************************************
    2. EMPTY STRING CHECKS
    Description:
        Identify any dimension fields containing empty strings instead of NULLs.
        These often indicate incomplete or improperly imported data.
******************************************************************************/

SELECT *
FROM swiggy_data
WHERE 
      State            = ''
   OR City             = ''
   OR Restaurant_Name  = ''
   OR Location         = ''
   OR Category         = ''
   OR Dish_Name        = '';

-- Result: No blank values found in dimension fields.



/******************************************************************************
    3. DUPLICATE DETECTION
    Description:
        Identify rows that are exact duplicates across all key attributes.
******************************************************************************/

SELECT
    State,
    City,
    Order_Date,
    Restaurant_Name,
    Location,
    Category,
    Dish_Name,
    Price_INR,
    Rating,
    Rating_Count,
    COUNT(*) AS duplicate_count
FROM swiggy_data
GROUP BY
    State,
    City,
    Order_Date,
    Restaurant_Name,
    Location,
    Category,
    Dish_Name,
    Price_INR,
    Rating,
    Rating_Count
HAVING COUNT(*) > 1;



/******************************************************************************
    4. DUPLICATE REMOVAL
    Description:
        Remove exact duplicate rows while keeping the first occurrence.

    Note:
        This method works in SQL Server (DELETE from CTE is supported).
******************************************************************************/

WITH CTE AS (
    SELECT *,
        ROW_NUMBER() OVER(
            PARTITION BY 
                State,
                City,
                Order_Date,
                Restaurant_Name,
                Location,
                Category,
                Dish_Name,
                Price_INR,
                Rating,
                Rating_Count
            ORDER BY (SELECT NULL)
        ) AS rn
    FROM swiggy_data
)
DELETE FROM CTE 
WHERE rn > 1;

-- Result: 29 duplicate rows removed successfully.



/******************************************************************************
    END OF DATA CLEANING SCRIPT
******************************************************************************/

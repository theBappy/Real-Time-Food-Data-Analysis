-------------------------------------------
-- 1. Load Raw Data (Optional Debug View)
-------------------------------------------
SELECT * FROM swiggy_data;


-------------------------------------------
-- 2. Populate Dimension Tables
-------------------------------------------

-- dim_date
INSERT INTO dim_date (
    Full_Date, 
    Year, 
    Month, 
    Month_Name, 
    Quarter, 
    Day, 
    Week
)
SELECT DISTINCT
    Order_Date,
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date),
    DATEPART(QUARTER, Order_Date),
    DAY(Order_Date),
    DATEPART(WEEK, Order_Date)
FROM swiggy_data
WHERE Order_Date IS NOT NULL;

SELECT * FROM dim_date;


-- dim_location
INSERT INTO dim_location (State, City, Location)
SELECT DISTINCT
    State,
    City,
    Location
FROM swiggy_data;

SELECT * FROM dim_location;


-- dim_restaurant
INSERT INTO dim_restaurant (Restaurant_Name)
SELECT DISTINCT
    Restaurant_Name
FROM swiggy_data;

SELECT * FROM dim_restaurant;


-- dim_category
INSERT INTO dim_category (Category)
SELECT DISTINCT
    Category
FROM swiggy_data;

SELECT * FROM dim_category;


-- dim_dish
INSERT INTO dim_dish (Dish_Name)
SELECT DISTINCT
    Dish_Name
FROM swiggy_data;

SELECT * FROM dim_dish;


-------------------------------------------
-- 3. Populate FACT TABLE
-------------------------------------------

INSERT INTO fact_swiggy_orders (
    date_id,
    price_inr,
    rating,
    rating_count,
    location_id,
    restaurant_id,
    category_id,
    dish_id
)
SELECT
    dd.date_id,
    s.Price_INR,
    s.Rating,
    s.Rating_Count,
    dl.location_id,
    dr.restaurant_id,
    dc.category_id,
    dsh.dish_id
FROM swiggy_data s
JOIN dim_date dd
    ON dd.Full_Date = s.Order_Date
JOIN dim_location dl
    ON dl.State = s.State
   AND dl.City = s.City
   AND dl.Location = s.Location
JOIN dim_restaurant dr
    ON dr.Restaurant_Name = s.Restaurant_Name
JOIN dim_category dc
    ON dc.Category = s.Category
JOIN dim_dish dsh
    ON dsh.Dish_Name = s.Dish_Name;

SELECT * FROM fact_swiggy_orders;


-------------------------------------------
-- 4. FINAL BUSINESS VIEW (Star Schema Join)
-------------------------------------------

SELECT 
    f.order_id,
    dd.Full_Date,
    dd.Year,
    dd.Month,
    dd.Month_Name,
    dd.Quarter,
    dl.State,
    dl.City,
    dl.Location,
    dr.Restaurant_Name,
    dc.Category,
    dsh.Dish_Name,
    f.Price_INR,
    f.Rating,
    f.Rating_Count
FROM fact_swiggy_orders f
JOIN dim_date dd 
    ON f.date_id = dd.date_id
JOIN dim_location dl 
    ON f.location_id = dl.location_id
JOIN dim_restaurant dr 
    ON f.restaurant_id = dr.restaurant_id
JOIN dim_category dc 
    ON f.category_id = dc.category_id
JOIN dim_dish dsh 
    ON f.dish_id = dsh.dish_id;

-- Join all the star schema table for broader view of data
SELECT 
	*
FROM fact_swiggy_orders f
JOIN dim_date dd ON f.date_id = dd.date_id
JOIN dim_location dl ON f.location_id = dl.location_id
JOIN dim_restaurant dr ON f.restaurant_id = dr.restaurant_id
JOIN dim_category dc ON f.category_id = dc.category_id
JOIN dim_dish dsh ON f.dish_id = dsh.dish_id;
	
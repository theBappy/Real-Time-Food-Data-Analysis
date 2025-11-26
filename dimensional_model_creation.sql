

/******************************************************************************
    SWIGGY ANALYTICS DATA WAREHOUSE
    DIMENSIONAL MODELING – STAR SCHEMA CREATION SCRIPT
    Author   : <Your Name>
    Purpose  : Create dimension tables for the Swiggy Data Mart.
    Entities : Date, Location, Restaurant, Category, Dish
******************************************************************************/

-------------------------------------------------------------------------------
-- 1. DIM_DATE
-- Description:
--      Calendar dimension to support date-based analysis such as:
--      yearly trends, monthly reports, weekly performance, etc.
-------------------------------------------------------------------------------

CREATE TABLE dim_date (
    date_id      INT IDENTITY(1,1) PRIMARY KEY,   -- Surrogate key
    full_date    DATE NOT NULL,                   -- Actual calendar date
    year         INT  NOT NULL,
    month        INT  NOT NULL,
    month_name   VARCHAR(20) NOT NULL,
    quarter      INT  NOT NULL,
    day          INT  NOT NULL,
    week         INT  NOT NULL
);

SELECT * FROM dim_date;



-------------------------------------------------------------------------------
-- 2. DIM_LOCATION
-- Description:
--      Location dimension storing hierarchical geographic attributes.
--      Useful for city/state/location level performance reporting.
-------------------------------------------------------------------------------

CREATE TABLE dim_location (
    location_id   INT IDENTITY(1,1) PRIMARY KEY,   -- Surrogate key
    state         VARCHAR(100) NOT NULL,
    city          VARCHAR(100) NOT NULL,
    location      VARCHAR(200) NOT NULL
);

SELECT * FROM dim_location;



-------------------------------------------------------------------------------
-- 3. DIM_RESTAURANT
-- Description:
--      Restaurant dimension storing unique restaurant names.
-------------------------------------------------------------------------------

CREATE TABLE dim_restaurant (
    restaurant_id   INT IDENTITY(1,1) PRIMARY KEY,   -- Surrogate key
    restaurant_name VARCHAR(200) NOT NULL
);

SELECT * FROM dim_restaurant;



-------------------------------------------------------------------------------
-- 4. DIM_CATEGORY
-- Description:
--      Category dimension (e.g., Snacks, Beverages, Biryani, Desserts).
-------------------------------------------------------------------------------

CREATE TABLE dim_category (
    category_id   INT IDENTITY(1,1) PRIMARY KEY,     -- Surrogate key
    category      VARCHAR(200) NOT NULL
);

SELECT * FROM dim_category;



-------------------------------------------------------------------------------
-- 5. DIM_DISH
-- Description:
--      Dish dimension storing unique dish names.
--      Supports dish-level analytics.
-------------------------------------------------------------------------------

CREATE TABLE dim_dish (
    dish_id      INT IDENTITY(1,1) PRIMARY KEY,      -- Surrogate key
    dish_name    VARCHAR(200) NOT NULL
);

SELECT * FROM dim_dish;



/******************************************************************************
    END OF DIMENSIONAL MODEL CREATION SCRIPT
******************************************************************************/

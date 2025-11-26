/******************************************************************************
    FACT TABLE – FACT_SWIGGY_ORDERS
    Author   : theBappy
    Purpose  : Store transactional order-level data linked to all dimensions.
******************************************************************************/

-------------------------------------------------------------------------------
-- 6. FACT_SWIGGY_ORDERS
-- Description:
--      Central fact table at the grain of *one dish per order event*.
--      Contains all measurable metrics (price, rating, rating count)
--      and foreign keys referencing all dimensions.
-------------------------------------------------------------------------------

CREATE TABLE fact_swiggy_orders (
    order_id        INT IDENTITY(1,1) PRIMARY KEY,        -- Surrogate PK

    -- Foreign Keys
    date_id         INT NOT NULL,                         -- Links to dim_date
    location_id     INT NOT NULL,                         -- Links to dim_location
    restaurant_id   INT NOT NULL,                         -- Links to dim_restaurant
    category_id     INT NOT NULL,                         -- Links to dim_category
    dish_id         INT NOT NULL,                         -- Links to dim_dish

    -- Measures (Facts)
    price_inr       DECIMAL(10,2) NOT NULL,               -- Revenue metric
    rating          DECIMAL(4,2) NULL,                    -- User rating
    rating_count    INT NULL,                             -- Number of ratings

    -- Foreign key constraints
    FOREIGN KEY (date_id)        REFERENCES dim_date(date_id),
    FOREIGN KEY (location_id)    REFERENCES dim_location(location_id),
    FOREIGN KEY (restaurant_id)  REFERENCES dim_restaurant(restaurant_id),
    FOREIGN KEY (category_id)    REFERENCES dim_category(category_id),
    FOREIGN KEY (dish_id)        REFERENCES dim_dish(dish_id)
);

-------------------------------------------------------------------------------
-- Create indexes on all foreign keys for faster star-schema joins
-------------------------------------------------------------------------------

CREATE INDEX idx_fact_date_id        ON fact_swiggy_orders(date_id);
CREATE INDEX idx_fact_location_id    ON fact_swiggy_orders(location_id);
CREATE INDEX idx_fact_restaurant_id  ON fact_swiggy_orders(restaurant_id);
CREATE INDEX idx_fact_category_id    ON fact_swiggy_orders(category_id);
CREATE INDEX idx_fact_dish_id        ON fact_swiggy_orders(dish_id);



/******************************************************************************
    END OF FACT TABLE CREATION SCRIPT
******************************************************************************/

# 🧁 Food Delivery Data Analytics Real Time (SQL Project)


<img width="1024" height="1024" alt="banner" src="https://github.com/user-attachments/assets/f779d15e-f880-4ac5-b51c-7c6485cc6e2a" />


---

A complete data analytics project built using **SQL Server**, delivering business insights on order volume, revenue, customer spending behavior, restaurant performance, and rating trends using real Swiggy-style order data.

This project demonstrates how raw transactional delivery data can be transformed into actionable KPIs and customer insights.

---

## 📌 **Project Overview**

This project analyzes more than **197,000+ food delivery orders** from Swiggy to answer key business questions, including:

* What is the total revenue generated?
* How many orders were placed?
* What is the average dish price and rating?
* How do customers spend across different price buckets?
* What food categories dominate the platform?
* Which restaurants and locations perform best?

---

## 🗂 **Dataset Description**

### **Main Fact Table: `fact_swiggy_orders`**

| Column            | Description                      |
| ----------------- | -------------------------------- |
| `state`           | Customer state (e.g., Karnataka) |
| `city`            | Customer city                    |
| `order_date`      | Date of order                    |
| `restaurant_name` | Restaurant fulfilling the order  |
| `location`        | Local area within the city       |
| `category`        | Food category                    |
| `dish_name`       | Name of the ordered dish         |
| `price_inr`       | Price paid for the dish          |
| `rating`          | Customer rating                  |
| `rating_count`    | Number of ratings received       |

---

## 🧩 **ER Diagram**

Below is the recommended data model for this project:

```
           ┌──────────────────────┐
           │   dim_location       │
           │  location_id (PK)    │
           │  state               │
           │  city                │
           │  area                │
           └─────────┬────────────┘
                     │
                     │
      ┌──────────────┴──────────────┐
      │         fact_swiggy_orders   │
      │  order_id (PK)               │
      │  location_id (FK)            │
      │  restaurant_id (FK)          │
      │  category_id (FK)            │
      │  dish_id (FK)                │
      │  price_inr                   │
      │  rating                      │
      └──────────────┬──────────────┘
                     │
 ┌───────────────────┼────────────────────┐
 │                   │                    │
 │                   │                    │
 ▼                   ▼                    ▼
┌───────────┐   ┌──────────────┐   ┌─────────────┐
│dim_dish   │   │dim_category   │   │dim_restaurant│
│dish_id PK │   │category_id PK │   │restaurant_id │
│dish_name  │   │category       │   │name          │
└───────────┘   └──────────────┘   └─────────────┘
```

If you want a **PNG diagram**, just say “buddy generate ER PNG”.

---

## 📊 **Key KPIs Computed**

### **1. Total Orders**

```sql
SELECT COUNT(*) AS Total_Orders FROM fact_swiggy_orders;
```

✔ **Result:** 197,401 orders

---

### **2. Total Revenue (INR Million)**

```sql
SELECT FORMAT(
    SUM(CONVERT(FLOAT, price_inr)) / 1000000, 'N2'
) + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders;
```

✔ **Result:** 53.00 INR Million

---

### **3. Average Dish Price**

```sql
SELECT FORMAT(
    AVG(CONVERT(FLOAT, price_inr)), 'N2'
) + ' INR' AS Avg_Dish_Price
FROM fact_swiggy_orders;
```

✔ **Result:** 268.50 INR

---

### **4. Average Rating**

```sql
SELECT AVG(rating) FROM fact_swiggy_orders;
```

✔ **Result:** 4.341577

---

## 💰 Customer Spending Insights

### **Spending Buckets:**

* Under 100
* 100–199
* 200–299
* 300–499
* 500+

### **SQL Query**

```sql
SELECT  
    CASE  
        WHEN price_inr < 100 THEN 'Under 100'
        WHEN price_inr BETWEEN 100 AND 199 THEN '100-199'
        WHEN price_inr BETWEEN 200 AND 299 THEN '200-299'
        WHEN price_inr BETWEEN 300 AND 499 THEN '300-499'
        ELSE '500+'  
    END AS Spend_Bucket,
    COUNT(*) AS Total_Orders
FROM fact_swiggy_orders
GROUP BY  
    CASE  
        WHEN price_inr < 100 THEN 'Under 100'
        WHEN price_inr BETWEEN 100 AND 199 THEN '100-199'
        WHEN price_inr BETWEEN 200 AND 299 THEN '200-299'
        WHEN price_inr BETWEEN 300 AND 499 THEN '300-499'
        ELSE '500+'  
    END
ORDER BY Spend_Bucket;
```

---

## 🧠 **Business Insights Summary**

* Revenue > **₹53 Million**
* Mid-range dishes (**₹200–499**) dominate orders
* Customers rate dishes highly (**Avg 4.34**)
* Best pricing sweet spot: **₹229–₹349**

---

## 🏗 Tech Stack

* SQL Server
* T-SQL
* Power BI / Tableau (optional)
* Azure Data Studio

---

## 📁 Folder Structure

```
swiggy-sql-analysis/
│
├── data/
│── sql/
│── visuals/
│── README.md
```

---

## 👨‍💻 Author

**theBappy**
---


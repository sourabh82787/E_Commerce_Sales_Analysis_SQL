# 🛒 E-Commerce Sales Analysis — SQL

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Data Analysis](https://img.shields.io/badge/Data%20Analysis-SQL-orange)
![Portfolio Project](https://img.shields.io/badge/Project-Portfolio-success)

## 📌 Project Overview

This project focuses on **E-Commerce Sales Analysis using MySQL** to answer real-world business questions related to **sales performance, customers, products, revenue, retention, churn, and purchasing behavior**.

The analysis contains **52 business questions**, progressing from basic SQL aggregations to advanced analytical techniques such as:

* Joins
* Aggregations
* CTEs
* Subqueries
* Window Functions
* `LAG()` / `LEAD()`
* Ranking
* Running Totals
* Revenue Contribution
* Month-over-Month Growth
* Customer Lifetime Value
* Repeat Purchase Analysis
* Customer Retention
* Churn Analysis
* RFM Analysis
* Product Affinity / Basket Analysis

The goal is to demonstrate how SQL can be used to convert raw transactional data into **business insights that support decision-making**.

---

## 🎯 Business Objectives

The project answers key business questions such as:

* How much revenue has the business generated?
* Which products and categories are performing best?
* Who are the highest-value customers?
* Which customers make repeat purchases?
* Which customers are at risk of churn?
* How is revenue changing month over month?
* Which cities generate the highest revenue?
* What percentage of revenue comes from each product/category?
* What is customer lifetime value?
* How many new customers are acquired each month?
* Which products are frequently purchased together?
* How frequently do customers place orders?

---

## 🗂️ Project Structure

```text
E-Commerce-Sales-Analysis/
│
├── README.md
│
├── ecommerce_sales_analysis_formatted.sql
│
└── data/
    ├── customers
    ├── orders
    ├── order_items
    └── products
```

> The SQL analysis is contained in `ecommerce_sales_analysis_formatted.sql`.

---

## 🛢️ Database Schema

The analysis uses the following primary tables:

### 👤 Customers

Contains customer-level information used for customer and geographic analysis.

```text
customers
├── customer_id
├── customer_name
├── city
└── gender
```

### 🧾 Orders

Contains order-level transactional information.

```text
orders
├── order_id
├── customer_id
├── order_date
└── order_status
```

### 📦 Order Items

Contains individual products purchased within each order.

```text
order_items
├── order_id
├── product_id
├── quantity
└── unit_price
```

### 🏷️ Products

Contains product and category information.

```text
products
├── product_id
├── product_name
├── category
└── unit_price
```

---

# 📊 Analysis Areas

## 1. 💰 Revenue & Sales Analysis

The project analyzes overall and detailed revenue performance.

Key questions include:

* Total revenue
* Average Order Value
* Revenue by category
* Revenue by city
* Monthly revenue trend
* Highest-revenue month
* Daily sales trend
* Revenue contribution by product
* Revenue contribution by category
* Month-over-Month revenue growth

### Example KPI

```sql
SELECT
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM order_items;
```

---

## 2. 📦 Product Analysis

Product performance is analyzed using quantity sold and revenue.

Questions include:

* Top 5 selling products
* Top 10 selling products
* Highest-revenue product
* Lowest-revenue product
* Best-selling category
* Worst-selling category
* Top-selling product within each category
* Most expensive product
* Frequently purchased product combinations

---

## 3. 👥 Customer Analysis

Customer behavior is analyzed to identify valuable and repeat customers.

Questions include:

* Total number of customers
* Top customers by revenue
* Customers with repeat purchases
* Customers who never placed an order
* Customers with highest average order value
* Customer lifetime value
* New vs returning customers
* Customers purchasing from multiple categories

---

## 4. 🔄 Customer Retention & Purchase Behavior

The project examines how frequently customers return and purchase again.

Analysis includes:

* Repeat purchase rate
* Active customers by month
* Previous order date
* Next order date
* Days between consecutive orders
* Average days between customer orders
* Monthly customer acquisition
* New vs returning customers

### Example: Previous Order Analysis

```sql
SELECT
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM orders;
```

---

## 5. 🚨 Churn Analysis

Customer churn is analyzed to identify customers who may no longer be active.

The project identifies:

* Customers at risk of churn
* Last order date
* Overall customer churn rate
* Customers inactive beyond the defined cutoff

This can help businesses develop **customer retention and re-engagement strategies**.

---

## 6. 📈 RFM Analysis

The project includes an initial **RFM analysis framework** based on:

### Recency

How recently the customer purchased.

### Frequency

How frequently the customer purchases.

### Monetary

How much revenue the customer generates.

```text
RFM
│
├── Recency
│   └── Days since last order
│
├── Frequency
│   └── Number of orders
│
└── Monetary
    └── Total customer revenue
```

This analysis can help segment customers into groups such as:

* High-value customers
* Frequent customers
* Recently active customers
* Potential churn customers

---

# 🧠 Advanced SQL Techniques Used

This project demonstrates practical use of the following SQL concepts:

| SQL Concept         | Application                             |
| ------------------- | --------------------------------------- |
| `SELECT`            | Data retrieval                          |
| `WHERE`             | Filtering records                       |
| `GROUP BY`          | Aggregating business metrics            |
| `HAVING`            | Filtering aggregated results            |
| `ORDER BY`          | Ranking results                         |
| `LIMIT`             | Top-N analysis                          |
| `INNER JOIN`        | Combining business tables               |
| `LEFT JOIN`         | Finding customers without orders        |
| Subqueries          | Multi-level analysis                    |
| CTEs                | Structuring complex queries             |
| `CASE`              | Customer classification                 |
| `LAG()`             | Previous-period/customer order analysis |
| `LEAD()`            | Next-order analysis                     |
| `ROW_NUMBER()`      | Ranking within groups                   |
| `DENSE_RANK()`      | Customer/product ranking                |
| Window Functions    | Advanced analytical calculations        |
| `SUM() OVER()`      | Running totals & contribution analysis  |
| `DATE_FORMAT()`     | Time-based analysis                     |
| `DATEDIFF()`        | Customer purchase intervals             |
| Aggregate Functions | Revenue, quantity and customer metrics  |

---

# 📋 Business Questions Covered

The project contains **52 SQL business questions**, including:

### Sales & Revenue

1. Total revenue
2. Total orders
3. Total customers
4. Total products
5. Average Order Value
6. Top 5 selling products
7. Revenue by category
8. Top 5 valuable customers
9. Monthly revenue trend
10. Revenue by city

### Customer Behavior

11. Repeat customers
12. Customers who never ordered
13. Inactive customers
14. Best-selling category
15. Highest-revenue product
16. Lowest-revenue product
17. Average products per order
18. High-value orders
19. Highest average order value customers
20. Top 3 cities by revenue

### Advanced Analytics

21. Customer revenue ranking
22. Top product in each category
23. Running revenue total
24. Previous customer order
25. Next customer order
26. Days between orders
27. Top 3 customers by revenue
28. Product revenue contribution
29. Month-over-Month revenue growth
30. Highest-value order per customer

### Customer Intelligence

31. Customer Lifetime Value
32. Repeat Purchase Rate
33. New vs Returning Customers
34. Monthly Active Customers
35. Multi-category customers
36. Frequently purchased product pairs
37. Average days between customer orders
38. Fastest-growing product category
39. Customers at risk of churn
40. RFM Analysis

### Operational & Performance Analysis

41. Daily sales trend
42. Top 10 best-selling products
43. Top 10 customers by revenue
44. Revenue by gender
45. Customer churn rate
46. Order cancellation rate
47. Delivered vs cancelled orders
48. Worst-selling category
49. Most expensive product
50. Highest-revenue month
51. Monthly customer acquisition
52. Category revenue contribution

---

# 🔍 Key Analytical Insights

This project is designed to help answer business questions from multiple perspectives:

### 💰 Revenue

Identify the strongest revenue-generating products, categories, cities, and months.

### 👥 Customers

Identify high-value, repeat, inactive, and newly acquired customers.

### 📦 Products

Understand which products drive volume and revenue and which products underperform.

### 📈 Trends

Analyze daily and monthly sales patterns and revenue growth.

### 🔄 Retention

Understand repeat purchasing behavior and customer activity over time.

### 🚨 Churn

Identify customers who may require retention or re-engagement campaigns.

### 🧠 Customer Value

Use CLV and RFM metrics to identify valuable customer segments.

---

# 🛠️ Tools & Technologies

* **MySQL 8+**
* SQL
* MySQL Workbench
* GitHub

---

# ▶️ How to Run the Project

### Step 1 — Create/Select the Database

```sql
USE ecommerce_project;
```

### Step 2 — Load the Required Tables

Make sure the following tables are available:

```text
customers
orders
order_items
products
```

### Step 3 — Run the SQL Analysis

Open:

```text
ecommerce_sales_analysis_formatted.sql
```

Run the queries individually or execute the complete script after loading the required data.

---

# 📁 Main Project File

```text
ecommerce_sales_analysis_formatted.sql
```

This file contains the complete set of **52 business-oriented SQL analyses**.

---

# 💼 Skills Demonstrated

This project demonstrates my ability to:

* Translate business questions into SQL queries
* Analyze transactional sales data
* Work with multiple relational tables
* Perform customer and product analysis
* Calculate business KPIs
* Use advanced SQL window functions
* Perform time-series analysis
* Analyze customer retention
* Calculate customer lifetime value
* Perform basic RFM analysis
* Identify churn-risk customers
* Analyze product purchasing patterns
* Structure SQL code for readability and maintainability

---

# 🚀 Future Improvements

Possible future extensions of this project include:

* Building an interactive **Power BI dashboard**
* Creating customer RFM segments
* Adding product/category profitability analysis
* Creating cohort retention analysis
* Developing automated KPI reporting
* Adding SQL views for recurring business reports
* Connecting the SQL database to Power BI
* Creating an executive-level sales dashboard

---

# 👨‍💻 Author

**Sourabh Kumar**

Aspiring Data Analyst | MIS Analyst

### Skills

`SQL` `Excel` `Power BI` `Python` `R` `Data Analysis`

---

## ⭐ Project Purpose

This project was created as a **Data Analyst portfolio project** to demonstrate practical SQL skills through real-world e-commerce business scenarios.

> **From raw transactional data → SQL analysis → business insights → data-driven decisions.**

If you find this project useful, feel free to ⭐ the repository.

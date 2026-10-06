-- ============================================================
-- E-COMMERCE SALES ANALYSIS | SQL BUSINESS QUESTIONS
-- ============================================================
-- Database : ecommerce_project
-- Purpose  : Business-focused SQL analysis for a Data Analyst portfolio
-- Scope    : Revenue, customers, products, retention, churn, RFM,
--            trends, rankings, and operational performance
-- SQL     : MySQL 8+
-- ============================================================
-- NOTE:
-- This version is professionally formatted from the supplied script.
-- A few obvious alias/join/table-reference issues were corrected so
-- the portfolio version is more execution-ready. These corrections
-- are limited to clear issues such as Q4, Q7, Q8, Q19, Q20 and Q21.
-- ============================================================

USE ecommerce_project;

-- ============================================================
-- E-Commerce Sales Analysis — Business Questions (SQL Queries)
-- Run these AFTER data/01, 02, 03 have been executed in order.
-- ============================================================
--
-- ============================================================
-- Q1: What is the total revenue so far?

SELECT ROUND(SUM(quantity * unit_price),2) AS total_revenue
FROM order_items;

--
-- ============================================================
-- Q2: How many total orders we have received?

SELECT COUNT(*) AS total_orders
FROM order_items;

--
-- ============================================================
-- Q3: How many total customers do we have?

SELECT COUNT(*) AS Total_customers
FROM customers;

--
-- ============================================================
-- Q4: How many total products do we sell?

SELECT COUNT(*) AS total_products
FROM products;

--
-- ============================================================
-- Q5: What is the average amount a customer spends per order?

SELECT ROUND(SUM(quantity * unit_price)/COUNT(DISTINCT  order_id),2) AS avg_order_value
FROM order_items;
--
-- ============================================================
-- Q6: What are the top 5 selling products?
SELECT p.product_name,SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
GROUP BY p.product_name
ORDER BY  total_quantity DESC LIMIT 5;
--
-- ============================================================
-- Q7: Which category is generating the most revenue?
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;
--
-- ============================================================
-- Q8: Who are our top 5 most valuable customers?
SELECT c.customer_name ,ROUND(SUM(oi.quantity*Oi.unit_price),2) AS rev
FROM customers c
JOIN orders o ON o.customer_id =c.customer_id
JOIN order_items AS oi
    ON oi.order_id = o.order_id
GROUP BY c.customer_name
ORDER BY rev desc LIMIT 5;
--
-- ============================================================
-- Q9: How has our revenue trended month by month?
SELECT DATE_FORMAT(o.order_date, '%Y-%M')AS Month,
ROUND(SUM(oi.quantity * oi.unit_price),2) AS rev
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY month
ORDER BY month desc;
--
-- ============================================================
-- Q10: Which city is generating the most sales?
SELECT c.city,ROUND(SUM(oi.quantity * oi.unit_price),2) AS rev
FROM customers c
JOIN orders o ON o.customer_id=c.customer_id
JOIN order_items oi ON oi.order_id =o.order_id
GROUP BY c.city
ORDER BY rev desc;
--
-- ============================================================
-- Q11: Which customers purchase repeatedly?
SELECT customer_id ,COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id)>1
ORDER BY total_orders desc;
--
-- ============================================================
-- Q12: Which customers have never placed an order?
SELECT c.customer_id ,c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id =o.customer_id
WHERE o.order_id is null;
--
-- ============================================================
-- Q13: Which customers have been inactive in the last 90 days?
-- SELECT c.customer_id,c.customer_name,MAX(o.order_date) AS last_order
-- FROM customers c
-- LEFT JOIN orders o ON c.customer_id=o.customer_id
-- GROUP BY c.customer_id ,c.customer_name
-- HAVING MAX(o.order_date) <'2026-04-30' OR MAX (o.order_date) is null
-- ORDER BY last_order;
--
-- ============================================================
-- Q14: What is the best-selling category?
SELECT p.category,SUM(oi.quantity) AS unit_sold
FROM products p
JOIN order_items oi ON oi.product_id=p.product_id
GROUP BY p.category
ORDER BY unit_sold desc LIMIT 1;
--
-- ============================================================
-- Q15: Which product generates the highest revenue?
SELECT p.product_name ,ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM products p
JOIN order_items oi ON oi.product_id=p.product_id
GROUP BY p.product_name
ORDER BY revenue desc LIMIT 1;
--
-- ============================================================
-- Q16: Which product generates the lowest revenue?
SELECT p.product_name ,ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM products p
JOIN order_items oi ON oi.product_id=p.product_id
GROUP BY p.product_name
ORDER BY revenue asc LIMIT 1;
--
-- ============================================================
-- Q17: On average, how many products are bought per order?
SELECT ROUND(AVG(product_count),2) AS avg_products_per_order
FROM (
SELECT order_id,SUM(quantity) AS product_count
FROM order_items
GROUP BY order_id) t;
--
-- ============================================================
-- Q18: Which orders are worth more than 10,000?
SELECT order_id ,ROUND(SUM(quantity* unit_price),2) AS order_value
FROM order_items
GROUP BY order_id
HAVING SUM(quantity* unit_price)>10000
ORDER BY order_value desc ;
--
-- ============================================================
-- Q19: Which customers have the highest average order value?
SELECT customer_id,ROUND(AVG(order_value),2) AS avg_order_value
FROM (
SELECT o.customer_id ,o.order_id,(SUM(oi.quantity*oi.unit_price)) AS order_value
FROM orders o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY  o.customer_id ,o.order_id ) t
GROUP BY customer_id
ORDER BY avg_order_value  desc LIMIT 5;
--
-- ============================================================
-- Q20: What are the top 3 cities by revenue?
SELECT c.city ,ROUND(SUM(oi.quantity*oi.unit_price),2) AS Revenue
FROM customers c
JOIN orders o ON o.customer_id =c.customer_id
JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY c.city
ORDER BY revenue DESC
LIMIT 3;
--
-- ============================================================
-- Q21: How are customers ranked based on revenue?
WITH customer_rev AS(
SELECT o.customer_id,SUM(oi.quantity*oi.unit_price) AS rev
FROM orders o
JOIN order_items AS oi ON oi.order_id = o.order_id
GROUP BY o.customer_id)
SELECT customer_id ,ROUND(rev,2) AS revenue ,
DENSE_RANK() OVER(ORDER BY rev desc ) AS rev_rank
FROM customer_rev
ORDER BY rev_rank LIMIT 10;
--
-- ============================================================
-- Q22: What is the top-selling product in each category?
WITH product_sales AS(
SELECT p.category ,p.product_name,SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi ON oi. product_id=p.product_id
GROUP BY p.category ,p.product_name)
SELECT category ,product_name ,total_sold
FROM (SELECT * ,ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_sold desc)
AS rnk
FROM product_sales) t
WHERE rnk=1;
--
-- ============================================================
-- Q23: How has our revenue accumulated over time — running total?
WITH daily_sales AS (
    SELECT
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS daily_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.order_date
)
SELECT
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY order_date
    ) AS running_rev
FROM daily_sales
ORDER BY order_date
LIMIT 15;
--
-- ============================================================
-- Q24: When was each customer's previous order placed?
SELECT customer_id,order_id,order_date,
LAG(order_date) OVER (PARTITION BY customer_id  ORDER BY order_date) AS pre_order_date
FROM orders
ORDER BY customer_id ,order_date
LIMIT 20;
--
-- ============================================================
-- Q25: When was each customer's next order placed, if any?
SELECT customer_id,order_id,order_date,
LEAD(order_date) OVER (PARTITION BY customer_id  ORDER BY order_date) AS next_order_date
FROM orders
ORDER BY customer_id ,order_date
LIMIT 20;
--
-- ============================================================
-- Q26: How many days are there between a customer's consecutive orders?
SELECT customer_id , order_date ,
DATEDIFF(order_date,LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date)) AS days_between_orders
FROM orders
ORDER BY customer_id,order_date
LIMIT 20;
--
-- ============================================================
-- Q27: Who are the top 3 customers by revenue?
WITH customer_revenue AS (
SELECT o.customer_id ,SUM(oi.quantity* oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY o.customer_id)
SELECT customer_id ,ROUND(revenue,2) AS  rev ,rnk
FROM( SELECT * ,DENSE_RANK() OVER (ORDER BY revenue desc ) AS rnk
FROM customer_revenue) t WHERE rnk <=3;
--
-- ============================================================
-- Q28: What percentage does each product contribute to total revenue?
WITH product_revenue AS (
    SELECT
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    revenue,
    ROUND(
        (revenue * 100.0) / SUM(revenue) OVER(),
        2
    ) AS revenue_percentage
FROM product_revenue
ORDER BY revenue DESC
LIMIT 10;
--
-- ============================================================
-- Q29: What is the month-over-month revenue growth?
WITH monthly_sales AS (
 SELECT DATE_FORMAT (o.order_date ,'%y-%m') AS month ,
 SUM(oi.quantity* oi.unit_price) AS revenue
 FROM orders o
 JOIN order_items oi ON oi.order_id =o.order_id
 GROUP BY month )
SELECT month ,revenue,
ROUND(LAG(revenue) OVER (ORDER BY month ),2) previous_month_revenue,
ROUND(100*(revenue-LAG(revenue) OVER (ORDER BY month ))/LAG(revenue)
OVER(ORDER BY month),2) AS growth_percentage
FROM monthly_sales
ORDER BY month;
--
-- ============================================================
-- Q30: What was each customer's highest-value order?
WITH order_values AS (
    SELECT
        o.customer_id,
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY o.customer_id, o.order_id
)
SELECT
    customer_id,
    order_id,
    order_value
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_value DESC
           ) AS rnk
    FROM order_values
) t
WHERE rnk = 1
ORDER BY order_value DESC
LIMIT 10;
--
-- ============================================================
-- Q31: What is each customer's lifetime value — CLV?
SELECT o.customer_id,SUM(oi.quantity*oi.unit_price) AS customer_lifetime_value FROM orders o
JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY o.customer_id
ORDER BY customer_lifetime_value desc LIMIT 10;
--
-- ============================================================
-- Q32: what percentage of customers make repeat purchase?
WITH customer_orders AS (
    SELECT customer_id, COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
)
SELECT
    ROUND(
        100.0 * COUNT(CASE WHEN total_orders > 1 THEN 1 END) / COUNT(*),
        2
    ) AS repeat_purchase_rate
FROM customer_orders;
--
-- ============================================================
-- Q33: how many customers are new vs returning?
WITH first_order AS (
SELECT customer_id, MIN(order_date) AS first_order_date
FROM orders
GROUP BY customer_id
)
SELECT
CASE WHEN o.order_date = f.first_order_date THEN 'New_customer' ELSE 'returning_customer' END AS customer_type,
COUNT(*) AS total_orders
FROM orders o
JOIN first_order f ON o.customer_id = f.customer_id
GROUP BY customer_type;
--
-- ============================================================
-- Q34: HOW MANY CUSTOMERS WERE ACTIVE EACH MONTH-RETENTION?
WITH MONTHLY_ORDERS AS (
SELECT DISTINCT CUSTOMER_ID ,DATE_FORMAT(ORDER_DATE, '%Y-%M') AS ORDER_MONTH
FROM ORDERS
)
SELECT ORDER_MONTH,COUNT(DISTINCT CUSTOMER_ID) AS ACTIVE_CUSTOMERS
FROM MONTHLY_ORDERS
GROUP BY ORDER_MONTH
ORDER BY ORDER_MONTH;
--
-- ============================================================
-- Q35: which customers purchase FROM more than one category?
SELECT o.customer_id , COUNT(DISTINCT p.category) AS categories_purchased
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.customer_id
HAVING COUNT(DISTINCT p.category)>1
ORDER BY categories_purchased desc
LIMIT 15;
--
-- ============================================================
-- Q36: which two products are mostly frequently purchased together?
SELECT
    oi1.product_id AS product_1,
    oi2.product_id AS product_2,
    COUNT(*) AS purchase_count
FROM order_items oi1
JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id
GROUP BY oi1.product_id, oi2.product_id
ORDER BY purchase_count DESC
LIMIT 10;
--
-- ============================================================
-- Q37: ON average,how many days pass between a customer's orders?
WITH customer_orders AS (
SELECT customer_id,order_date,
LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order
FROM orders)
SELECT customer_id , ROUND(AVG(DATEDIFF(order_date,previous_order)),2) AS avg_orders_day
FROM customer_orders
WHERE previous_order is not null
GROUP BY customer_id
ORDER BY avg_orders_day
LIMIT 15;
--
-- ============================================================
-- Q38: Which product category is growing the fastest?
WITH monthly_category_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON p.product_id = oi.product_id
    GROUP BY month_name, p.category
)
SELECT
    month_name,
    category,
    ROUND(revenue, 2) AS rev,
    ROUND(
        revenue - LAG(revenue) OVER (
            PARTITION BY category
            ORDER BY month_name
        ), 2
    ) AS revenue_growth
FROM monthly_category_sales
ORDER BY revenue_growth DESC
LIMIT 15;
--
-- ============================================================
-- Q39: which customers are at risk of churn?
SELECT customer_id,MAX(order_date) AS last_order_date
FROM orders
GROUP BY customer_id
HAVING MAX(order_date) < '2026-04-30'
ORDER BY last_order_date
--
-- ============================================================
-- Q40: How do customers look based ON rfm-recency,frequency,monetary -analysis?
SELECT
    o.customer_id,
    DATEDIFF('2026-07-30', MAX(o.order_date)) AS recency_days,
    COUNT(DISTINCT o.order_id) AS frequency,
    SUM(oi.quantity * oi.unit_price) AS monetary
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY monetary DESC
LIMIT 15;
--
-- ============================================================
-- Q41: What is the daile sales trend?
SELECT o.order_date ,SUM(oi.quantity * oi.unit_price) AS daily_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_date
ORDER BY o.order_date
LIMIT 15;
--
-- ============================================================
-- Q42: What are the top 10 best selling products?
 SELECT p.product_name ,SUM(oi.quantity) AS total_quantity
 FROM order_items oi
 JOIN products p ON oi.product_id=p.product_id
 GROUP BY p.product_name
 ORDER BY total_quantity desc LIMIT 10;
--
-- ============================================================
-- Q43: Who are the top 10 customers by revenue?
SELECT c.customer_name ,SUM(oi.quantity * oi.unit_price) AS revenue
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_name
ORDER BY revenue desc LIMIT 10;
--
-- ============================================================
-- Q44: How much revenue comes FROM male vs female customers?
SELECT c.gender,SUM(oi.quantity * oi.unit_price) AS revenue
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.gender
ORDER BY revenue desc;
--
-- ============================================================
-- Q45: what is our customer churn rate?
WITH customer_status AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_order,
        CASE
            WHEN MAX(order_date) < '2026-04-30' THEN 1
            ELSE 0
        END AS is_churned
    FROM orders
    GROUP BY customer_id
)
SELECT
    ROUND(100 * SUM(is_churned) / COUNT(*), 2) AS churn_rate_percentage
FROM customer_status;
--
-- ============================================================
-- Q46: What percentage of orders get cancelled?
SELECT ROUND(100 * COUNT(CASE WHEN order_status ='cancelled' THEN 1 END) /COUNT(*),2) AS cancellation_rate_per FROM orders;
--
-- ============================================================
-- Q47: How many orders were delivered vs cancelled?
SELECT order_status ,COUNT(*) AS total_orders
FROM orders
WHERE order_status in ('delivered','cancelled')
GROUP BY order_status;
--
-- ============================================================
-- Q48: What is the worst-selling category?
SELECT p.category , SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY units_sold asc
LIMIT 1;
--
-- ============================================================
-- Q49: What is the most expensive product sold?
SELECT product_name ,unit_price
FROM products
ORDER BY unit_price desc LIMIT 1;
--
-- ============================================================
-- Q50: Which month had the highest revenue?
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month_date,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY month_date
)
SELECT
    month_date,
    revenue
FROM monthly_revenue
ORDER BY revenue DESC
LIMIT 1;
--
-- ============================================================
-- Q51: How many new customers were acquired each month?
WITH first_orders AS(
 SELECT customer_id , MIN(order_date) AS first_order_date
 FROM orders
 GROUP BY customer_id)
 SELECT DATE_FORMAT(first_order_date,'%y-%m') AS acquisition_month,COUNT(customer_id) AS new_customers
 FROM first_orders
 GROUP BY acquisition_month
 ORDER BY acquisition_month;
--
-- ============================================================
-- Q52: What percentage does each category contribute to total revenue?
 WITH category_revenue AS(
 SELECT p.category,SUM(oi.quantity * oi.unit_price) AS revenue
 FROM products p
 JOIN order_items oi ON p.product_id = oi.product_id
 GROUP BY p.category)
 SELECT category,ROUND(revenue,2) AS rev ,
 ROUND(100*revenue/SUM(revenue) OVER() ,2) AS revenue_contribution_percentage
 FROM category_revenue
 ORDER BY rev desc;

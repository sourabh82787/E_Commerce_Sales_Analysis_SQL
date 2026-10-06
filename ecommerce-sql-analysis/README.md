# E-Commerce Sales Analysis (SQL Project)

A PostgreSQL project analyzing an e-commerce dataset (90 customers, 38 products,
2,000 orders, ~4,967 order items) to answer 52 real-world business questions —
covering sales performance, customer behavior, product trends, and order status.

## 🎯 Objective
Practice and demonstrate SQL skills (joins, aggregations, window functions,
subqueries, CTEs) on a realistic relational dataset, as part of preparation
for Data Analyst / Business Analyst roles.

## 🗂️ Dataset
Custom-built sample dataset with 4 related tables:

| Table         | Description                                  |
|---------------|-----------------------------------------------|
| `customers`   | Customer id, name, city, gender, signup date  |
| `products`    | Product id, name, category, unit price        |
| `orders`      | Order id, customer, order date, status         |
| `order_items` | Line items per order (product, qty, price)     |

**ER Diagram:**
```
customers ──1:N── orders ──1:N── order_items ──N:1── products
```

## 🛠️ Tools Used
- PostgreSQL
- pgAdmin / DBeaver (or your SQL client of choice)

## 📁 Project Structure
```
ecommerce-sql-analysis/
├── README.md
├── .gitignore
├── data/
│   ├── 01_create_database.sql      -- CREATE DATABASE statement
│   ├── 02_create_tables.sql        -- DROP + CREATE TABLE (DDL) for all 4 tables
│   └── 03_insert_data.sql          -- all INSERT INTO statements (sample data)
├── queries/
│   └── 01_business_questions.sql   -- all 52 analysis queries, one by one
├── docs/
│   └── er_diagram.png              -- entity relationship diagram (optional)
└── outputs/
    └── sample_results.md           -- screenshots / result tables for key queries
```

## 🚀 How to Run
1. `psql -U <user> -f data/01_create_database.sql`
2. Connect to the new database: `\c ecommerce_project`
3. `psql -U <user> -d ecommerce_project -f data/02_create_tables.sql`
4. `psql -U <user> -d ecommerce_project -f data/03_insert_data.sql`
5. Run any query from `queries/01_business_questions.sql`.

## 📊 Sample Business Questions Answered
1. Which cities generate the highest total revenue?
2. What are the top 5 best-selling products by quantity?
3. What is the month-over-month revenue trend?
4. Which customers have the highest lifetime value?
5. What % of orders are cancelled vs delivered?
... (see `queries/01_business_questions.sql` for all 52)

## 👤 Author
**Sourabh Kumar**
BBA (Finance), Himachal Pradesh University
GitHub: [sourabh82787](https://github.com/sourabh82787)

# 📊 E-Commerce Sales Analysis — SQL Results & Insights

> Business-focused SQL analysis of an e-commerce dataset using **MySQL 8**.
> 52 business questions covering revenue, customers, products, retention, churn, RFM, trends and operations.

**Database:** `ecommerce_project` | **Tables:** `customers`, `orders`, `order_items`, `products`
**Period covered:** Jan 2025 – Jul 2026 (19 months) | **Currency:** INR (₹)

---

## 🧰 SQL Skills Demonstrated

| Area | Techniques used |
|---|---|
| Aggregation | `SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING` |
| Joins | `INNER JOIN`, `LEFT JOIN` (anti-join), self join (market basket) |
| CTEs & subqueries | Multi-step `WITH` queries, derived tables |
| Window functions | `DENSE_RANK`, `ROW_NUMBER`, `LAG`, `LEAD`, running totals, `SUM() OVER()` |
| Date functions | `DATE_FORMAT`, `DATEDIFF` |
| Conditional logic | `CASE WHEN` for churn, new vs returning, cancellation rate |

---

## 🎯 Headline KPIs

| KPI | Result |
|---|---|
| Total revenue | **₹3,95,53,815** (₹39,553,815) |
| Total orders | **2,000** |
| Total customers | **90** (80 have purchased) |
| Products sold | **38** across 7 categories |
| Average order value | **₹19,776.91** |
| Avg units per order | **7.42** |
| Cancellation rate | **12.00%** (240 orders) |
| Delivered orders | **1,649** |
| Churn rate (no order since 30-Apr-2026) | **5.00%** |
| Best month | **June 2026 — ₹51,71,310** |

---

## 1️⃣ Revenue & Sales Overview

### Monthly revenue and growth (Q9, Q29, Q50)

| Month | Revenue (₹) | MoM growth |
|---|---:|---:|
| 2025-01 | 857,038 | — |
| 2025-02 | 727,020 | -15.17% |
| 2025-03 | 945,215 | 30.01% |
| 2025-04 | 967,341 | 2.34% |
| 2025-05 | 740,314 | -23.47% |
| 2025-06 | 1,415,257 | 91.17% |
| 2025-07 | 1,243,632 | -12.13% |
| 2025-08 | 980,876 | -21.13% |
| 2025-09 | 1,304,388 | 32.98% |
| 2025-10 | 1,729,314 | 32.58% |
| 2025-11 | 2,424,781 | 40.22% |
| 2025-12 | 2,734,547 | 12.78% |
| 2026-01 | 2,601,033 | -4.88% |
| 2026-02 | 1,618,245 | -37.78% |
| 2026-03 | 2,648,708 | 63.68% |
| 2026-04 | 2,957,803 | 11.67% |
| 2026-05 | 3,676,986 | 24.31% |
| **2026-06** | **5,171,310** | 40.64% |
| 2026-07 | 4,810,007 | -6.99% |

**💡 Insights**
- Revenue grew from ~₹0.86M (Jan 2025) to a peak of **₹5.17M (Jun 2026)**.
- Calendar 2025 totalled ₹16.07M; **Jan–Jul 2026 alone reached ₹23.48M** — about **3.4x** the same seven months of 2025 (₹6.90M).
- Clear **festive-season lift** from Sep–Dec 2025, then a dip in Feb 2026 (-37.8%) before recovery.
- July 2026 is the first slowdown after five consecutive growth months.

---

## 2️⃣ Product & Category Performance

### Revenue by category (Q7, Q52)

| Category | Revenue (₹) | Share |
|---|---:|---:|
| Electronics | 25,223,126 | **63.77%** |
| Home & Kitchen | 5,080,392 | 12.84% |
| Clothing | 4,080,449 | 10.32% |
| Sports | 2,064,623 | 5.22% |
| Beauty | 1,829,532 | 4.63% |
| Grocery | 683,745 | 1.73% |
| Books | 591,948 | 1.50% |

### Top 10 products by revenue share (Q28)

| Product | Revenue (₹) | % of total |
|---|---:|---:|
| Smartphone X12 | 9,005,526 | 22.77% |
| Home Theater System | 6,335,604 | 16.02% |
| 4K Action Camera | 3,707,588 | 9.37% |
| Air Fryer | 1,930,071 | 4.88% |
| Smartwatch | 1,839,632 | 4.65% |
| Mechanical Keyboard | 1,371,608 | 3.47% |
| Mixer Grinder | 1,066,419 | 2.70% |
| Winter Jacket | 1,040,653 | 2.63% |
| Non-Stick Cookware Set | 965,580 | 2.44% |
| Bluetooth Speaker | 834,666 | 2.11% |

### Top 5 products by units sold (Q6) and best seller per category (Q22)

| Top by units | Units | | Category | Best-selling product | Units |
|---|---:|---|---|---|---:|
| Smartphone X12 | 474 | | Electronics | Smartphone X12 | 474 |
| Fiction Novel Pack | 458 | | Books | Fiction Novel Pack | 458 |
| Badminton Racket | 457 | | Sports | Badminton Racket | 457 |
| Cricket Bat | 450 | | Grocery | Organic Rice 5kg | 433 |
| Organic Rice 5kg | 433 | | Home & Kitchen | Air Fryer | 429 |
| | | | Clothing | Casual Sneakers | 406 |
| | | | Beauty | Hair Dryer | 399 |

### Other product facts
- Best-selling category by units: **Electronics (3,874 units)** — Q14
- Worst-selling category by units: **Grocery (1,205 units)** — Q48
- Highest-revenue product: **Smartphone X12 (₹9.0M)** — Q15
- Lowest-revenue product: **Self-Help Bestseller (₹135,761)** — Q16
- Most expensive product: **Smartphone X12 (₹18,999)** — Q49

**💡 Insights**
- **Revenue is highly concentrated:** Electronics = 63.8% of revenue, and just 3 products (Smartphone X12, Home Theater System, 4K Action Camera) = **48.2%**.
- Volume and value tell different stories: Books and Grocery sell many units but contribute only **3.2%** of revenue combined.
- Electronics drives almost every large month-over-month jump (Q38), e.g. **+₹948K in Jun 2026** and +₹803K in Mar 2026.

---

## 3️⃣ Customer Analysis

### Top 10 customers by lifetime value (Q21, Q27, Q31)

| Rank | Customer ID | Revenue (₹) |
|---:|---:|---:|
| 1 | 13 | 1,673,772 |
| 2 | 30 | 1,529,530 |
| 3 | 46 | 1,500,017 |
| 4 | 77 | 1,338,409 |
| 5 | 25 | 1,322,346 |
| 6 | 68 | 1,285,761 |
| 7 | 74 | 1,280,445 |
| 8 | 43 | 1,145,022 |
| 9 | 41 | 1,102,554 |
| 10 | 24 | 1,085,611 |

### Customers with the highest average order value (Q19)

| Customer ID | Avg order value (₹) |
|---:|---:|
| 79 | 39,412.80 |
| 45 | 36,465.65 |
| 76 | 36,202.00 |
| 72 | 32,881.75 |
| 59 | 32,559.91 |

### Revenue by city (Q10, Q20)

| City | Revenue (₹) |
|---|---:|
| **Delhi** | 5,435,283 |
| Bengaluru | 5,006,267 |
| Kolkata | 4,635,728 |
| Jaipur | 4,440,314 |
| Varanasi | 3,692,258 |
| Lucknow | 3,455,692 |
| Pune | 3,304,948 |
| Chennai | 3,251,145 |
| Mumbai | 2,607,841 |
| Hyderabad | 1,873,698 |
| Surat | 1,203,621 |
| Ahmedabad | 647,020 |

### Revenue by gender (Q44)

| Gender | Revenue (₹) | Share |
|---|---:|---:|
| Male | 20,859,804 | 52.7% |
| Female | 18,694,011 | 47.3% |

**💡 Insights**
- The top 10 customers contribute roughly **₹13.7M (~35%)** of revenue from only ~11% of the customer base.
- Delhi, Bengaluru and Kolkata together generate **~37%** of revenue; Ahmedabad and Surat are the weakest cities.
- Revenue split by gender is fairly balanced (53/47).
- The largest single order is **₹176,982 (Order 891, Customer 72)**; **1,066 of 2,000 orders (53%)** exceed ₹10,000 (Q18, Q30).

---

## 4️⃣ Retention, Churn & Behaviour

| Metric | Result | Query |
|---|---|---|
| Customers who never ordered | **10 of 90** (11.1%) | Q12 |
| Customers with 2+ orders | **80** (100% of purchasing customers) | Q11, Q32 |
| Churn rate | **5.00%** | Q45 |
| New-customer orders vs returning-customer orders | 83 vs **1,917** | Q33 |
| Highest order count (single customer) | 79 orders (Customer 25) | Q11 |
| Fastest repeat buyer | Customer 43 — avg **0.73 days** between orders | Q37 |

### Active customers per month (Q34) — growth in the base

| Month | Active customers |
|---|---:|
| 2025-01 | 19 |
| 2025-06 | 30 |
| 2025-12 | 41 |
| 2026-03 | 43 |
| 2026-05 | 53 |
| 2026-06 | 54 |
| **2026-07** | **63** |

### New customers acquired by month (Q51)
Jan 2025 had 19 first-time buyers (initial base); after that, 1–6 new customers per month. **No new customers were acquired in Feb 2026.**

**💡 Insights**
- **Returning customers drive 96% of orders** — growth is mostly from deeper engagement of existing customers, not acquisition.
- The active base more than tripled (19 → 63) over 19 months.
- Customers buy across categories: many have purchased from **all 7 categories** (Q35), a good sign for cross-sell.
- Co-purchase analysis (Q36) shows the most frequent product pairs appear only 13–15 times, i.e. no dominant bundle — bundling should be tested, not assumed.

---

## 5️⃣ Operations

| Status | Orders |
|---|---:|
| Delivered | 1,649 |
| Cancelled | 240 (**12.0%**) |
| Other statuses | 111 |

**💡 Insight:** 1 in 8 orders is cancelled — a direct revenue-leakage and logistics-cost issue worth deeper root-cause analysis (by category, city, order value).

---

## ✅ Key Business Recommendations

1. **Reduce Electronics dependency** — 64% of revenue sits in one category and ~48% in three SKUs; grow Home & Kitchen, Clothing and Sports to de-risk.
2. **Protect and reward top customers** — ~11% of customers generate ~35% of revenue; a loyalty or VIP programme is justified.
3. **Re-activate the at-risk group** — target customers inactive since April 2026 and the 10 customers who never purchased.
4. **Cut the 12% cancellation rate** — investigate by category, city and payment/delivery stage.
5. **Plan inventory and campaigns around the festive peak** (Oct–Dec) and the Jun 2026 spike.
6. **Invest in acquisition** — new-customer inflow is low (≈2–6 per month) relative to the retention strength.

---


## 👤 Author

**Sourabh Kumar** — Aspiring Data Analyst
📧 Sourabhkumar82787@gmail.com
🐙 [github.com/sourabh82787](https://github.com/sourabh82787)

**Tools:** MySQL 8 · Advanced Excel · Power BI · SQL · Python

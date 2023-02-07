  
-- A. HIGH LEVEL ANALYSIS

-- 1. What was the total quantity sold for all products?

SELECT
product_id,
product_name,
SUM(qty) quantity_sold
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2
ORDER BY 3 DESC

-- 2. What is the total generated revenue for all products before discounts?

SELECT
product_id,
product_name,
SUM(qty*pd.price) AS revenue_before_discount,
SUM(SUM(qty*pd.price)) OVER () AS total_revenue
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2
ORDER BY 3 DESC

-- 3. What was the total discount amount for all products?

SELECT
product_id,
product_name,
SUM(pd.price*qty*s.discount)/100 AS product_discount,
ROUND((SUM(SUM(pd.price*qty*s.discount)) OVER ()) / 100, 2) AS total_discount
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2
ORDER BY 3 DESC


-- B. TRANSACTION ANALYSIS

-- 1. How many unique transactions were there?

SELECT
COUNT(DISTINCT txn_id)
FROM sales

-- 2. What is the average unique products purchased in each transaction?

-- SOLUTION 1:
WITH products_per_txn AS( 
SELECt
	txn_id,
	COUNT(DISTINCT prod_id) AS product_count
FROM sales
GROUP BY 1
)

SELECT
ROUND(AVG(product_count))
FROM products_per_txn

-- SOLUTION 2:

SELECT
COUNT(prod_id)/COUNT(DISTINCT txn_id)
FROM sales

-- 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?

-- question unclear, solution A with discount and solution B without discount

WITH txn_revenue_1 AS (
SELECT
	txn_id,
	SUM(qty*(price - price*discount/100)) AS revenue_per_txn
FROM sales
GROUP BY 1
)

SELECT
PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue_per_txn) AS pct_25,
PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY revenue_per_txn) AS pct_50,
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue_per_txn) AS pct_75
FROM txn_revenue_1




WITH txn_revenue_2 AS (
SELECT
	txn_id,
	SUM(qty*price) as revenue_per_txn
FROM sales
GROUP BY 1
)

SELECT
PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue_per_txn) AS pct_25,
PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY revenue_per_txn) AS pct_50,
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue_per_txn) AS pct_75
FROM txn_revenue_2		
		
-- 4. What is the average discount value per transaction?

WITH discounts_cte AS (
SELECT
	txn_id,
	SUM(1.0*price*qty*discount)/100 AS discount_per_txn
FROM sales
GROUP BY 1
)

SELECT 
ROUND(AVG(discount_per_txn),2) AS average_discount
FROM discounts_cte

-- 5. What is the percentage split of all transactions for members vs non-members?

-- SOLUTION 1 ( with subquery):

SELECT
member,
ROUND(100*1.0*COUNT(DISTINCT txn_id)/(SELECT 
					    			  COUNT(DISTINCT txn_id)
					    			  FROM sales), 2) AS transactions_pct
FROM sales
GROUP BY 1

-- SOLUTION 2 ( with CTE and count):

WITH cte_member_transactions AS (
SELECT
    member,
    COUNT(DISTINCT txn_id) AS transactions
FROM sales
GROUP BY member
)

SELECT
member,
transactions,
ROUND(100 * transactions / SUM(transactions) OVER ()::NUMERIC)
FROM cte_member_transactions
GROUP BY member, transactions;

-- 6. What is the average revenue for member transactions and non-member transactions?

-- again, solution A with discount, solution B without it:

WITH txn_revenue_1 AS (
SELECT
	txn_id,
	member,
	SUM(qty*(price - price*discount/100)) AS revenue_per_txn
FROM sales
GROUP BY 1,2
)

SELECT 
member,
AVG(revenue_per_txn)
FROM txn_revenue_1
GROUP BY 1




WITH txn_revenue_2 AS (
SELECT
	txn_id,
	member,
	SUM(qty*price) AS revenue_per_txn
FROM sales
GROUP BY 1,2
)

SELECT 
member,
ROUND(AVG(revenue_per_txn),2)
FROM txn_revenue_2
GROUP BY 1


-- C. PRODUCT ANALYSIS

-- 1. What are the top 3 products by total revenue before discount?

SELECT
prod_id,
product_name,
SUM(qty*s.price) AS revenue_from_product
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2
ORDER BY 3 DESC

-- 2. What is the total quantity, revenue and discount for each segment?

SELECT
segment_name,
SUM(qty) AS total_quantity_per_segment,
SUM(qty*s.price) AS total_revenue_per_segment,
ROUND(SUM(1.0*qty*s.price*discount)/100,2) AS total_discount_per_segment
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY segment_name
ORDER BY segment_name

-- 3. What is the top selling product for each segment?

WITH qty_sold_rank AS (
SELECT
	segment_name,
	product_id,
	product_name,
	SUM(qty) as products_sold,
	RANK() OVER (PARTITION BY segment_name ORDER BY SUM(qty) DESC) AS rank
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2,3
ORDER BY 4 DESC
)

SELECT 
*
FROM qty_sold_rank
WHERE rank=1

-- 4. What is the total quantity, revenue and discount for each category?

SELECT
category_name,
SUM(qty) AS total_quantity_per_segment,
SUM(qty*s.price) AS total_revenue_per_segment,
ROUND(SUM(1.0*qty*s.price*discount)/100,2) AS total_discount_per_segment
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1
ORDER BY 1

-- 5. What is the top selling product for each category?

WITH qty_sold_rank AS (
SELECT
category_name,
product_name,
SUM(qty) AS products_sold,
RANK() OVER (PARTITION BY category_name ORDER BY SUM(qty) DESC) AS rank
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2
ORDER BY 3 DESC
)

SELECT 
*
FROM qty_sold_rank
WHERE rank=1

-- 6. What is the percentage split of revenue by product for each segment?

WITH segment_split AS (
SELECT
	segment_name,
	product_name,
	SUM(qty*s.price) AS revenue,
	SUM(SUM(qty*s.price)) OVER (PARTITION BY segment_name) AS revenue_per_segment
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2
) 

SELECT 
*,
ROUND(1.0*100*revenue/revenue_per_segment,2) AS pct_of_segment
FROM segment_split
ORDER BY 1,3

-- 7. What is the percentage split of revenue by segment for each category?

WITH category_split AS (
SELECT
	category_name,
	segment_name,
	SUM(qty*s.price) AS revenue,
	SUM(SUM(qty*s.price)) OVER (PARTITION BY category_name) AS revenue_per_category
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2
) 

SELECT 
*,
ROUND(1.0*100*revenue/revenue_per_category,2) AS pct_of_category
FROM category_split
ORDER BY 1,3 DESC

-- 8. What is the percentage split of total revenue by category?

-- SOLUTION 1 (with subquery):

SELECT
category_name,
SUM(qty*s.price) as revenue,
ROUND(1.0*100*SUM(qty*s.price)/(SELECT
				  				SUM(qty*s.price)
				  				FROM product_details pd
				  				JOIN sales s ON pd.product_id=s.prod_id),2) AS pct_of_total
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1

-- SOLUTION 2 (with CTE):

WITH cte_category_revenue AS (
SELECT
    pd.category_id,
    pd.category_name,
    SUM(s.qty * s.price) AS category_revenue
FROM sales s
INNER JOIN product_details pd ON s.prod_id = pd.product_id
GROUP BY
    pd.category_id,
    pd.category_name
)

SELECT
*,
ROUND(100 * category_revenue / SUM(category_revenue) OVER (), 2) AS category_revenue_percentage
FROM cte_category_revenue
ORDER BY category_id;

-- 9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)

-- SOLUTION 1:

SELECT
pd.product_id,
product_name,
ROUND(1.0*100*COUNT(txn_id)/(SELECT
			  				 COUNT(DISTINCT txn_id)
			  				 FROM sales),2) AS penetration
FROM product_details pd
JOIN sales s ON pd.product_id=s.prod_id
GROUP BY 1,2
ORDER BY 3 DESC

-- SOLUTION 2:

WITH product_transactions AS (
SELECT DISTINCT
    prod_id,
    COUNT(DISTINCT txn_id) AS product_transactions
FROM sales
GROUP BY prod_id
)

, total_transactions AS (
SELECT
    COUNT(DISTINCT txn_id) AS total_transaction_count
FROM sales
)

SELECT
product_details.product_id,
product_details.product_name,
ROUND(
	100 * product_transactions.product_transactions::NUMERIC
    / total_transactions.total_transaction_count,
	2
) AS penetration_percentage
FROM product_transactions
CROSS JOIN total_transactions
INNER JOIN product_details ON product_transactions.prod_id = product_details.product_id
ORDER BY penetration_percentage DESC;

-- 10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

WITH product_cte AS (
SELECT 
	s.txn_id,
	pd.product_id,
	pd.product_name
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id
)

SELECT
p1.product_name,
p2.product_name,
p3.product_name,
COUNT(*) AS count
FROM product_cte p1
JOIN product_cte p2 ON p1.txn_id=p2.txn_id
					AND p1.product_id<p2.product_id
JOIN product_cte p3 ON p2.txn_id=p3.txn_id
					AND p2.product_id<p3.product_id
GROUP BY 1,2,3
ORDER BY 4 DESC
LIMIT 5;

-- SOLUTION 2 (with Super bonus - what are the quantity, revenue, discount and net revenue from the top 3 products in the transactions where all 3 were purchased?)

-- step 1: check the product_counter...

DROP TABLE IF EXISTS temp_product_combos;
CREATE TEMP TABLE temp_product_combos AS
WITH RECURSIVE input(product) AS (
SELECT 
	product_id::TEXT 
FROM product_details
)

, output_table AS (
SELECT 
    ARRAY[product] AS combo,
    product,
    1 AS product_counter
FROM input
  
UNION ALL 

SELECT
    ARRAY_APPEND(output_table.combo, input.product),
    input.product,
    product_counter + 1
FROM output_table
INNER JOIN input ON input.product > output_table.product
WHERE output_table.product_counter <= 2
)

SELECT * from output_table
WHERE product_counter = 3;

-- SELECT * FROM temp_product_combos

-- step 2

WITH cte_transaction_products AS (
SELECT
    txn_id,
    ARRAY_AGG(prod_id::TEXT ORDER BY prod_id) AS products
FROM sales
GROUP BY txn_id
)

-- step 3
, cte_combo_transactions AS (
SELECT
    txn_id,
    combo,
    products
FROM cte_transaction_products
CROSS JOIN temp_product_combos  
WHERE combo <@ products  
)

-- step 4
, cte_ranked_combos AS (
SELECT
    combo,
    COUNT(DISTINCT txn_id) AS transaction_count,
    RANK() OVER (ORDER BY COUNT(DISTINCT txn_id) DESC) AS combo_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(DISTINCT txn_id) DESC) AS combo_id
FROM cte_combo_transactions
GROUP BY combo
)

-- step 5
, cte_most_common_combo_product_transactions AS (
SELECT
    cte_combo_transactions.txn_id,
    cte_ranked_combos.combo_id,
    UNNEST(cte_ranked_combos.combo) AS prod_id
FROM cte_combo_transactions
INNER JOIN cte_ranked_combos ON cte_combo_transactions.combo = cte_ranked_combos.combo
WHERE cte_ranked_combos.combo_rank = 1
)

-- step 6
SELECT
product_details.product_id,
product_details.product_name,
COUNT(DISTINCT sales.txn_id) AS combo_transaction_count,
SUM(sales.qty) AS quantity,
SUM(sales.qty * sales.price) AS revenue,
ROUND(
  SUM(sales.qty * sales.price * sales.discount)::NUMERIC / 100,             
  2
) AS discount,
ROUND(
  SUM(sales.qty * sales.price * (100 - sales.discount))::NUMERIC/ 100,      
  2
) AS net_revenue
FROM sales
INNER JOIN cte_most_common_combo_product_transactions AS top_combo
  ON sales.txn_id = top_combo.txn_id
  AND sales.prod_id = top_combo.prod_id
INNER JOIN product_details
  ON sales.prod_id = product_details.product_id
GROUP BY product_details.product_id, product_details.product_name;


-- D. REPORTING CHALLENGE
/*
Write a single SQL script that combines all of the previous questions into a scheduled report that the Balanced Tree team can run at the beginning of each month to calculate the previous month’s values.

Imagine that the Chief Financial Officer (which is also Danny) has asked for all of these questions at the end of every month.

He first wants you to generate the data for January only - but then he also wants you to demonstrate that you can easily run the samne analysis for February without many changes (if at all).

Feel free to split up your final outputs into as many tables as you need - but be sure to explicitly reference which table outputs relate to which question for full marks :)
*/

-- This can be done by making a parameter TEMP TABLE which we use to join with all previously obtained tables


-- E. BONUS CHALLENGE
/*
Use a single SQL query to transform the product_hierarchy and product_prices datasets to the product_details table.

Hint: you may want to consider using a recursive CTE to solve this problem!
*/

-- Solution 1: non-recursive CTE
WITH hierarchy_cte AS (
SELECT
	id,
	level_text AS style_name,
	id AS style_id,
	CASE WHEN parent_id=3 THEN 'Jeans' 
	 	WHEN parent_id=4 THEN 'Jacket'
	 	WHEN parent_id=5 THEN 'Shirt'
	 	WHEN parent_id=6 THEN 'Socks' END AS segment_name,
	CASE WHEN parent_id IN (3,4) THEN 'Womens' 
	 	WHEN parent_id IN (5,6) THEN 'Mens' END AS category_name,
	CASE WHEN parent_id=3 THEN 3
	 	WHEN parent_id=4 THEN 4
	 	WHEN parent_id=5 THEN 5
	 	WHEN parent_id=6 THEN 6 END AS segment_id
FROM product_hierarchy
WHERE id>=7
)

SELECT 
product_id,
price,
style_name ||' - '|| category_name AS product_name,
CASE WHEN segment_id IN (3,4) THEN 1 
	 WHEN segment_id IN (5,6) THEN 2 END AS category_id,
segment_id,
style_id,
category_name,
segment_name,
style_name
FROM hierarchy_cte hc
JOIN product_prices pp ON hc.id=pp.id

-- Solution 2: recursive CTE

WITH RECURSIVE hierarchy_CTE AS (
SELECT 
	id,
	parent_id,
	level_text,
	level_name,
	1 AS level_count,
	0 AS category_id,
	level_text AS category,
	0 AS segment_id,
	CAST('' AS VARCHAR(19)) AS segment,
	0 AS style_id
FROM product_hierarchy
WHERE parent_id IS NULL

UNION ALL

SELECT 
	p.id,
	p.parent_id,
	p.level_text,
	p.level_name,
	level_count + 1,
	CASE WHEN level_count = 1 THEN h.id ELSE category_id END,
	CASE WHEN level_count = 1 THEN h.level_text ELSE category END,
	CASE WHEN level_count = 2 THEN h.id ELSE segment_id END,
	CASE WHEN level_count = 2 THEN h.level_text ELSE segment END,
	p.id
FROM hierarchy_CTE AS h
JOIN product_hierarchy AS p ON h.id = p.parent_id
)

--intermediary step to help visualize our progress

/*SELECT 
*
FROM hierarchy_CTE
*/

SELECT 
prices.product_id,
prices.price,
(hierarchy.level_text || ' ' || segment || ' - '  || category) AS product_name,
hierarchy.category_id,
hierarchy.segment_id,
hierarchy.style_id,
hierarchy.category AS category_name,
hierarchy.segment AS segment_name,
hierarchy.level_text AS style_name
--INTO #new_product_details
FROM hierarchy_CTE AS hierarchy
JOIN product_prices AS prices
ON hierarchy.id = prices.id
ORDER BY hierarchy.id;

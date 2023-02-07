
-- A. CUSTOMER NODES EXPLORATION
-- 1. How many unique nodes are there on the Data Bank system?

WITH combinations AS (
SELECT DISTINCT
	region_id,
	node_id
FROM customer_nodes
--ORDER BY 1,2
)
SELECT 
COUNT(*) 
FROM combinations;

-- 2. What is the number of nodes per region?

SELECT
region_name,
COUNT(DISTINCT node_id)
FROM customer_nodes cn
JOIN regions r ON cn.region_id=r.region_id
GROUP BY 1

-- 3. How many customers are allocated to each region?
SELECT
region_name,
COUNT(DISTINCT customer_id)
FROM customer_nodes cn
JOIN regions r ON cn.region_id=r.region_id
GROUP BY 1

-- 4. How many days on average are customers reallocated to a different node?

-- step 1: create a table with row numbers and duration
DROP TABLE IF EXISTS ranked_customer_nodes;
CREATE TEMP TABLE ranked_customer_nodes AS
SELECT
	customer_id,
	node_id,
	region_id,
	DATE_PART('day', AGE(end_date,start_date))::INTEGER AS duration,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY start_date) AS rn
FROM customer_nodes;

WITH RECURSIVE output_table AS (
SELECT
    customer_id,
    node_id,
    duration,
    rn,
    1 AS run_id
FROM ranked_customer_nodes
WHERE rn = 1

UNION ALL

SELECT
	t1.customer_id,
	t2.node_id,
	t2.duration,
	t2.rn,
	-- update run_id if the node_id values do not match
	CASE WHEN t1.node_id != t2.node_id THEN t1.run_id + 1
     	ELSE t1.run_id
     	END AS run_id
FROM output_table t1
INNER JOIN ranked_customer_nodes t2 ON t1.rn + 1 = t2.rn
									AND t1.customer_id = t2.customer_id
									And t2.rn > 1
)

,cte_customer_nodes AS (
SELECT
    customer_id,
    run_id,
    SUM(duration) AS node_duration
FROM output_table
GROUP BY
    customer_id,
    run_id
ORDER BY 1,2
)

SELECT
ROUND(AVG(node_duration)) AS average_node_duration
FROM cte_customer_nodes;

-- 5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

WITH RECURSIVE output_table AS (
SELECT
    customer_id,
    node_id,
    region_id,
    duration,
    rn,
    1 AS run_id
FROM ranked_customer_nodes  -- using the temp table we created previously
WHERE rn = 1

UNION ALL

SELECT
    t1.customer_id,
    t2.node_id,
    t2.region_id,
    t2.duration,
    t2.rn,
    -- update run_id if the node_id values do not match
    CASE WHEN t1.node_id != t2.node_id THEN t1.run_id + 1
         ELSE t1.run_id
         END AS run_id
FROM output_table t1
INNER JOIN ranked_customer_nodes t2 ON t1.rn + 1 = t2.rn
    								AND t1.customer_id = t2.customer_id
    								And t2.rn > 1
)

, cte_customer_nodes AS (
SELECT
    customer_id,
    run_id,
    region_id,
    SUM(duration) AS node_duration
FROM output_table
GROUP BY
    customer_id,
    run_id,
    region_id
)

SELECT
regions.region_name,
ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY node_duration)) AS median_node_duration,
ROUND(PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY node_duration)) AS pct80_node_duration,
ROUND(PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY node_duration)) AS pct95_node_duration
FROM cte_customer_nodes
INNER JOIN regions ON cte_customer_nodes.region_id = regions.region_id
GROUP BY regions.region_name, regions.region_id
ORDER BY regions.region_id;


-- B. CUSTOMER TRANSACTIONS
-- 1. What is the unique count and total amount for each transaction type?

SELECT
txn_type,
COUNT(*),
SUM(txn_amount) AS total_amount
FROM customer_transactions
GROUP BY 1

-- 2. What is the average total historical deposit counts and amounts for all customers?

WITH cte_customer AS (
SELECT
	customer_id,
	COUNT(*) AS deposit_count,
	SUM(txn_amount) AS deposit_amount
FROM customer_transactions
WHERE txn_type = 'deposit'
GROUP BY customer_id
)

SELECT
ROUND(AVG(deposit_count)) AS avg_deposit_count,
ROUND(SUM(deposit_amount) / SUM(deposit_count)) AS avg_deposit_amount
FROM cte_customer;

-- 3. For each month - how many Data Bank customers make more than 1 deposit and at least either 1 purchase or 1 withdrawal in a single month?

WITH transaction_types AS (
SELECT 
	customer_id,
	DATE_PART('month', txn_date) as month_part,
	TO_CHAR(txn_date, 'MONTH') as month,
	SUM(CASE WHEN txn_type='deposit' THEN 1 ELSE 0 END) as deposits,
	SUM(CASE WHEN txn_type='purchase' THEN 1 ELSE 0 END) purchases,
	SUM(CASE WHEN txn_type='withdrawal' THEN 1 ELSE 0 END) withdrawals
FROM customer_transactions
GROUP BY 1,2,3
ORDER BY 1,2,3
)

SELECT 
month,
COUNT(customer_id)
FROM transaction_types
WHERE deposits>1 AND (purchases>=1 OR withdrawals>=1)
GROUP BY month, month_part
ORDER BY month_part

-- 4. What is the closing balance for each customer at the end of the month? Also show the change in balance each month in the same table output.

-- SOLUTION 1 (one way of displaying):

WITH monthly_txn AS (
SELECT
	customer_id,
	(DATE_TRUNC('month', txn_date) + INTERVAL '1 month' - INTERVAL '1 day')::DATE as month,
	SUM(CASE WHEN txn_type='deposit' THEN txn_amount
			 ELSE -txn_amount END) as monthly_balance
FROM customer_transactions
GROUP BY 1,2
ORDER BY 1,2
)

SELECT 
customer_id,
month,
SUM(monthly_balance) OVER (PARTITION BY customer_id ORDER BY month 
							ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS closing_balance
FROM monthly_txn
ORDER BY customer_id
LIMIT 20;

-- SOLUTION 2 (another way, by filling up the "missing" values of months when no change was recorded with the previous month's value)

WITH cte_monthly_balances AS (
SELECT
	customer_id,
	DATE_TRUNC('mon', txn_date)::DATE AS month,
	SUM(CASE WHEN txn_type = 'deposit' THEN txn_amount ELSE (-txn_amount) END) AS balance
FROM customer_transactions
GROUP BY customer_id, month
ORDER BY customer_id, month
)

, cte_generated_months AS (
SELECT
    DISTINCT customer_id,
    ('2020-01-01'::DATE + GENERATE_SERIES(0, 3) * INTERVAL '1 MONTH')::DATE AS month
FROM customer_transactions
ORDER BY customer_id
)

SELECT
cte_generated_months.customer_id,
cte_generated_months.month,
COALESCE(cte_monthly_balances.balance, 0) AS balance_contribution,
SUM(cte_monthly_balances.balance) OVER (
    PARTITION BY cte_generated_months.customer_id             
    ORDER BY cte_generated_months.month
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ending_balance
FROM cte_generated_months
LEFT JOIN cte_monthly_balances ON cte_generated_months.month = cte_monthly_balances.month
  							   AND cte_generated_months.customer_id = cte_monthly_balances.customer_id
WHERE cte_generated_months.customer_id BETWEEN 1 and 3;

-- 5. Comparing the closing balance of a customer’s first month and the closing balance from their second month, what percentage of customers:
/*    Have a negative first month balance?
      Have a positive first month balance?
      Increase their opening month’s positive closing balance by more than 5% in the following month?
      Reduce their opening month’s positive closing balance by more than 5% in the following month?
      Move from a positive balance in the first month to a negative balance in the second month?
*/

WITH cte_monthly_balances AS (
SELECT
    customer_id,
    DATE_TRUNC('mon', txn_date)::DATE AS month,
    SUM(CASE WHEN txn_type = 'deposit' THEN txn_amount ELSE (-txn_amount) END) AS balance
FROM customer_transactions
GROUP BY customer_id, month
ORDER BY customer_id, month
)

, cte_generated_months AS (
SELECT
    customer_id,
    (DATE_TRUNC('mon', MIN(txn_date))::DATE + GENERATE_SERIES(0, 1) * INTERVAL '1 MONTH')::DATE AS month,
    GENERATE_SERIES(1, 2) AS month_number
FROM customer_transactions
GROUP BY customer_id
)

, cte_monthly_transactions AS (
SELECT
    cte_generated_months.customer_id,
    cte_generated_months.month,
    cte_generated_months.month_number,
    COALESCE(cte_monthly_balances.balance, 0) AS transaction_amount
FROM cte_generated_months
LEFT JOIN cte_monthly_balances ON cte_generated_months.month = cte_monthly_balances.month
    						   AND cte_generated_months.customer_id = cte_monthly_balances.customer_id
)

, cte_monthly_aggregates AS (
SELECT
    customer_id,
    month_number,
    LAG(transaction_amount) OVER (PARTITION BY customer_id ORDER BY month) AS previous_month_transaction_amount,
    transaction_amount
FROM cte_monthly_transactions
)

, cte_calculations AS (
SELECT
    COUNT(DISTINCT customer_id) AS customer_count,
    SUM(CASE WHEN previous_month_transaction_amount > 0 THEN 1 ELSE 0 END) AS positive_first_month,
    SUM(CASE WHEN previous_month_transaction_amount < 0 THEN 1 ELSE 0 END) AS negative_first_month,
    SUM(CASE WHEN previous_month_transaction_amount > 0
              --AND transaction_amount > 0
              AND transaction_amount > 1.05 * previous_month_transaction_amount
              THEN 1
              ELSE 0
    END
    ) AS increase_count,
    SUM(CASE WHEN previous_month_transaction_amount > 0
             --AND transaction_amount > 0
             AND transaction_amount < 0.95 * previous_month_transaction_amount
             THEN 1
             ELSE 0
    END
    ) AS decrease_count,
    SUM(CASE WHEN previous_month_transaction_amount > 0
             AND transaction_amount < 0
             AND transaction_amount < -previous_month_transaction_amount
             THEN 1
             ELSE 0 
	END
    ) AS negative_count
FROM cte_monthly_aggregates
WHERE previous_month_transaction_amount IS NOT NULL
)

SELECT
ROUND(100 * positive_first_month / customer_count, 2) AS positive_pc,
ROUND(100 * negative_first_month / customer_count, 2) AS negative_pc,
ROUND(100 * increase_count / positive_first_month, 2) AS increase_pc,
ROUND(100 * decrease_count / positive_first_month, 2) AS decrease_pc,
ROUND(100 * negative_count / positive_first_month, 2) AS negative_balance_pc
FROM cte_calculations;


/* 
C. To test out a few different hypotheses - the Data Bank team wants to run an experiment where different groups of customers would be allocated data using 3 different options:

Option 1: data is allocated based off the amount of money at the end of the previous month
Option 2: data is allocated on the average amount of money kept in the account in the previous 30 days
Option 3: data is updated real-time
For this multi-part challenge question - you have been requested to generate the following data elements to help the Data Bank team estimate how much data will need to be provisioned for each option:
*/

-- running customer balance column that includes the impact of each transaction

WITH txn_cte AS (
SELECT
	customer_id,
	txn_date,
	txn_type,
	txn_amount,
	CASE WHEN txn_type='deposit' THEN txn_amount
		 ELSE -txn_amount END AS txn_sign
FROM customer_transactions 
ORDER BY customer_id, txn_date, txn_type
)

SELECT 
customer_id,
txn_date,
txn_type,
txn_sign,
SUM(txn_sign) OVER (PARTITION BY customer_id ORDER BY txn_date 
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance
FROM txn_cte
ORDER BY 1,2,3
LIMIT 20;
			
-- customer balance at the end of each month

WITH monthly_txn AS (
SELECT
	customer_id,
	(DATE_TRUNC('month', txn_date) + INTERVAL '1 month' - INTERVAL '1 day')::DATE as month,
	SUM(CASE WHEN txn_type='deposit' THEN txn_amount
		 	 ELSE -txn_amount END) as monthly_balance
FROM customer_transactions
GROUP BY 1,2
ORDER BY 1,2
)

SELECT 
customer_id,
month,
SUM(monthly_balance) OVER (PARTITION BY customer_id ORDER BY month 
							ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS closing_balance
FROM monthly_txn
ORDER BY customer_id
LIMIT 20;

-- minimum, average and maximum values of the running balance for each customer

WITH txn_cte AS (
SELECT
	customer_id,
	txn_date,
	txn_type,
	txn_amount,
	CASE WHEN txn_type='deposit' THEN txn_amount
		 ELSE -txn_amount END as txn_sign
FROM customer_transactions 
ORDER BY customer_id, txn_date, txn_type
)

, running_cte AS (
SELECT 
	customer_id,
	txn_date,
	txn_type,
	txn_sign,
	SUM(txn_sign) OVER (PARTITION BY customer_id ORDER BY txn_date 
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance
FROM txn_cte
ORDER BY 1,2,3
)

SELECT 
customer_id,
MIN(running_balance),
MAX(running_balance),
ROUND(AVG(running_balance),2)
FROM running_cte
GROUP BY 1
LIMIT 20;

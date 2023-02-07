# Case Study #4 - Data Bank

![Data Bank logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%204.png)

## 📚  Table of Contents

-   [📋  Introduction](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#briefcase-business-case)
-   [📄 Available Data](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#bookmark_tabsexample-datasets)
-   [❓  Case Study Questions](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#triangular_flag_on_post-questions-and-solution)
-  [✔️  Solutions](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#triangular_flag_on_post-questions-and-solution)

# Introduction

There is a new innovation in the financial industry called Neo-Banks: new aged digital only banks without physical branches.

Danny thought that there should be some sort of intersection between these new age banks, cryptocurrency and the data world…so he decides to launch a new initiative - Data Bank!

Data Bank runs just like any other digital bank - but it isn’t only for banking activities, they also have the world’s most secure distributed data storage platform!

Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. There are a few interesting caveats that go with this business model, and this is where the Data Bank team need your help!

The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.

This case study is all about calculating metrics, growth and helping the business analyse their data in a smart way to better forecast and plan for their future developments!

# Available Data

The Data Bank team have prepared a data model for this case study as well as a few example rows from the complete dataset below to get you familiar with their tables.

## Entity Relationship Diagram

![Data Bank ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%204%20ERD.png)

## Datasets

### Table 1: Regions

Just like popular cryptocurrency platforms - Data Bank is also run off a network of nodes where both money and data is stored across the globe. In a traditional banking sense - you can think of these nodes as bank branches or stores that exist around the world.

This  `regions`  table contains the  `region_id`  and their respective  `region_name`  values

| region_id | region_name |
|-----------|-------------|
| 1         | Africa      |
| 2         | America     |
| 3         | Asia        |
| 4         | Europe      |
| 5         | Oceania     |

### Table 2: Customer Nodes

Customers are randomly distributed across the nodes according to their region - this also specifies exactly which node contains both their cash and data.

This random distribution changes frequently to reduce the risk of hackers getting into Data Bank’s system and stealing customer’s money and data!

Below is a sample of the top 10 rows of the  `data_bank.customer_nodes`

| customer_id | region_id | node_id | start_date | end_date   |
|-------------|-----------|---------|------------|------------|
| 1           | 3         | 4       | 2020-01-02 | 2020-01-03 |
| 2           | 3         | 5       | 2020-01-03 | 2020-01-17 |
| 3           | 5         | 4       | 2020-01-27 | 2020-02-18 |
| 4           | 5         | 4       | 2020-01-07 | 2020-01-19 |
| 5           | 3         | 3       | 2020-01-15 | 2020-01-23 |
| 6           | 1         | 1       | 2020-01-11 | 2020-02-06 |
| 7           | 2         | 5       | 2020-01-20 | 2020-02-04 |
| 8           | 1         | 2       | 2020-01-15 | 2020-01-28 |
| 9           | 4         | 5       | 2020-01-21 | 2020-01-25 |
| 10          | 3         | 4       | 2020-01-13 | 2020-01-14 |

### Table 3: Customer Transactions

This table stores all customer deposits, withdrawals and purchases made using their Data Bank debit card.

| customer_id | txn_date   | txn_type | txn_amount |
|-------------|------------|----------|------------|
| 429         | 2020-01-21 | deposit  | 82         |
| 155         | 2020-01-10 | deposit  | 712        |
| 398         | 2020-01-01 | deposit  | 196        |
| 255         | 2020-01-14 | deposit  | 563        |
| 185         | 2020-01-29 | deposit  | 626        |
| 309         | 2020-01-13 | deposit  | 995        |
| 312         | 2020-01-20 | deposit  | 485        |
| 376         | 2020-01-03 | deposit  | 706        |
| 188         | 2020-01-13 | deposit  | 601        |
| 138         | 2020-01-11 | deposit  | 520        |

# Case Study Questions

The following case study questions include some general data exploration analysis for the nodes and transactions before diving right into the core business questions and finishes with a challenging final request!

## A. Customer Nodes Exploration

1.  How many unique nodes are there on the Data Bank system?
2.  What is the number of nodes per region?
3.  How many customers are allocated to each region?
4.  How many days on average are customers reallocated to a different node?
5.  What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

## B. Customer Transactions

1.  What is the unique count and total amount for each transaction type?
2.  What is the average total historical deposit counts and amounts for all customers?
3.  For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
4.  What is the closing balance for each customer at the end of the month?
5.  Comparing the closing balance of a customer’s first month and the closing balance from their second nth, what percentage of customers:

-   Have a negative first month balance?
-   Have a positive first month balance?
-   Increase their opening month’s positive closing balance by more than 5% in the following month?
-   Reduce their opening month’s positive closing balance by more than 5% in the following month?
-   Move from a positive balance in the first month to a negative balance in the second month?

# Solutions

## A. CUSTOMER NODES EXPLORATION
1. How many unique nodes are there on the Data Bank system?

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
	
	| count |
	|-------|
	| 25    |

2. What is the number of nodes per region?

		SELECT
		region_name,
		COUNT(DISTINCT node_id)
		FROM customer_nodes cn
		JOIN regions r ON cn.region_id=r.region_id
		GROUP BY 1

	| region_name | count |
	|-------------|-------|
	| Africa      | 5     |
	| America     | 5     |
	| Asia        | 5     |
	| Australia   | 5     |
	| Europe      | 5     |

3. How many customers are allocated to each region?

		SELECT
		region_name,
		COUNT(DISTINCT customer_id)
		FROM customer_nodes cn
		JOIN regions r ON cn.region_id=r.region_id
		GROUP BY 1

	| region_name | count |
	|-------------|-------|
	| Africa      | 102   |
	| America     | 105   |
	| Asia        | 95    |
	| Australia   | 110   |
	| Europe      | 88    |

4. How many days on average are customers reallocated to a different node?

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

	| average_node_duration |
	|-----------------------|
	| 17                    |
  
5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

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

	| region_name | median_node_duration | pct80_node_duration | pct95_node_duration |
	|-------------|----------------------|---------------------|---------------------|
	| Australia   | 17                   | 25                  | 38                  |
	| America     | 17                   | 26                  | 35                  |
	| Africa      | 17                   | 27                  | 40                  |
	| Asia        | 17                   | 26                  | 40                  |
	| Europe      | 17                   | 27                  | 37                  |

## B. CUSTOMER TRANSACTIONS

1. What is the unique count and total amount for each transaction type?

		SELECT
		txn_type,
		COUNT(*),
		SUM(txn_amount) AS total_amount
		FROM customer_transactions
		GROUP BY 1
	| txn_type   | count | total_amount |
	|------------|-------|--------------|
	| purchase   | 1617  | 806537       |
	| withdrawal | 1580  | 793003       |
	| deposit    | 2671  | 1359168      |

2. What is the average total historical deposit counts and amounts for all customers?

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

	| avg_deposit_count | avg_deposit_amount |
	|-------------------|--------------------|
	| 5                 | 509                |

3. For each month - how many Data Bank customers make more than 1 deposit and at least either 1 purchase or 1 withdrawal in a single month?

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

	| month    | count |
	|----------|-------|
	| JANUARY  | 168   |
	| FEBRUARY | 181   |
	| MARCH    | 192   |
	| APRIL    | 70    |

4. What is the closing balance for each customer at the end of the month? Also show the change in balance each month in the same table output.

	SOLUTION 1 (one way of displaying):

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

	| customer_id | month      | closing_balance |
	|-------------|------------|-----------------|
	| 1           | 2020-01-31 | 312             |
	| 1           | 2020-03-31 | -640            |
	| 2           | 2020-01-31 | 549             |
	| 2           | 2020-03-31 | 610             |
	| 3           | 2020-01-31 | 144             |
	| 3           | 2020-02-29 | -821            |
	| 3           | 2020-03-31 | -1222           |
	| 3           | 2020-04-30 | -729            |
	| 4           | 2020-01-31 | 848             |
	| 4           | 2020-03-31 | 655             |
	| 5           | 2020-01-31 | 954             |
	| 5           | 2020-03-31 | -1923           |
	| 5           | 2020-04-30 | -2413           |
	| 6           | 2020-01-31 | 733             |
	| 6           | 2020-02-29 | -52             |
	| 6           | 2020-03-31 | 340             |
	| 7           | 2020-01-31 | 964             |
	| 7           | 2020-02-29 | 3173            |
	| 7           | 2020-03-31 | 2533            |
	| 7           | 2020-04-30 | 2623            |

	SOLUTION 2 (another way, by filling up the "missing" values of months when no change was recorded with the previous month's value)

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

	| customer_id | month      | balance_contribution | ending_balance |
	|-------------|------------|----------------------|----------------|
	| 1           | 2020-01-01 | 312                  | 312            |
	| 1           | 2020-02-01 | 0                    | 312            |
	| 1           | 2020-03-01 | -952                 | -640           |
	| 1           | 2020-04-01 | 0                    | -640           |
	| 2           | 2020-01-01 | 549                  | 549            |
	| 2           | 2020-02-01 | 0                    | 549            |
	| 2           | 2020-03-01 | 61                   | 610            |
	| 2           | 2020-04-01 | 0                    | 610            |
	| 3           | 2020-01-01 | 144                  | 144            |
	| 3           | 2020-02-01 | -965                 | -821           |
	| 3           | 2020-03-01 | -401                 | -1222          |
	| 3           | 2020-04-01 | 493                  | -729           |

5. Comparing the closing balance of a customer’s first month and the closing balance from their second month, what percentage of customers:
Have a negative first month balance?
Have a positive first month balance?
Increase their opening month’s positive closing balance by more than 5% in the following month?
Reduce their opening month’s positive closing balance by more than 5% in the following month?
Move from a positive balance in the first month to a negative balance in the second month?

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

	| positive_pc | negative_pc | increase_pc | decrease_pc | negative_balance_pc |
	|-------------|-------------|-------------|-------------|---------------------|
	| 68.00       | 31.00       | 18.00       | 79.00       | 33.00               |

## C. To test out a few different hypotheses - the Data Bank team wants to run an experiment where different groups of customers would be allocated data using 3 different options:

Option 1: data is allocated based off the amount of money at the end of the previous month
Option 2: data is allocated on the average amount of money kept in the account in the previous 30 days
Option 3: data is updated real-time
For this multi-part challenge question - you have been requested to generate the following data elements to help the Data Bank team estimate how much data will need to be provisioned for each option:

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

| customer_id | txn_date   | txn_type   | txn_sign | running_balance |
|-------------|------------|------------|----------|-----------------|
| 1           | 2020-01-02 | deposit    | 312      | 312             |
| 1           | 2020-03-05 | purchase   | -612     | -300            |
| 1           | 2020-03-17 | deposit    | 324      | 24              |
| 1           | 2020-03-19 | purchase   | -664     | -640            |
| 2           | 2020-01-03 | deposit    | 549      | 549             |
| 2           | 2020-03-24 | deposit    | 61       | 610             |
| 3           | 2020-01-27 | deposit    | 144      | 144             |
| 3           | 2020-02-22 | purchase   | -965     | -821            |
| 3           | 2020-03-05 | withdrawal | -213     | -1034           |
| 3           | 2020-03-19 | withdrawal | -188     | -1222           |
| 3           | 2020-04-12 | deposit    | 493      | -729            |
| 4           | 2020-01-07 | deposit    | 458      | 458             |
| 4           | 2020-01-21 | deposit    | 390      | 848             |
| 4           | 2020-03-25 | purchase   | -193     | 655             |
| 5           | 2020-01-15 | deposit    | 974      | 974             |
| 5           | 2020-01-25 | deposit    | 806      | 1780            |
| 5           | 2020-01-31 | withdrawal | -826     | 954             |
| 5           | 2020-03-02 | purchase   | -886     | 68              |
| 5           | 2020-03-19 | deposit    | 718      | 786             |
| 5           | 2020-03-26 | withdrawal | -786     | 0               |
			
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

| customer_id | month      | closing_balance |
|-------------|------------|-----------------|
| 1           | 2020-01-31 | 312             |
| 1           | 2020-03-31 | -640            |
| 2           | 2020-01-31 | 549             |
| 2           | 2020-03-31 | 610             |
| 3           | 2020-01-31 | 144             |
| 3           | 2020-02-29 | -821            |
| 3           | 2020-03-31 | -1222           |
| 3           | 2020-04-30 | -729            |
| 4           | 2020-01-31 | 848             |
| 4           | 2020-03-31 | 655             |
| 5           | 2020-01-31 | 954             |
| 5           | 2020-03-31 | -1923           |
| 5           | 2020-04-30 | -2413           |
| 6           | 2020-01-31 | 733             |
| 6           | 2020-02-29 | -52             |
| 6           | 2020-03-31 | 340             |
| 7           | 2020-01-31 | 964             |
| 7           | 2020-02-29 | 3173            |
| 7           | 2020-03-31 | 2533            |
| 7           | 2020-04-30 | 2623            |

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

| customer_id | min   | max  | round    |
|-------------|-------|------|----------|
| 1           | -640  | 312  | -151.00  |
| 2           | 549   | 610  | 579.50   |
| 3           | -1222 | 144  | -732.40  |
| 4           | 458   | 848  | 653.67   |
| 5           | -2413 | 1780 | -71.82   |
| 6           | -552  | 2197 | 635.00   |
| 7           | 887   | 3539 | 2268.69  |
| 8           | -1029 | 1363 | 173.70   |
| 9           | -91   | 2030 | 1021.70  |
| 10          | -5090 | 556  | -2161.50 |
| 11          | -2529 | 60   | -1752.88 |
| 12          | -647  | 295  | -14.50   |
| 13          | 379   | 1444 | 843.38   |
| 14          | 205   | 1577 | 898.00   |
| 15          | 379   | 1102 | 740.50   |
| 16          | -4284 | 421  | -1776.12 |
| 17          | -892  | 465  | -292.33  |
| 18          | -1216 | 757  | -539.75  |
| 19          | -301  | 258  | -41.43   |
| 20          | 465   | 1017 | 783.29   |



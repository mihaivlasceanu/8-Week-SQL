# Case Study #7 - Balanced Tree

![Balanced Tree logo](https://photos.google.com/album/AF1QipPs8My-_GQ-dLdnWDUwzropnS3JUTVTQiwxgiEP/photo/AF1QipPawJe6dSzyUKH-B-F4aKvl6G2VzkvlyBNLtKok)

## 📚  Table of Contents

-   [📋  Introduction](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#briefcase-business-case)
-   [📄 Available Data](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#bookmark_tabsexample-datasets)
-   [❓  Case Study Questions](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#triangular_flag_on_post-questions-and-solution)
-  [✔️  Solutions](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#triangular_flag_on_post-questions-and-solution)

# Introduction

Balanced Tree Clothing Company prides themselves on providing an optimised range of clothing and lifestyle wear for the modern adventurer!

Danny, the CEO of this trendy fashion company has asked you to assist the team’s merchandising teams analyse their sales performance and generate a basic financial report to share with the wider business.

# Available Data

For this case study there is a total of 4 datasets for this case study - however you will only need to utilise 2 main tables to solve all of the regular questions, and the additional 2 tables are used only for the bonus challenge question!

## Datasets

### Table 1: Product Details

`balanced_tree.product_details`  includes all information about the entire range that Balanced Clothing sells in their store.

| product_id | price | product_name                     | category_id | segment_id | style_id | category_name | segment_name | style_name          |
|------------|-------|----------------------------------|-------------|------------|----------|---------------|--------------|---------------------|
| c4a632     | 13    | Navy Oversized Jeans - Womens    | 1           | 3          | 7        | Womens        | Jeans        | Navy Oversized      |
| e83aa3     | 32    | Black Straight Jeans - Womens    | 1           | 3          | 8        | Womens        | Jeans        | Black Straight      |
| e31d39     | 10    | Cream Relaxed Jeans - Womens     | 1           | 3          | 9        | Womens        | Jeans        | Cream Relaxed       |
| d5e9a6     | 23    | Khaki Suit Jacket - Womens       | 1           | 4          | 10       | Womens        | Jacket       | Khaki Suit          |
| 72f5d4     | 19    | Indigo Rain Jacket - Womens      | 1           | 4          | 11       | Womens        | Jacket       | Indigo Rain         |
| 9ec847     | 54    | Grey Fashion Jacket - Womens     | 1           | 4          | 12       | Womens        | Jacket       | Grey Fashion        |
| 5d267b     | 40    | White Tee Shirt - Mens           | 2           | 5          | 13       | Mens          | Shirt        | White Tee           |
| c8d436     | 10    | Teal Button Up Shirt - Mens      | 2           | 5          | 14       | Mens          | Shirt        | Teal Button Up      |
| 2a2353     | 57    | Blue Polo Shirt - Mens           | 2           | 5          | 15       | Mens          | Shirt        | Blue Polo           |
| f084eb     | 36    | Navy Solid Socks - Mens          | 2           | 6          | 16       | Mens          | Socks        | Navy Solid          |
| b9a74d     | 17    | White Striped Socks - Mens       | 2           | 6          | 17       | Mens          | Socks        | White Striped       |
| 2feb6b     | 29    | Pink Fluro Polkadot Socks - Mens | 2           | 6          | 18       | Mens          | Socks        | Pink Fluro Polkadot |

### Table 2: Product Sales

`balanced_tree.sales`  contains product level information for all the transactions made for Balanced Tree including quantity, price, percentage discount, member status, a transaction ID and also the transaction timestamp.

| prod_id | qty | price | discount | member | txn_id | start_txn_time           |
|---------|-----|-------|----------|--------|--------|--------------------------|
| c4a632  | 4   | 13    | 17       | t      | 54f307 | 2021-02-13 01:59:43.296  |
| 5d267b  | 4   | 40    | 17       | t      | 54f307 | 2021-02-13 01:59:43.296  |
| b9a74d  | 4   | 17    | 17       | t      | 54f307 | 2021-02-13 01:59:43.296  |
| 2feb6b  | 2   | 29    | 17       | t      | 54f307 | 2021-02-13 01:59:43.296  |
| c4a632  | 5   | 13    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| e31d39  | 2   | 10    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| 72f5d4  | 3   | 19    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| 2a2353  | 3   | 57    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| f084eb  | 3   | 36    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| c4a632  | 1   | 13    | 21       | f      | ef648d | 2021-01-27 02:18:17.1648 |

### Tables 3 & 4: Product Hierarchy & Product Price

Thes tables are used only for the bonus question where we will use them to recreate the  `balanced_tree.product_details`  table.

**`balanced_tree.product_hierarchy`**

| id | parent_id | level_text          | level_name |
|----|-----------|---------------------|------------|
| 1  |           | Womens              | Category   |
| 2  |           | Mens                | Category   |
| 3  | 1         | Jeans               | Segment    |
| 4  | 1         | Jacket              | Segment    |
| 5  | 2         | Shirt               | Segment    |
| 6  | 2         | Socks               | Segment    |
| 7  | 3         | Navy Oversized      | Style      |
| 8  | 3         | Black Straight      | Style      |
| 9  | 3         | Cream Relaxed       | Style      |
| 10 | 4         | Khaki Suit          | Style      |
| 11 | 4         | Indigo Rain         | Style      |
| 12 | 4         | Grey Fashion        | Style      |
| 13 | 5         | White Tee           | Style      |
| 14 | 5         | Teal Button Up      | Style      |
| 15 | 5         | Blue Polo           | Style      |
| 16 | 6         | Navy Solid          | Style      |
| 17 | 6         | White Striped       | Style      |
| 18 | 6         | Pink Fluro Polkadot | Style      |

**`balanced_tree.product_prices`**

| id | product_id | price |
|----|------------|-------|
| 7  | c4a632     | 13    |
| 8  | e83aa3     | 32    |
| 9  | e31d39     | 10    |
| 10 | d5e9a6     | 23    |
| 11 | 72f5d4     | 19    |
| 12 | 9ec847     | 54    |
| 13 | 5d267b     | 40    |
| 14 | c8d436     | 10    |
| 15 | 2a2353     | 57    |
| 16 | f084eb     | 36    |
| 17 | b9a74d     | 17    |
| 18 | 2feb6b     | 29    |

# Case Study Questions

The following questions can be considered key business questions and metrics that the Balanced Tree team requires for their monthly reports.

Each question can be answered using a single query - but as you are writing the SQL to solve each individual problem, keep in mind how you would generate all of these metrics in a single SQL script which the Balanced Tree team can run each month.

## A. High Level Sales Analysis

1.  What was the total quantity sold for all products?
2.  What is the total generated revenue for all products before discounts?
3.  What was the total discount amount for all products?

## B. Transaction Analysis

1.  How many unique transactions were there?
2.  What is the average unique products purchased in each transaction?
3.  What are the 25th, 50th and 75th percentile values for the revenue per transaction?
4.  What is the average discount value per transaction?
5.  What is the percentage split of all transactions for members vs non-members?
6.  What is the average revenue for member transactions and non-member transactions?

## C. Product Analysis

1.  What are the top 3 products by total revenue before discount?
2.  What is the total quantity, revenue and discount for each segment?
3.  What is the top selling product for each segment?
4.  What is the total quantity, revenue and discount for each category?
5.  What is the top selling product for each category?
6.  What is the percentage split of revenue by product for each segment?
7.  What is the percentage split of revenue by segment for each category?
8.  What is the percentage split of total revenue by category?
9.  What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
10.  What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

## D. Bonus Challenge

Use a single SQL query to transform the  `product_hierarchy`  and  `product_prices`  datasets to the  `product_details`  table.

Hint: you may want to consider using a recursive CTE to solve this problem!

# Solutions

 ## A. HIGH LEVEL ANALYSIS

1. What was the total quantity sold for all products?

		SELECT
		product_id,
		product_name,
		SUM(qty) quantity_sold
		FROM product_details pd
		JOIN sales s ON pd.product_id=s.prod_id
		GROUP BY 1,2
		ORDER BY 3 DESC

	| product_id | product_name                     | quantity_sold |
	|------------|----------------------------------|---------------|
	| 9ec847     | Grey Fashion Jacket - Womens     | 3876          |
	| c4a632     | Navy Oversized Jeans - Womens    | 3856          |
	| 2a2353     | Blue Polo Shirt - Mens           | 3819          |
	| 5d267b     | White Tee Shirt - Mens           | 3800          |
	| f084eb     | Navy Solid Socks - Mens          | 3792          |
	| e83aa3     | Black Straight Jeans - Womens    | 3786          |
	| 2feb6b     | Pink Fluro Polkadot Socks - Mens | 3770          |
	| 72f5d4     | Indigo Rain Jacket - Womens      | 3757          |
	| d5e9a6     | Khaki Suit Jacket - Womens       | 3752          |
	| e31d39     | Cream Relaxed Jeans - Womens     | 3707          |
	| b9a74d     | White Striped Socks - Mens       | 3655          |
	| c8d436     | Teal Button Up Shirt - Mens      | 3646          |

2. What is the total generated revenue for all products before discounts?

		SELECT
		product_id,
		product_name,
		SUM(qty*pd.price) AS revenue_before_discount,
		SUM(SUM(qty*pd.price)) OVER () AS total_revenue
		FROM product_details pd
		JOIN sales s ON pd.product_id=s.prod_id
		GROUP BY 1,2
		ORDER BY 3 DESC

	| product_id | product_name                     | revenue_before_discount | total_revenue |
	|------------|----------------------------------|-------------------------|---------------|
	| 2a2353     | Blue Polo Shirt - Mens           | 217683                  | 1289453       |
	| 9ec847     | Grey Fashion Jacket - Womens     | 209304                  | 1289453       |
	| 5d267b     | White Tee Shirt - Mens           | 152000                  | 1289453       |
	| f084eb     | Navy Solid Socks - Mens          | 136512                  | 1289453       |
	| e83aa3     | Black Straight Jeans - Womens    | 121152                  | 1289453       |
	| 2feb6b     | Pink Fluro Polkadot Socks - Mens | 109330                  | 1289453       |
	| d5e9a6     | Khaki Suit Jacket - Womens       | 86296                   | 1289453       |
	| 72f5d4     | Indigo Rain Jacket - Womens      | 71383                   | 1289453       |
	| b9a74d     | White Striped Socks - Mens       | 62135                   | 1289453       |
	| c4a632     | Navy Oversized Jeans - Womens    | 50128                   | 1289453       |
	| e31d39     | Cream Relaxed Jeans - Womens     | 37070                   | 1289453       |
	| c8d436     | Teal Button Up Shirt - Mens      | 36460                   | 1289453       |

3. What was the total discount amount for all products?

		SELECT
		product_id,
		product_name,
		SUM(pd.price*qty*s.discount)/100 AS product_discount,
		ROUND((SUM(SUM(pd.price*qty*s.discount)) OVER ()) / 100, 2) AS total_discount
		FROM product_details pd
		JOIN sales s ON pd.product_id=s.prod_id
		GROUP BY 1,2
		ORDER BY 3 DESC

	| product_id | product_name                     | product_discount | total_discount |
	|------------|----------------------------------|------------------|----------------|
	| 2a2353     | Blue Polo Shirt - Mens           | 26819            | 156229.14      |
	| 9ec847     | Grey Fashion Jacket - Womens     | 25391            | 156229.14      |
	| 5d267b     | White Tee Shirt - Mens           | 18377            | 156229.14      |
	| f084eb     | Navy Solid Socks - Mens          | 16650            | 156229.14      |
	| e83aa3     | Black Straight Jeans - Womens    | 14744            | 156229.14      |
	| 2feb6b     | Pink Fluro Polkadot Socks - Mens | 12952            | 156229.14      |
	| d5e9a6     | Khaki Suit Jacket - Womens       | 10243            | 156229.14      |
	| 72f5d4     | Indigo Rain Jacket - Womens      | 8642             | 156229.14      |
	| b9a74d     | White Striped Socks - Mens       | 7410             | 156229.14      |
	| c4a632     | Navy Oversized Jeans - Womens    | 6135             | 156229.14      |
	| e31d39     | Cream Relaxed Jeans - Womens     | 4463             | 156229.14      |
	| c8d436     | Teal Button Up Shirt - Mens      | 4397             | 156229.14      |

## B. TRANSACTION ANALYSIS

1. How many unique transactions were there?

		SELECT
		COUNT(DISTINCT txn_id)
		FROM sales

	| count |
	|-------|
	| 2500  |

2. What is the average unique products purchased in each transaction?

	SOLUTION 1:

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


	SOLUTION 2:

		SELECT
		COUNT(prod_id)/COUNT(DISTINCT txn_id)
		FROM sales

	| ?column? |
	|----------|
	| 6        |

3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?

	Question unclear, solution A with discount and solution B without discount

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
		
	| pct_25 | pct_50 | pct_75 |
	|--------|--------|--------|
	| 333    | 450    | 582.25 |


		
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

	| pct_25 | pct_50 | pct_75 |
	|--------|--------|--------|
	| 375.75 | 509.5  | 647    |
		
4. What is the average discount value per transaction?

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

	| average_discount |
	|------------------|
	| 62.49            |

5. What is the percentage split of all transactions for members vs non-members?

	SOLUTION 1 ( with subquery):

		SELECT
		member,
		ROUND(100*1.0*COUNT(DISTINCT txn_id)/(SELECT 
							    			  COUNT(DISTINCT txn_id)
							    			  FROM sales), 2) AS transactions_pct
		FROM sales
		GROUP BY 1

	| member | transactions_pct |
	|--------|------------------|
	| False  | 39.80            |
	| True   | 60.20            |

	SOLUTION 2 ( with CTE and count):

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

	| member | transactions | round |
	|--------|--------------|-------|
	| False  | 995          | 40    |
	| True   | 1505         | 60    |

6. What is the average revenue for member transactions and non-member transactions?

	Again, solution A with discount, solution B without it:

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

	| member | avg                  |
	|--------|----------------------|
	| False  | 460.3216080402010050 |
	| True   | 462.5235880398671096 |


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

	| member | round  |
	|--------|--------|
	| False  | 515.04 |
	| True   | 516.27 |

## C. PRODUCT ANALYSIS

1. What are the top 3 products by total revenue before discount?

		SELECT
		prod_id,
		product_name,
		SUM(qty*s.price) AS revenue_from_product
		FROM product_details pd
		JOIN sales s ON pd.product_id=s.prod_id
		GROUP BY 1,2
		ORDER BY 3 DESC

	| prod_id | product_name                     | revenue_from_product |
	|---------|----------------------------------|----------------------|
	| 2a2353  | Blue Polo Shirt - Mens           | 217683               |
	| 9ec847  | Grey Fashion Jacket - Womens     | 209304               |
	| 5d267b  | White Tee Shirt - Mens           | 152000               |
	| f084eb  | Navy Solid Socks - Mens          | 136512               |
	| e83aa3  | Black Straight Jeans - Womens    | 121152               |
	| 2feb6b  | Pink Fluro Polkadot Socks - Mens | 109330               |
	| d5e9a6  | Khaki Suit Jacket - Womens       | 86296                |
	| 72f5d4  | Indigo Rain Jacket - Womens      | 71383                |
	| b9a74d  | White Striped Socks - Mens       | 62135                |
	| c4a632  | Navy Oversized Jeans - Womens    | 50128                |
	| e31d39  | Cream Relaxed Jeans - Womens     | 37070                |
	| c8d436  | Teal Button Up Shirt - Mens      | 36460                |

2. What is the total quantity, revenue and discount for each segment?

		SELECT
		segment_name,
		SUM(qty) AS total_quantity_per_segment,
		SUM(qty*s.price) AS total_revenue_per_segment,
		ROUND(SUM(1.0*qty*s.price*discount)/100,2) AS total_discount_per_segment
		FROM product_details pd
		JOIN sales s ON pd.product_id=s.prod_id
		GROUP BY segment_name
		ORDER BY segment_name

	| segment_name | total_quantity_per_segment | total_revenue_per_segment | total_discount_per_segment |
	|--------------|----------------------------|---------------------------|----------------------------|
	| Jacket       | 11385                      | 366983                    | 44277.46                   |
	| Jeans        | 11349                      | 208350                    | 25343.97                   |
	| Shirt        | 11265                      | 406143                    | 49594.27                   |
	| Socks        | 11217                      | 307977                    | 37013.44                   |

3. What is the top selling product for each segment?

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

	| segment_name | product_id | product_name                  | products_sold | rank |
	|--------------|------------|-------------------------------|---------------|------|
	| Jacket       | 9ec847     | Grey Fashion Jacket - Womens  | 3876          | 1    |
	| Jeans        | c4a632     | Navy Oversized Jeans - Womens | 3856          | 1    |
	| Shirt        | 2a2353     | Blue Polo Shirt - Mens        | 3819          | 1    |
	| Socks        | f084eb     | Navy Solid Socks - Mens       | 3792          | 1    |

4. What is the total quantity, revenue and discount for each category?

		SELECT
		category_name,
		SUM(qty) AS total_quantity_per_segment,
		SUM(qty*s.price) AS total_revenue_per_segment,
		ROUND(SUM(1.0*qty*s.price*discount)/100,2) AS total_discount_per_segment
		FROM product_details pd
		JOIN sales s ON pd.product_id=s.prod_id
		GROUP BY 1
		ORDER BY 1

	| category_name | total_quantity_per_segment | total_revenue_per_segment | total_discount_per_segment |
	|---------------|----------------------------|---------------------------|----------------------------|
	| Mens          | 22482                      | 714120                    | 86607.71                   |
	| Womens        | 22734                      | 575333                    | 69621.43                   |

5. What is the top selling product for each category?

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

	| category_name | product_name                 | products_sold | rank |
	|---------------|------------------------------|---------------|------|
	| Womens        | Grey Fashion Jacket - Womens | 3876          | 1    |
	| Mens          | Blue Polo Shirt - Mens       | 3819          | 1    |

6. What is the percentage split of revenue by product for each segment?

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

	| segment_name | product_name                     | revenue | revenue_per_segment | pct_of_segment |
	|--------------|----------------------------------|---------|---------------------|----------------|
	| Jacket       | Indigo Rain Jacket - Womens      | 71383   | 366983              | 19.45          |
	| Jacket       | Khaki Suit Jacket - Womens       | 86296   | 366983              | 23.51          |
	| Jacket       | Grey Fashion Jacket - Womens     | 209304  | 366983              | 57.03          |
	| Jeans        | Cream Relaxed Jeans - Womens     | 37070   | 208350              | 17.79          |
	| Jeans        | Navy Oversized Jeans - Womens    | 50128   | 208350              | 24.06          |
	| Jeans        | Black Straight Jeans - Womens    | 121152  | 208350              | 58.15          |
	| Shirt        | Teal Button Up Shirt - Mens      | 36460   | 406143              | 8.98           |
	| Shirt        | White Tee Shirt - Mens           | 152000  | 406143              | 37.43          |
	| Shirt        | Blue Polo Shirt - Mens           | 217683  | 406143              | 53.60          |
	| Socks        | White Striped Socks - Mens       | 62135   | 307977              | 20.18          |
	| Socks        | Pink Fluro Polkadot Socks - Mens | 109330  | 307977              | 35.50          |
	| Socks        | Navy Solid Socks - Mens          | 136512  | 307977              | 44.33          |

7. What is the percentage split of revenue by segment for each category?

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

	| category_name | segment_name | revenue | revenue_per_category | pct_of_category |
	|---------------|--------------|---------|----------------------|-----------------|
	| Mens          | Shirt        | 406143  | 714120               | 56.87           |
	| Mens          | Socks        | 307977  | 714120               | 43.13           |
	| Womens        | Jacket       | 366983  | 575333               | 63.79           |
	| Womens        | Jeans        | 208350  | 575333               | 36.21           |

8. What is the percentage split of total revenue by category?

	SOLUTION 1 (with subquery):

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
	
	| category_name | revenue | pct_of_total |
	|---------------|---------|--------------|
	| Mens          | 714120  | 55.38        |
	| Womens        | 575333  | 44.62        |

	SOLUTION 2 (with CTE):

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

	| category_id | category_name | category_revenue | category_revenue_percentage |
	|-------------|---------------|------------------|-----------------------------|
	| 1           | Womens        | 575333           | 44.62                       |
	| 2           | Mens          | 714120           | 55.38                       |

9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)

	SOLUTION 1:

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

	SOLUTION 2:

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

	| product_id | product_name                     | penetration |
	|------------|----------------------------------|-------------|
	| f084eb     | Navy Solid Socks - Mens          | 51.24       |
	| 9ec847     | Grey Fashion Jacket - Womens     | 51.00       |
	| c4a632     | Navy Oversized Jeans - Womens    | 50.96       |
	| 5d267b     | White Tee Shirt - Mens           | 50.72       |
	| 2a2353     | Blue Polo Shirt - Mens           | 50.72       |
	| 2feb6b     | Pink Fluro Polkadot Socks - Mens | 50.32       |
	| 72f5d4     | Indigo Rain Jacket - Womens      | 50.00       |
	| d5e9a6     | Khaki Suit Jacket - Womens       | 49.88       |
	| e83aa3     | Black Straight Jeans - Womens    | 49.84       |
	| b9a74d     | White Striped Socks - Mens       | 49.72       |
	| e31d39     | Cream Relaxed Jeans - Womens     | 49.72       |
	| c8d436     | Teal Button Up Shirt - Mens      | 49.68       |

10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

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

	|  product_name                     | product_name-2                | product_name-3                | count |
	|----------------------------------|-------------------------------|-------------------------------|-------|
	|  White Tee Shirt - Mens           | Grey Fashion Jacket - Womens  | Teal Button Up Shirt - Mens   | 352   |
	|  Indigo Rain Jacket - Womens      | Black Straight Jeans - Womens | Navy Solid Socks - Mens       | 349   |
	|  Blue Polo Shirt - Mens           | Grey Fashion Jacket - Womens  | Teal Button Up Shirt - Mens   | 347   |
	|  Blue Polo Shirt - Mens           | Grey Fashion Jacket - Womens  | White Striped Socks - Mens    | 347   |
	|  Pink Fluro Polkadot Socks - Mens | Grey Fashion Jacket - Womens  | Black Straight Jeans - Womens | 347   |

	SOLUTION 2 (with Super bonus - what are the quantity, revenue, discount and net revenue from the top 3 products in the transactions where all 3 were purchased?)

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

	|  product_id | product_name                 | combo_transaction_count | quantity | revenue | discount | net_revenue |
	|------------|------------------------------|-------------------------|----------|---------|----------|-------------|
	|  5d267b     | White Tee Shirt - Mens       | 352                     | 1007     | 40280   | 5049.20  | 35230.80    |
	|  9ec847     | Grey Fashion Jacket - Womens | 352                     | 1062     | 57348   | 6997.86  | 50350.14    |
	|  c8d436     | Teal Button Up Shirt - Mens  | 352                     | 1054     | 10540   | 1325.30  | 9214.70     |

## D. REPORTING CHALLENGE

Write a single SQL script that combines all of the previous questions into a scheduled report that the Balanced Tree team can run at the beginning of each month to calculate the previous month’s values.

Imagine that the Chief Financial Officer (which is also Danny) has asked for all of these questions at the end of every month.

He first wants you to generate the data for January only - but then he also wants you to demonstrate that you can easily run the samne analysis for February without many changes (if at all).

Feel free to split up your final outputs into as many tables as you need - but be sure to explicitly reference which table outputs relate to which question for full marks :)

### ANSWER:  
This can be done by making a parameter TEMP TABLE which we use to join with all previously obtained tables

	SELECT
	min(start_txn_time),
	max(start_txn_time)
	FROM product_details pd
	JOIN sales s ON pd.product_id=s.prod_id


Creating a parameters table that we can use to extract only the data from the month we are interested in:

	DROP TABLE IF EXISTS _params;
	CREATE TEMP TABLE _params AS
		SELECT
		'%january%' AS target_month;

	UPDATE _params
	SET target_month = '%february%';  -- or any other month we want

To obtain the monthly information the stakeholders require of us, we cross join every table onto the _params temp table we have just created and design each of the queries so as to output the results into new reporting tables. As an example, for our previous High Level Analysis:

	WITH monthly_metrics AS(
	SELECT
		pd.product_id,
		pd.product_name,
		qty,
		s.price,
		discount,
		member,
		txn_id,
		TO_CHAR(start_txn_time,'month') AS month,
		category_id,
		category_name,
		segment_id,
		segment_name,
		style_id,
		style_name
	FROM product_details pd
	JOIN sales s ON pd.product_id=s.prod_id, _params
	WHERE 1=1 
	AND 
	TO_CHAR(start_txn_time,'month') ILIKE target_month
	)

	SELECT
	month,
	product_id,
	product_name,
	SUM(qty) AS quantity_sold,
	SUM(qty*price) AS revenue_before_discount,
	SUM(price*qty*discount)/100 AS total_discount
	FROM monthly_metrics
	GROUP BY 1,2,3
	ORDER BY 4 DESC

| month    | product_id | product_name                     | quantity_sold | revenue_before_discount | total_discount |
|----------|------------|----------------------------------|---------------|-------------------------|----------------|
| february | d5e9a6     | Khaki Suit Jacket - Womens       | 1296          | 29808                   | 3555           |
| february | 2a2353     | Blue Polo Shirt - Mens           | 1281          | 73017                   | 8968           |
| february | 9ec847     | Grey Fashion Jacket - Womens     | 1254          | 67716                   | 8515           |
| february | b9a74d     | White Striped Socks - Mens       | 1252          | 21284                   | 2520           |
| february | 2feb6b     | Pink Fluro Polkadot Socks - Mens | 1246          | 36134                   | 4300           |
| february | 72f5d4     | Indigo Rain Jacket - Womens      | 1245          | 23655                   | 2930           |
| february | c4a632     | Navy Oversized Jeans - Womens    | 1224          | 15912                   | 1928           |
| february | e83aa3     | Black Straight Jeans - Womens    | 1224          | 39168                   | 4924           |
| february | e31d39     | Cream Relaxed Jeans - Womens     | 1205          | 12050                   | 1454           |
| february | c8d436     | Teal Button Up Shirt - Mens      | 1205          | 12050                   | 1460           |
| february | 5d267b     | White Tee Shirt - Mens           | 1198          | 47920                   | 5846           |
| february | f084eb     | Navy Solid Socks - Mens          | 1190          | 42840                   | 5256           |

## E. BONUS CHALLENGE

Use a single SQL query to transform the product_hierarchy and product_prices datasets to the product_details table.

Hint: you may want to consider using a recursive CTE to solve this problem!

SOLUTION 1  (non-recursive CTE)

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

| product_id | price | product_name               | category_id | segment_id | style_id | category_name | segment_name | style_name          |
|------------|-------|----------------------------|-------------|------------|----------|---------------|--------------|---------------------|
| c4a632     | 13    | Navy Oversized - Womens    | 1           | 3          | 7        | Womens        | Jeans        | Navy Oversized      |
| e83aa3     | 32    | Black Straight - Womens    | 1           | 3          | 8        | Womens        | Jeans        | Black Straight      |
| e31d39     | 10    | Cream Relaxed - Womens     | 1           | 3          | 9        | Womens        | Jeans        | Cream Relaxed       |
| d5e9a6     | 23    | Khaki Suit - Womens        | 1           | 4          | 10       | Womens        | Jacket       | Khaki Suit          |
| 72f5d4     | 19    | Indigo Rain - Womens       | 1           | 4          | 11       | Womens        | Jacket       | Indigo Rain         |
| 9ec847     | 54    | Grey Fashion - Womens      | 1           | 4          | 12       | Womens        | Jacket       | Grey Fashion        |
| 5d267b     | 40    | White Tee - Mens           | 2           | 5          | 13       | Mens          | Shirt        | White Tee           |
| c8d436     | 10    | Teal Button Up - Mens      | 2           | 5          | 14       | Mens          | Shirt        | Teal Button Up      |
| 2a2353     | 57    | Blue Polo - Mens           | 2           | 5          | 15       | Mens          | Shirt        | Blue Polo           |
| f084eb     | 36    | Navy Solid - Mens          | 2           | 6          | 16       | Mens          | Socks        | Navy Solid          |
| b9a74d     | 17    | White Striped - Mens       | 2           | 6          | 17       | Mens          | Socks        | White Striped       |
| 2feb6b     | 29    | Pink Fluro Polkadot - Mens | 2           | 6          | 18       | Mens          | Socks        | Pink Fluro Polkadot |

SOLUTION 2  (recursive CTE):

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

| product_id | price | product_name                     | category_id | segment_id | style_id | category_name | segment_name | style_name          |
|------------|-------|----------------------------------|-------------|------------|----------|---------------|--------------|---------------------|
| c4a632     | 13    | Navy Oversized Jeans - Womens    | 1           | 3          | 7        | Womens        | Jeans        | Navy Oversized      |
| e83aa3     | 32    | Black Straight Jeans - Womens    | 1           | 3          | 8        | Womens        | Jeans        | Black Straight      |
| e31d39     | 10    | Cream Relaxed Jeans - Womens     | 1           | 3          | 9        | Womens        | Jeans        | Cream Relaxed       |
| d5e9a6     | 23    | Khaki Suit Jacket - Womens       | 1           | 4          | 10       | Womens        | Jacket       | Khaki Suit          |
| 72f5d4     | 19    | Indigo Rain Jacket - Womens      | 1           | 4          | 11       | Womens        | Jacket       | Indigo Rain         |
| 9ec847     | 54    | Grey Fashion Jacket - Womens     | 1           | 4          | 12       | Womens        | Jacket       | Grey Fashion        |
| 5d267b     | 40    | White Tee Shirt - Mens           | 2           | 5          | 13       | Mens          | Shirt        | White Tee           |
| c8d436     | 10    | Teal Button Up Shirt - Mens      | 2           | 5          | 14       | Mens          | Shirt        | Teal Button Up      |
| 2a2353     | 57    | Blue Polo Shirt - Mens           | 2           | 5          | 15       | Mens          | Shirt        | Blue Polo           |
| f084eb     | 36    | Navy Solid Socks - Mens          | 2           | 6          | 16       | Mens          | Socks        | Navy Solid          |
| b9a74d     | 17    | White Striped Socks - Mens       | 2           | 6          | 17       | Mens          | Socks        | White Striped       |
| 2feb6b     | 29    | Pink Fluro Polkadot Socks - Mens | 2           | 6          | 18       | Mens          | Socks        | Pink Fluro Polkadot |




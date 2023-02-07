# Case Study #6 - Clique Bait

![Clique Bait logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%206.png)

## 📚  Table of Contents

-   [📋  Introduction](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%236%20-%20Clique%20Bait#introduction)
-   [📄 Available Data](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%236%20-%20Clique%20Bait#available-data)
-   [❓  Case Study Questions](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%236%20-%20Clique%20Bait#case-study-questions)
-  [✔️  Solutions](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%236%20-%20Clique%20Bait#solutions)

# Introduction

Clique Bait is not like your regular online seafood store - the founder and CEO Danny, was also a part of a digital data analytics team and wanted to expand his knowledge into the seafood industry!

In this case study - you are required to support Danny’s vision and analyse his dataset and come up with creative solutions to calculate funnel fallout rates for the Clique Bait online store.

# Available Data

For this case study there is a total of 5 datasets which you will need to combine to solve all of the questions.

## Datasets

### Table 1: Users

Customers who visit the Clique Bait website are tagged via their  `cookie_id`.

| user_id | cookie_id | start_date          |
|---------|-----------|---------------------|
| 397     | 3759ff    | 2020-03-30 00:00:00 |
| 215     | 863329    | 2020-01-26 00:00:00 |
| 191     | eefca9    | 2020-03-15 00:00:00 |
| 89      | 764796    | 2020-01-07 00:00:00 |
| 127     | 17ccc5    | 2020-01-22 00:00:00 |
| 81      | b0b666    | 2020-03-01 00:00:00 |
| 260     | a4f236    | 2020-01-08 00:00:00 |
| 203     | d1182f    | 2020-04-18 00:00:00 |
| 23      | 12dbc8    | 2020-01-18 00:00:00 |
| 375     | f61d69    | 2020-01-03 00:00:00 |

### Table 2: Events

Customer visits are logged in this  `events`  table at a  `cookie_id`  level and the  `event_type`  and  `page_id`  values can be used to join onto relevant satellite tables to obtain further information about each event.

The sequence_number is used to order the events within each visit.

| visit_id | cookie_id | page_id | event_type | sequence_number | event_time                 |
|----------|-----------|---------|------------|-----------------|----------------------------|
| 719fd3   | 3d83d3    | 5       | 1          | 4               | 2020-03-02 00:29:09.975502 |
| fb1eb1   | c5ff25    | 5       | 2          | 8               | 2020-01-22 07:59:16.761931 |
| 23fe81   | 1e8c2d    | 10      | 1          | 9               | 2020-03-21 13:14:11.745667 |
| ad91aa   | 648115    | 6       | 1          | 3               | 2020-04-27 16:28:09.824606 |
| 5576d7   | ac418c    | 6       | 1          | 4               | 2020-01-18 04:55:10.149236 |
| 48308b   | c686c1    | 8       | 1          | 5               | 2020-01-29 06:10:38.702163 |
| 46b17d   | 78f9b3    | 7       | 1          | 12              | 2020-02-16 09:45:31.926407 |
| 9fd196   | ccf057    | 4       | 1          | 5               | 2020-02-14 08:29:12.922164 |
| edf853   | f85454    | 1       | 1          | 1               | 2020-02-22 12:59:07.652207 |
| 3c6716   | 02e74f    | 3       | 2          | 5               | 2020-01-31 17:56:20.777383 |

### Table 3: Event Identifier

The  `event_identifier`  table shows the types of events which are captured by Clique Bait’s digital data systems.

| event_type | event_name    |
|------------|---------------|
| 1          | Page View     |
| 2          | Add to Cart   |
| 3          | Purchase      |
| 4          | Ad Impression |
| 5          | Ad Click      |

### Table 4: Campaign Identifier

This table shows information for the 3 campaigns that Clique Bait has ran on their website so far in 2020.

| campaign_id | products | campaign_name                     | start_date          | end_date            |
|-------------|----------|-----------------------------------|---------------------|---------------------|
| 1           | 1-3      | BOGOF - Fishing For Compliments   | 2020-01-01 00:00:00 | 2020-01-14 00:00:00 |
| 2           | 4-5      | 25% Off - Living The Lux Life     | 2020-01-15 00:00:00 | 2020-01-28 00:00:00 |
| 3           | 6-8      | Half Off - Treat Your Shellf(ish) | 2020-02-01 00:00:00 | 2020-03-31 00:00:00 |

### Table 5: Page Hierarchy

This table lists all of the pages on the Clique Bait website which are tagged and have data passing through from user interaction events.

| page_id | page_name      | product_category | product_id |
|---------|----------------|------------------|------------|
| 1       | Home Page      | null             | null       |
| 2       | All Products   | null             | null       |
| 3       | Salmon         | Fish             | 1          |
| 4       | Kingfish       | Fish             | 2          |
| 5       | Tuna           | Fish             | 3          |
| 6       | Russian Caviar | Luxury           | 4          |
| 7       | Black Truffle  | Luxury           | 5          |
| 8       | Abalone        | Shellfish        | 6          |
| 9       | Lobster        | Shellfish        | 7          |
| 10      | Crab           | Shellfish        | 8          |
| 11      | Oyster         | Shellfish        | 9          |
| 12      | Checkout       | null             | null       |
| 13      | Confirmation   | null             | null       |

# Case Study Questions

## A. Enterprise Relationship Diagram

Use the following DDL schema details to create an ERD for all the Clique Bait datasets.

```
CREATE TABLE clique_bait.event_identifier (
  "event_type" INTEGER,
  "event_name" VARCHAR(13)
);

CREATE TABLE clique_bait.campaign_identifier (
  "campaign_id" INTEGER,
  "products" VARCHAR(3),
  "campaign_name" VARCHAR(33),
  "start_date" TIMESTAMP,
  "end_date" TIMESTAMP
);

CREATE TABLE clique_bait.page_hierarchy (
  "page_id" INTEGER,
  "page_name" VARCHAR(14),
  "product_category" VARCHAR(9),
  "product_id" INTEGER
);

CREATE TABLE clique_bait.users (
  "user_id" INTEGER,
  "cookie_id" VARCHAR(6),
  "start_date" TIMESTAMP
);

CREATE TABLE clique_bait.events (
  "visit_id" VARCHAR(6),
  "cookie_id" VARCHAR(6),
  "page_id" INTEGER,
  "event_type" INTEGER,
  "sequence_number" INTEGER,
  "event_time" TIMESTAMP
);
```
## B. Digital Analysis

Using the available datasets - answer the following questions using a single query for each one:

1.  How many users are there?
2.  How many cookies does each user have on average?
3.  What is the unique number of visits by all users per month?
4.  What is the number of events for each event type?
5.  What is the percentage of visits which have a purchase event?
6.  What is the percentage of visits which view the checkout page but do not have a purchase event?
7.  What are the top 3 pages by number of views?
8.  What is the number of views and cart adds for each product category?
9.  What are the top 3 products by purchases?

## C. Product Funnel Analysis

Using a single SQL query - create a new output table which has the following details:

-   How many times was each product viewed?
-   How many times was each product added to cart?
-   How many times was each product added to a cart but not purchased (abandoned)?
-   How many times was each product purchased?

Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

Use your 2 new output tables - answer the following questions:

1.  Which product had the most views, cart adds and purchases?
2.  Which product was most likely to be abandoned?
3.  Which product had the highest view to purchase percentage?
4.  What is the average conversion rate from view to cart add?
5.  What is the average conversion rate from cart add to purchase?

## D. Campaigns Analysis

Generate a table that has 1 single row for every unique  `visit_id`  record and has the following columns:

-   `user_id`
-   `visit_id`
-   `visit_start_time`: the earliest  `event_time`  for each visit
-   `page_views`: count of page views for each visit
-   `cart_adds`: count of product cart add events for each visit
-   `purchase`: 1/0 flag if a purchase event exists for each visit
-   `campaign_name`: map the visit to a campaign if the  `visit_start_time`  falls between the  `start_date`  and  `end_date`
-   `impression`: count of ad impressions for each visit
-   `click`: count of ad clicks for each visit
-   **(Optional column)**  `cart_products`: a comma separated text value with products added to the cart sorted by the order they were added to the cart (hint: use the  `sequence_number`)

Use the subsequent dataset to generate at least 5 insights for the Clique Bait team - bonus: prepare a single A4 infographic that the team can use for their management reporting sessions, be sure to emphasise the most important points from your findings.

Some ideas you might want to investigate further include:

-   Identifying users who have received impressions during each campaign period and comparing each metric with other users who did not have an impression event
-   Does clicking on an impression lead to higher purchase rates?
-   What is the uplift in purchase rate when comparing users who click on a campaign impression versus users who do not receive an impression? What if we compare them with users who just an impression but do not click?
-   What metrics can you use to quantify the success or failure of each campaign compared to eachother?


# Solutions

## A. Enterprise Relationship Diagram
![Clique Bait ERD](https://photos.google.com/album/AF1QipPs8My-_GQ-dLdnWDUwzropnS3JUTVTQiwxgiEP/photo/AF1QipOM_32fy5yZHWbGqAyP3tR1hnyCsxvEuDqiAhUZ)

## B. DIGITAL ANALYSIS
Using the available datasets - answer the following questions using a single query for each one:

1. How many users are there?

		SELECT
		COUNT(DISTINCT user_id)
		FROM users
	 
	| count |
	|-------|
	| 500   |
	 
2. How many cookies does each user have on average?

		WITH cookie_count_cte AS (
		SELECT
			user_id,
			COUNT(cookie_id) AS cookie_count
		FROM users
		GROUP BY 1
		ORDER BY 1
		)

		SELECT 
		ROUND(AVG(cookie_count),2) AS average_cookie_count
		FROM cookie_count_cte

	| average_cookie_count |
	|----------------------|
	| 3.56                 |

3. What is the unique number of visits by all users per month?

		SELECT
		DATE_TRUNC('month',event_time)::date AS month,
		COUNT(DISTINCT visit_id)
		FROM events
		GROUP BY 1
		ORDER BY 1

	| average_cookie_count |
	|----------------------|
	| 3.56                 |

4. What is the number of events for each event type?

		SELECT
		event_type,
		COUNT(event_time)
		FROM events
		GROUP BY 1
		ORDER BY 1

	| event_type | count |
	|------------|-------|
	| 1          | 20928 |
	| 2          | 8451  |
	| 3          | 1777  |
	| 4          | 876   |
	| 5          | 702   |

	If we want to include both the event type and name columns from the event_identifier table:

		SELECT
		event_identifier.event_type,
		event_identifier.event_name,
		COUNT(*) AS count_events 
		FROM events
		INNER JOIN event_identifier ON events.event_type = event_identifier.event_type
		GROUP BY event_identifier.event_type, event_identifier.event_name
		ORDER BY event_identifier.event_type, event_identifier.event_name;

	| event_type | event_name    | count_events |
	|------------|---------------|--------------|
	| 1          | Page View     | 20928        |
	| 2          | Add to Cart   | 8451         |
	| 3          | Purchase      | 1777         |
	| 4          | Ad Impression | 876          |
	| 5          | Ad Click      | 702          |

5. What is the percentage of visits which have a purchase event?

	SOLUTION 1 (a bit slower because of the subquery):

		SELECT
		ROUND(1.0*100*COUNT(DISTINCT visit_id)/(SELECT
						 						COUNT(DISTINCT visit_id)
						 						FROM events),2) AS pct_purchases
		FROM events
		WHERE event_type=3

		-- SOLUTION 2:

		WITH cte_visits_with_purchase_flag AS (
		SELECT
		    visit_id,
		    MAX(CASE WHEN event_type = 3 THEN 1 ELSE 0 END) AS purchase_flag
		FROM events
		GROUP BY visit_id
		)

		SELECT
		ROUND(100 * 1.0 * SUM(purchase_flag) / COUNT(*), 2) AS purchase_percentage
		FROM cte_visits_with_purchase_flag;

	| purchase_percentage |
	|---------------------|
	| 49.86               |

6. What is the percentage of visits which view the checkout page but do not have a purchase event?

		WITH checkout_purchase AS (
		SELECT
			visit_id, 
			--e.page_id,
			--page_name,
			--e.event_type,
			--event_name
			MAX(CASE WHEN page_name='Checkout' AND event_name='Page View' THEN 1 ELSE 0 END) AS checkouts,
			MAX(CASE WHEN event_name= 'Purchase' THEN 1 ELSE 0 END) AS purchases
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		GROUP BY 1
		ORDER BY 1
		)

		SELECT
		ROUND(100*(1-(1.0*SUM(purchases)/SUM(checkouts))),2) AS checkout_no_purchase
		FROM checkout_purchase


	SOLUTION 2:

		WITH cte_visits_with_checkout_and_purchase_flags AS (
		SELECT
		    visit_id,
		    -- confirm that the only events that occur on the checkout page are views
		    MAX(CASE WHEN event_type = 1 AND page_id = 12 THEN 1 ELSE 0 END) AS checkout_flag,
		    MAX(CASE WHEN event_type = 3 THEN 1 ELSE 0 END) AS purchase_flag
		FROM events
		GROUP BY visit_id
		)

		SELECT
		ROUND(100 * SUM(CASE WHEN purchase_flag = 0 THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2) AS checkout_without_purchase_percentage
		FROM cte_visits_with_checkout_and_purchase_flags
		WHERE checkout_flag = 1;

	| checkout_without_purchase_percentage |
	|--------------------------------------|
	| 15.50                                |

7. What are the top 3 pages by number of views?

		SELECT
		page_name,
		COUNT(event_name)
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		WHERE event_name='Page View'
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 3

	| page_name    | count |
	|--------------|-------|
	| All Products | 3174  |
	| Checkout     | 2103  |
	| Home Page    | 1782  |

8. What is the number of views and cart adds for each product category?

		SELECT
		product_category,
		COUNT(CASE WHEN event_name='Page View' THEN 1 ELSE NULL END) AS views,
		COUNT(CASE WHEN event_name='Add to Cart' THEN 1 ELSE NULL END) AS additions_to_cart
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		WHERE product_category IS NOT NULL
		GROUP BY 1

	| page_name    | count |
	|--------------|-------|
	| All Products | 3174  |
	| Checkout     | 2103  |
	| Home Page    | 1782  |

9. What are the top 3 products by purchases?

	SOLUTION 1:

		WITH purchases_cte AS (
		SELECT 
		visit_id
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		WHERE event_name = 'Purchase'
		)

		, added_to_cart_cte AS (
		SELECT
		*
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		WHERE event_name IN ('Add to Cart','Purchase')
		)

		, joined_cte AS (
		SELECT 
		*
		FROM purchases_cte pc
		INNER JOIN added_to_cart_cte atcc ON pc.visit_id=atcc.visit_id
		)

		SELECT
		page_name,
		COUNT(*)
		FROM joined_cte
		WHERE product_id IN (1,2,3,4,5,6,7,8,9)   -- Or:   WHERE product_id IS NOT NULL
		GROUP BY 1
		ORDER BY 2 DESC

	SOLUTION 2:

		WITH cte_purchase_visits AS (
		SELECT
			visit_id
		FROM events
		WHERE event_type = 3  
		)

		SELECT
		page_hierarchy.product_id,
		page_hierarchy.page_name AS product_name,
		SUM(CASE WHEN event_type = 2 THEN 1 ELSE 0 END) AS purchases
		FROM events
		INNER JOIN page_hierarchy ON events.page_id = page_hierarchy.page_id
		WHERE EXISTS (
			SELECT 1  
			FROM cte_purchase_visits
			WHERE events.visit_id = cte_purchase_visits.visit_id
		)
		AND page_hierarchy.product_id IS NOT NULL
		GROUP BY page_hierarchy.product_id, product_name
		ORDER BY purchases DESC;

	| product_id | product_name   | purchases |
	|------------|----------------|-----------|
	| 7          | Lobster        | 754       |
	| 9          | Oyster         | 726       |
	| 8          | Crab           | 719       |
	| 1          | Salmon         | 711       |
	| 5          | Black Truffle  | 707       |
	| 2          | Kingfish       | 707       |
	| 6          | Abalone        | 699       |
	| 3          | Tuna           | 697       |
	| 4          | Russian Caviar | 697       |

## C. PRODUCT FUNNEL ANALYSIS

Using a single SQL query - create a new output table which has the following details:

- How many times was each product viewed?
- How many times was each product added to cart?
- How many times was each product added to a cart but not purchased (abandoned)?
- How many times was each product purchased?

		WITH viewed_added_CTE AS (
		SELECT
			visit_id,
			page_name,
			SUM(CASE WHEN e.event_type= 1 THEN 1 ELSE 0 END) AS viewed,
			SUM(CASE WHEN e.event_type= 2 THEN 1 ELSE 0 END) AS added
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		WHERE product_id IN (1,2,3,4,5,6,7,8,9)
		GROUP BY 1,2
		ORDER BY 1
		)

		, finalized_cte AS (
		SELECT DISTINCT 
			visit_id
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		WHERE e.event_type = 3
		--WHERE event_name = 'Purchase'
		)

		, joined_cte AS (
		SELECT
			*,
			CASE WHEN fc.visit_id IS NOT NULL THEN 1 ELSE 0 END AS purchased
		FROM viewed_added_cte vac
		LEFT JOIN finalized_cte fc ON vac.visit_id=fc.visit_id
		)

		SELECT
		page_name,
		SUM(viewed) AS times_viewed,
		SUM(added) AS times_added_to_cart,
		SUM(CASE WHEN added=1 AND purchased=1 THEN 1 ELSE 0 END) AS times_purchased,
		SUM(CASE WHEN added=1 AND purchased =0 THEN 1 ELSE 0 END) As times_not_purchased
		INTO product_analysis
		FROM joined_cte
		GROUP BY page_name
		ORDER BY page_name

		SELECT 
		*
		FROM product_analysis

	| page_name      | times_viewed | times_added_to_cart | times_purchased | times_not_purchased |
	|----------------|--------------|---------------------|-----------------|---------------------|
	| Abalone        | 1525         | 932                 | 699             | 233                 |
	| Black Truffle  | 1469         | 924                 | 707             | 217                 |
	| Crab           | 1564         | 949                 | 719             | 230                 |
	| Kingfish       | 1559         | 920                 | 707             | 213                 |
	| Lobster        | 1547         | 968                 | 754             | 214                 |
	| Oyster         | 1568         | 943                 | 726             | 217                 |
	| Russian Caviar | 1563         | 946                 | 697             | 249                 |
	| Salmon         | 1559         | 938                 | 711             | 227                 |
	| Tuna           | 1515         | 931                 | 697             | 234                 |

	Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

		WITH viewed_added_CTE AS (
		SELECT
			visit_id,
			page_name,
			product_category,
			SUM(CASE WHEN e.event_type= 1 THEN 1 ELSE 0 END) AS viewed,
			SUM(CASE WHEN e.event_type= 2 THEN 1 ELSE 0 END) AS added
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		WHERE product_id IN (1,2,3,4,5,6,7,8,9)
		GROUP BY 1,2,3
		ORDER BY 1
		)

		, finalized_cte AS (
		SELECT DISTINCT 
			visit_id
		FROM events e
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		JOIN event_identifier ei ON e.event_type=ei.event_type
		WHERE e.event_type = 3
		--WHERE event_name = 'Purchase'
		)

		, joined_cte AS (
		SELECT
			*,
			CASE WHEN fc.visit_id IS NOT NULL THEN 1 ELSE 0 END AS purchased
		FROM viewed_added_cte vac
		LEFT JOIN finalized_cte fc ON vac.visit_id=fc.visit_id
		)

		, category_cte AS (
		SELECT
			page_name,
			product_category,
			SUM(viewed) AS times_viewed,
			SUM(added) AS times_added_to_cart,
			SUM(CASE WHEN added=1 AND purchased=1 THEN 1 ELSE 0 END) AS purchased,
			SUM(CASE WHEN added=1 AND purchased =0 THEN 1 ELSE 0 END) As not_purchased
		FROM joined_cte
		GROUP BY 1,2
		ORDER BY 1,2
		)

		SELECT 
		product_category,
		SUM(times_viewed) AS times_viewed,
		SUM(times_added_to_cart) AS times_added_to_cart,
		SUM(purchased) AS times_purchased,
		SUM(not_purchased) AS times_not_purchased
		INTO category_analysis
		FROM category_cte
		GROUP BY 1

		SELECT 
		*
		FROM category_analysis

	| product_category | times_viewed | times_added_to_cart | times_purchased | times_not_purchased |
	|------------------|--------------|---------------------|-----------------|---------------------|
	| Luxury           | 3032         | 1870                | 1404            | 466                 |
	| Shellfish        | 6204         | 3792                | 2898            | 894                 |
	| Fish             | 4633         | 2789                | 2115            | 674                 |

	Using your 2 new output tables - answer the following questions.

	1. Which product had the most views, cart adds and purchases?

			SELECT
			*
			FROM product_analysis


		|    page_name      | times_viewed | times_added_to_cart | times_purchased | times_not_purchased |
		|----------------|--------------|---------------------|-----------------|---------------------|
		|    Abalone        | 1525         | 932                 | 699             | 233                 |
		|    Black Truffle  | 1469         | 924                 | 707             | 217                 |
		|    Crab           | 1564         | 949                 | 719             | 230                 |
		|    Kingfish       | 1559         | 920                 | 707             | 213                 |
		|    Lobster        | 1547         | 968                 | 754             | 214                 |
		|    Oyster         | 1568         | 943                 | 726             | 217                 |
		|    Russian Caviar | 1563         | 946                 | 697             | 249                 |
		|    Salmon         | 1559         | 938                 | 711             | 227                 |
		|    Tuna           | 1515         | 931                 | 697             | 234                 |

	2. Which product was most likely to be abandoned?

			SELECT
			page_name,
			ROUND(times_not_purchased / times_added_to_cart,2) AS abandoned_likelihood
			FROM product_analysis
			ORDER BY abandoned_likelihood DESC
			LIMIT 1;

		|    page_name      | abandoned_likelihood |
		|----------------|----------------------|
		|    Russian Caviar | 0.26                 |

	3. Which product had the highest view to purchase percentage?

			SELECT
			page_name,
			ROUND(1.0*100*times_purchased/times_viewed,2) AS views_to_purchase
			FROM product_analysis
			ORDER BY 2 DESC

		|    page_name      | views_to_purchase |
		|----------------|-------------------|
		|    Lobster        | 48.74             |
		|    Black Truffle  | 48.13             |
		|    Oyster         | 46.30             |
		|    Tuna           | 46.01             |
		|    Crab           | 45.97             |
		|    Abalone        | 45.84             |
		|    Salmon         | 45.61             |
		|    Kingfish       | 45.35             |
		|    Russian Caviar | 44.59             |

	4. What is the average conversion rate from view to cart add?

	5. What is the average conversion rate from cart add to purchase?

			SELECT
			ROUND(1.0*100*AVG(times_added_to_cart/times_viewed),2) AS view_to_add,
			ROUND(1.0*100*AVG(times_purchased/times_added_to_cart),2) AS add_to_purchase
			FROM product_analysis

		|    view_to_add | add_to_purchase |
		|-------------|-----------------|
		|    60.95       | 75.93           |

## D. CAMPAIGN ANALYSIS

Generate a table that has 1 single row for every unique visit_id record and has the following columns:

- user_id
- visit_id
- visit_start_time: the earliest event_time for each visit
- page_views: count of page views for each visit
- cart_adds: count of product cart add events for each visit
- purchase: 1/0 flag if a purchase event exists for each visit
- campaign_name: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
- impression: count of ad impressions for each visit
- click: count of ad clicks for each visit
- (Optional column) cart_products: a comma separated text value with products added to the cart sorted by the order they were added to the cart (hint: use the sequence_number)
Use the subsequent dataset to generate at least 5 insights for the Clique Bait team - bonus: prepare a single A4 infographic that the team can use for their management reporting sessions, be sure to emphasise the most important points from your findings.

Some ideas you might want to investigate further include:

- Identifying users who have received impressions during each campaign period and comparing each metric with other users who did not have an impression event
- Does clicking on an impression lead to higher purchase rates?
- What is the uplift in purchase rate when comparing users who click on a campaign impression versus users who do not receive an impression? What if we compare them with users who just an impression but do not click?
- What metrics can you use to quantify the success or failure of each campaign compared to eachother?

		SELECT
		user_id,
		visit_id,
		campaign_name,
		MIN(event_time) AS visit_start_time,
		SUM(CASE WHEN event_type=1 THEN 1 ELSE 0 END ) AS page_views,
		SUM(CASE WHEN event_type=2 THEN 1 ELSE 0 END) AS cart_adds,
		MAX(CASE WHEN event_type=3 THEN 1 ELSE 0 END) AS purchase,
		SUM(CASE WHEN event_type=4 THEN 1 ELSE 0 END ) AS impression,
		SUM(CASE WHEN event_type=5 THEN 1 ELSE 0 END) AS click,
		STRING_AGG(CASE WHEN ph.product_id IS NOT NULL AND e.event_type = 2 THEN ph.page_name ELSE NULL END, 
		', ' ORDER BY e.sequence_number) AS cart_products
		FROM events e
		JOIN users u ON e.cookie_id=u.cookie_id
		JOIN page_hierarchy ph ON e.page_id=ph.page_id
		LEFT JOIN campaign_identifier ci ON e.event_time BETWEEN ci.start_date AND ci.end_date
		GROUP BY 1,2,3
		LIMIT 20;

	| user_id | visit_id | campaign_name                     | visit_start_time           | page_views | cart_adds | purchase | impression | click | cart_products                                                                         |
	|---------|----------|-----------------------------------|----------------------------|------------|-----------|----------|------------|-------|---------------------------------------------------------------------------------------|
	| 1       | 02a5d5   | Half Off - Treat Your Shellf(ish) | 2020-02-26 16:57:26.260871 | 4          | 0         | 0        | 0          | 0     | NULL                                                                                  |
	| 1       | 0826dc   | Half Off - Treat Your Shellf(ish) | 2020-02-26 05:58:37.918618 | 1          | 0         | 0        | 0          | 0     | NULL                                                                                  |
	| 1       | 0fc437   | Half Off - Treat Your Shellf(ish) | 2020-02-04 17:49:49.602976 | 10         | 6         | 1        | 1          | 1     | Tuna, Russian Caviar, Black Truffle, Abalone, Crab, Oyster                            |
	| 1       | 30b94d   | Half Off - Treat Your Shellf(ish) | 2020-03-15 13:12:54.023936 | 9          | 7         | 1        | 1          | 1     | Salmon, Kingfish, Tuna, Russian Caviar, Abalone, Lobster, Crab                        |
	| 1       | 41355d   | Half Off - Treat Your Shellf(ish) | 2020-03-25 00:11:17.860655 | 6          | 1         | 0        | 0          | 0     | Lobster                                                                               |
	| 1       | ccf365   | Half Off - Treat Your Shellf(ish) | 2020-02-04 19:16:09.182546 | 7          | 3         | 1        | 0          | 0     | Lobster, Crab, Oyster                                                                 |
	| 1       | eaffde   | Half Off - Treat Your Shellf(ish) | 2020-03-25 20:06:32.342989 | 10         | 8         | 1        | 1          | 1     | Salmon, Tuna, Russian Caviar, Black Truffle, Abalone, Lobster, Crab, Oyster           |
	| 1       | f7c798   | Half Off - Treat Your Shellf(ish) | 2020-03-15 02:23:26.312543 | 9          | 3         | 1        | 0          | 0     | Russian Caviar, Crab, Oyster                                                          |
	| 2       | 0635fb   | Half Off - Treat Your Shellf(ish) | 2020-02-16 06:42:42.73573  | 9          | 4         | 1        | 0          | 0     | Salmon, Kingfish, Abalone, Crab                                                       |
	| 2       | 1f1198   | Half Off - Treat Your Shellf(ish) | 2020-02-01 21:51:55.078775 | 1          | 0         | 0        | 0          | 0     | NULL                                                                                  |
	| 2       | 3b5871   | 25% Off - Living The Lux Life     | 2020-01-18 10:16:32.158475 | 9          | 6         | 1        | 1          | 1     | Salmon, Kingfish, Russian Caviar, Black Truffle, Lobster, Oyster                      |
	| 2       | 49d73d   | Half Off - Treat Your Shellf(ish) | 2020-02-16 06:21:27.138532 | 11         | 9         | 1        | 1          | 1     | Salmon, Kingfish, Tuna, Russian Caviar, Black Truffle, Abalone, Lobster, Crab, Oyster |
	| 2       | 910d9a   | Half Off - Treat Your Shellf(ish) | 2020-02-01 10:40:46.875968 | 8          | 1         | 0        | 0          | 0     | Abalone                                                                               |
	| 2       | c5c0ee   | 25% Off - Living The Lux Life     | 2020-01-18 10:35:22.765382 | 1          | 0         | 0        | 0          | 0     | NULL                                                                                  |
	| 2       | d58cbd   | 25% Off - Living The Lux Life     | 2020-01-18 23:40:54.761906 | 8          | 4         | 0        | 0          | 0     | Kingfish, Tuna, Abalone, Crab                                                         |
	| 2       | e26a84   | 25% Off - Living The Lux Life     | 2020-01-18 16:06:40.90728  | 6          | 2         | 1        | 0          | 0     | Salmon, Oyster                                                                        |
	| 3       | 25502e   | Half Off - Treat Your Shellf(ish) | 2020-02-21 11:26:15.353389 | 1          | 0         | 0        | 0          | 0     | NULL                                                                                  |
	| 3       | 76ee84   | NULL                              | 2020-05-28 20:11:54.997406 | 7          | 3         | 1        | 0          | 0     | Salmon, Lobster, Crab                                                                 |
	| 3       | 791afc   | NULL                              | 2020-04-29 00:37:16.741118 | 8          | 2         | 1        | 0          | 0     | Salmon, Oyster                                                                        |
	| 3       | 7e89a0   | NULL                              | 2020-05-28 10:57:51.749847 | 9          | 6         | 0        | 1          | 1     | Salmon, Tuna, Russian Caviar, Black Truffle, Lobster, Crab                            |



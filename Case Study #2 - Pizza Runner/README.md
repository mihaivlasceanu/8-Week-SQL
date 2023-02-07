# Case Study #2 - Pizza Runner

![Pizza Runner logo](https://photos.google.com/album/AF1QipPs8My-_GQ-dLdnWDUwzropnS3JUTVTQiwxgiEP/photo/AF1QipNVmOhYeOkZB-sc0UE35CnHelJocQR6MRjDiWLk)

## 📚  Table of Contents

-   [📋  Introduction](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#briefcase-business-case)
-   [📄 Available Data](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#bookmark_tabsexample-datasets)
-   [❓  Case Study Questions](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#triangular_flag_on_post-questions-and-solution)
-  [✔️  Solutions](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#triangular_flag_on_post-questions-and-solution)

# Introduction

Did you know that over  **115 million kilograms**  of pizza is consumed daily worldwide??? (Well according to Wikipedia anyway…)

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to  _Uberize_  it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

# Available Data

Because Danny had a few years of experience as a data scientist - he was very aware that data collection was going to be critical for his business’ growth.

He has prepared for us an entity relationship diagram of his database design but requires further assistance to clean his data and apply some basic calculations so he can better direct his runners and optimise Pizza Runner’s operations.

## Entity Relationship Diagram

![Pizza Runner ERD](https://photos.google.com/album/AF1QipPs8My-_GQ-dLdnWDUwzropnS3JUTVTQiwxgiEP/photo/AF1QipPSWfMVoTnEn9yPY52MLBQypLKD6OaUfnvU4gfp)

## Datasets

### Table 1: runners

The  `runners`  table shows the  `registration_date`  for each new runner

| runner_id | registration_date |
|-----------|-------------------|
| 1         | 2021-01-01        |
| 2         | 2021-01-03        |
| 3         | 2021-01-08        |
| 4         | 2021-01-15        |

### Table 2: customer_orders

Customer pizza orders are captured in the  `customer_orders`  table with 1 row for each individual pizza that is part of the order.

The  `pizza_id`  relates to the type of pizza which was ordered whilst the  `exclusions`  are the  `ingredient_id`  values which should be removed from the pizza and the  `extras`  are the  `ingredient_id`  values which need to be added to the pizza.

Note that customers can order multiple pizzas in a single order with varying  `exclusions`  and  `extras`  values even if the pizza is the same type!

The  `exclusions`  and  `extras`  columns will need to be cleaned up before using them in your queries.

| order_id | customer_id | pizza_id | exclusions | extras | order_time          |
|----------|-------------|----------|------------|--------|---------------------|
| 1        | 101         | 1        |            |        | 2021-01-01 18:05:02 |
| 2        | 101         | 1        |            |        | 2021-01-01 19:00:52 |
| 3        | 102         | 1        |            |        | 2021-01-02 23:51:23 |
| 3        | 102         | 2        |            | NaN    | 2021-01-02 23:51:23 |
| 4        | 103         | 1        | 4          |        | 2021-01-04 13:23:46 |
| 4        | 103         | 1        | 4          |        | 2021-01-04 13:23:46 |
| 4        | 103         | 2        | 4          |        | 2021-01-04 13:23:46 |
| 5        | 104         | 1        | null       | 1      | 2021-01-08 21:00:29 |
| 6        | 101         | 2        | null       | null   | 2021-01-08 21:03:13 |
| 7        | 105         | 2        | null       | 1      | 2021-01-08 21:20:29 |
| 8        | 102         | 1        | null       | null   | 2021-01-09 23:54:33 |
| 9        | 103         | 1        | 4          | 1, 5   | 2021-01-10 11:22:59 |
| 10       | 104         | 1        | null       | null   | 2021-01-11 18:34:49 |
| 10       | 104         | 1        | 2, 6       | 1, 4   | 2021-01-11 18:34:49 |

### Table 3: runner_orders

After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer.

The  `pickup_time`  is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. The  `distance`  and  `duration`  fields are related to how far and long the runner had to travel to deliver the order to the respective customer.

There are some known data issues with this table so be careful when using this in your queries - make sure to check the data types for each column in the ERD!

| order_id | runner_id | pickup_time         | distance | duration   | cancellation            |
|----------|-----------|---------------------|----------|------------|-------------------------|
| 1        | 1         | 2021-01-01 18:15:34 | 20km     | 32 minutes |                         |
| 2        | 1         | 2021-01-01 19:10:54 | 20km     | 27 minutes |                         |
| 3        | 1         | 2021-01-03 00:12:37 | 13.4km   | 20 mins    | NaN                     |
| 4        | 2         | 2021-01-04 13:53:03 | 23.4     | 40         | NaN                     |
| 5        | 3         | 2021-01-08 21:10:57 | 10       | 15         | NaN                     |
| 6        | 3         | null                | null     | null       | Restaurant Cancellation |
| 7        | 2         | 2020-01-08 21:30:45 | 25km     | 25mins     | null                    |
| 8        | 2         | 2020-01-10 00:15:02 | 23.4 km  | 15 minute  | null                    |
| 9        | 2         | null                | null     | null       | Customer Cancellation   |
| 10       | 1         | 2020-01-11 18:50:20 | 10km     | 10minutes  | null                    |

### Table 4: pizza_names

At the moment - Pizza Runner only has 2 pizzas available the Meat Lovers or Vegetarian!

| pizza_id | pizza_name  |
|----------|-------------|
| 1        | Meat Lovers |
| 2        | Vegetarian  |

### Table 5: pizza_recipes

Each  `pizza_id`  has a standard set of  `toppings`  which are used as part of the pizza recipe.

| pizza_id | toppings                |
|----------|-------------------------|
| 1        | 1, 2, 3, 4, 5, 6, 8, 10 |
| 2        | 4, 6, 7, 9, 11, 12      |

### Table 6: pizza_toppings

This table contains all of the  `topping_name`  values with their corresponding  `topping_id`  value

| topping_id | topping_name |
|------------|--------------|
| 1          | Bacon        |
| 2          | BBQ Sauce    |
| 3          | Beef         |
| 4          | Cheese       |
| 5          | Chicken      |
| 6          | Mushrooms    |
| 7          | Onions       |
| 8          | Pepperoni    |
| 9          | Peppers      |
| 10         | Salami       |
| 11         | Tomatoes     |
| 12         | Tomato Sauce |

# Case Study Questions

This case study has  **LOTS**  of questions - they are broken up by area of focus including: * Pizza Metrics * Runner and Customer Experience * Ingredient Optimisation * Pricing and Ratings * Bonus DML Challenges (DML = Data Manipulation Language)

Each of the following case study questions can be answered using a single SQL statement.

Again, there are many questions in this case study - please feel free to pick and choose which ones you’d like to try!

Before you start writing your SQL queries however - you might want to investigate the data, you may want to do something with some of those  `null`  values and data types in the  `customer_orders`  and  `runner_orders`  tables!

## A. Pizza Metrics

1.  How many pizzas were ordered?
2.  How many unique customer orders were made?
3.  How many successful orders were delivered by each runner?
4.  How many of each type of pizza was delivered?
5.  How many Vegetarian and Meatlovers were ordered by each customer?
6.  What was the maximum number of pizzas delivered in a single order?
7.  For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8.  How many pizzas were delivered that had both exclusions and extras?
9.  What was the total volume of pizzas ordered for each hour of the day?
10.  What was the volume of orders for each day of the week?

## B. Runner and Customer Experience

1.  How many runners signed up for each 1 week period? (i.e. week starts  `2021-01-01`)
2.  What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
3.  Is there any relationship between the number of pizzas and how long the order takes to prepare?
4.  What was the average distance travelled for each customer?
5.  What was the difference between the longest and shortest delivery times for all orders?
6.  What was the average speed for each runner for each delivery and do you notice any trend for these values?
7.  What is the successful delivery percentage for each runner?

## C. Ingredient Optimisation

1.  What are the standard ingredients for each pizza?
2.  What was the most commonly added extra?
3.  What was the most common exclusion?
4.  Generate an order item for each record in the  `customers_orders`  table in the format of one of the following:

-   `Meat Lovers`
-   `Meat Lovers - Exclude Beef`
-   `Meat Lovers - Extra Bacon`
-   `Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers`

5.  Generate an alphabetically ordered comma separated ingredient list for each pizza order from the  `customer_orders`  table and add a  `2x`  in front of any relevant ingredients

-   For example:  `"Meat Lovers: 2xBacon, Beef, ... , Salami"`

6.  What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

## D. Pricing and Ratings

1.  If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
2.  What if there was an additional $1 charge for any pizza extras?

-   Add cheese is $1 extra

3.  The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
4.  Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?

-   `customer_id`
-   `order_id`
-   `runner_id`
-   `rating`
-   `order_time`
-   `pickup_time`
-   Time between order and pickup
-   Delivery duration
-   Average speed
-   Total number of pizzas

5.  If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

## E. Bonus Questions

If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an  `INSERT`  statement to demonstrate what would happen if a new  `Supreme`  pizza with all the toppings was added to the Pizza Runner menu?

# Solutions

Before anything else, we notice that two of the tables (customer_orders and runner_orders) have some issues with NULL values and data inconsistencies that we need to address.


	DROP TABLE IF EXISTS temp_customer_orders;
	CREATE TEMP TABLE temp_customer_orders AS
	SELECT 
		order_id,	
		customer_id,	
		pizza_id,	
		CASE WHEN exclusions IN ('null','') THEN NULL
			 ELSE exclusions END AS exclusions,
		CASE WHEN extras IN ('null','') THEN NULL
			 ELSE extras END AS extras,	
		order_time
	FROM customer_orders;

	SELECT *
	FROM temp_customer_orders;
| order_id | customer_id | pizza_id | exclusions | extras | order_time          |
|----------|-------------|----------|------------|--------|---------------------|
| 1        | 101         | 1        | NULL       | NULL   | 2020-01-01 18:05:02 |
| 2        | 101         | 1        | NULL       | NULL   | 2020-01-01 19:00:52 |
| 3        | 102         | 1        | NULL       | NULL   | 2020-01-02 23:51:23 |
| 3        | 102         | 2        | NULL       | NULL   | 2020-01-02 23:51:23 |
| 4        | 103         | 1        | 4          | NULL   | 2020-01-04 13:23:46 |
| 4        | 103         | 1        | 4          | NULL   | 2020-01-04 13:23:46 |
| 4        | 103         | 2        | 4          | NULL   | 2020-01-04 13:23:46 |
| 5        | 104         | 1        | NULL       | 1      | 2020-01-08 21:00:29 |
| 6        | 101         | 2        | NULL       | NULL   | 2020-01-08 21:03:13 |
| 7        | 105         | 2        | NULL       | 1      | 2020-01-08 21:20:29 |
| 8        | 102         | 1        | NULL       | NULL   | 2020-01-09 23:54:33 |
| 9        | 103         | 1        | 4          | 1, 5   | 2020-01-10 11:22:59 |
| 10       | 104         | 1        | NULL       | NULL   | 2020-01-11 18:34:49 |
| 10       | 104         | 1        | 2, 6       | 1, 4   | 2020-01-11 18:34:49 |


	DROP TABLE IF EXISTS temp_runner_orders;
	CREATE TEMP TABLE temp_runner_orders AS
	SELECT 
		order_id,
		runner_id,	
		CASE WHEN pickup_time='null' THEN NULL
			 ELSE pickup_time END AS pickup_time,	
		CASE WHEN distance='null' THEN NULL
			 ELSE SPLIT_PART(distance,'k',1) END AS distance,
			      --UNNEST(REGEXP_MATCH(t2.distance, '(^[0-9,.]+)'))::NUMERIC AS distance     --another option
		CASE WHEN duration='null' THEN NULL
			 ELSE TRIM(both ' ' FROM SPLIT_PART(duration,'m',1)) END AS duration, 
			      --UNNEST(REGEXP_MATCH(duration, '(^[0-9]+)'))::NUMERIC AS duration          --another option 
		CASE WHEN cancellation in ('Restaurant Cancellation','Customer Cancellation') THEN cancellation
			 WHEN cancellation in ('','null') THEN NULL END AS cancellation
	FROM runner_orders;

	SELECT *
	FROM temp_runner_orders;

| order_id | runner_id | pickup_time         | distance | duration | cancellation            |
|----------|-----------|---------------------|----------|----------|-------------------------|
| 1        | 1         | 2020-01-01 18:15:34 | 20       | 32       | NULL                    |
| 2        | 1         | 2020-01-01 19:10:54 | 20       | 27       | NULL                    |
| 3        | 1         | 2020-01-03 00:12:37 | 13.4     | 20       | NULL                    |
| 4        | 2         | 2020-01-04 13:53:03 | 23.4     | 40       | NULL                    |
| 5        | 3         | 2020-01-08 21:10:57 | 10       | 15       | NULL                    |
| 6        | 3         | NULL                | NULL     | NULL     | Restaurant Cancellation |
| 7        | 2         | 2020-01-08 21:30:45 | 25       | 25       | NULL                    |
| 8        | 2         | 2020-01-10 00:15:02 | 23.4     | 15       | NULL                    |
| 9        | 2         | NULL                | NULL     | NULL     | Customer Cancellation   |
| 10       | 1         | 2020-01-11 18:50:20 | 10       | 10       | NULL                    |

We also adjust the recipes table, making it easier to join

	DROP TABLE IF EXISTS temp_recipes;
	CREATE TEMP TABLE temp_recipes AS 
	SELECT
		pizza_id,
		REGEXP_SPLIT_TO_TABLE(toppings, ',')::integer AS toppings
		--REGEXP_SPLIT_TO_TABLE(toppings, '[,\s]+')::INTEGER AS topping_id      -- another option
	FROM pizza_recipes;

	SELECT *
	FROM temp_recipes;

| pizza_id | toppings |
|----------|----------|
| 1        | 1        |
| 1        | 2        |
| 1        | 3        |
| 1        | 4        |
| 1        | 5        |
| 1        | 6        |
| 1        | 8        |
| 1        | 10       |
| 2        | 4        |
| 2        | 6        |
| 2        | 7        |
| 2        | 9        |
| 2        | 11       |
| 2        | 12       |


## A. PIZZA METRICS 
1. How many pizzas were ordered?

		SELECT 
		COUNT(*)
		FROM temp_customer_orders;

	| count |
	|-------|
	| 14    |

2. How many unique customer orders were made?

		SELECT 
		COUNT(DISTINCT order_id)
		FROM temp_customer_orders;

	| count |
	|-------|
	| 10    |

3. How many successful orders were delivered by each runner?

		SELECT
		runner_id,
		COUNT(order_id) 
		FROM temp_runner_orders
		WHERE cancellation IS NULL OR cancellation NOT IN ('Restaurant Cancellation','Customer Cancellation')
		GROUP BY 1
		ORDER BY runner_id;
		
	 | runner_id | count |
	|-----------|-------|
	| 1         | 4     |
	| 2         | 3     |
	| 3         | 1     | 

4. How many of each type of pizza was delivered?

	SOLUTION 1:

		SELECT 
		p.pizza_name,
		COUNT(*)
		FROM temp_customer_orders c
		INNER JOIN temp_runner_orders r ON c.order_id=r.order_id
		INNER JOIN pizza_names p ON c.pizza_id=p.pizza_id
		WHERE cancellation IS NULL OR cancellation NOT IN ('Restaurant Cancellation','Customer Cancellation')
		GROUP BY 1;

	SOLUTION 2 (using a LEFT SEMI JOIN):

		SELECT
		t2.pizza_name,
		COUNT(t1.*) AS delivered_pizza_count
		FROM temp_customer_orders AS t1
		INNER JOIN pizza_names AS t2 ON t1.pizza_id = t2.pizza_id
		WHERE EXISTS (
			SELECT 1 
			FROM temp_runner_orders AS t3
			WHERE t1.order_id = t3.order_id
			AND (t3.cancellation IS NULL
		     	OR t3.cancellation NOT IN ('Restaurant Cancellation', 'Customer Cancellation'))
		)
		GROUP BY t2.pizza_name
		ORDER BY t2.pizza_name;

	| pizza_name | delivered_pizza_count |
	|------------|-----------------------|
	| Meatlovers | 9                     |
	| Vegetarian | 3                     |
	
5. How many Vegetarian and Meatlovers were ordered by each customer? Observation: ORDERED, not necessarilly also delivered.

	SOLUTION 1:

		SELECT 
		c.customer_id,
		p.pizza_name,
		COUNT(*)
		FROM temp_customer_orders c
		INNER JOIN temp_runner_orders r ON c.order_id=r.order_id
		INNER JOIN pizza_names p ON c.pizza_id=p.pizza_id
		GROUP BY 1,2
		ORDER BY 1;

	| customer_id | pizza_name | count |
	|-------------|------------|-------|
	| 101         | Meatlovers | 2     |
	| 101         | Vegetarian | 1     |
	| 102         | Meatlovers | 2     |
	| 102         | Vegetarian | 1     |
	| 103         | Meatlovers | 3     |
	| 103         | Vegetarian | 1     |
	| 104         | Meatlovers | 3     |
	| 105         | Vegetarian | 1     |
	
	SOLUTION 2 (differently displayed):

		SELECT 
		c.customer_id,
		SUM(CASE WHEN pizza_id=1 then 1 ELSE 0 END) AS meatlovers,
		SUM(CASE WHEN pizza_id=2 then 1 ELSE 0 END) AS vegetarian
		FROM temp_customer_orders c
		GROUP BY 1
		ORDER BY 1;
		
	| customer_id | meatlovers | vegetarian |
	|-------------|------------|------------|
	| 101         | 2          | 1          |
	| 102         | 2          | 1          |
	| 103         | 3          | 1          |
	| 104         | 3          | 0          |
	| 105         | 0          | 1          |
	
6. What was the maximum number of pizzas delivered in a single order?

	SOLUTION 1:

		SELECT 
		c.order_id,
		COUNT(*)
		FROM temp_customer_orders c
		INNER JOIN temp_runner_orders r ON c.order_id=r.order_id
		WHERE cancellation IS NULL OR cancellation NOT IN ('Restaurant Cancellation','Customer Cancellation')
		GROUP BY 1
		ORDER BY 2 DESC;

	| order_id | count |
	|----------|-------|
	| 4        | 3     |
	| 10       | 2     |
	| 3        | 2     |
	| 7        | 1     |
	| 1        | 1     |
	| 8        | 1     |
	| 5        | 1     |
	| 2        | 1     |

	SOLUTION 2:

		WITH cte_ranked_orders AS (
		SELECT
			order_id,
			COUNT(*) AS pizza_count,
			RANK() OVER (ORDER BY COUNT(*) DESC) AS count_rank
		FROM temp_customer_orders AS t1
		WHERE EXISTS (
			SELECT 1 
			FROM temp_runner_orders AS t2
			WHERE t1.order_id = t2.order_id
			AND (t2.cancellation IS NULL
		  		OR t2.cancellation NOT IN ('Restaurant Cancellation', 'Customer Cancellation'))
		)
		GROUP BY order_id
		)

		SELECT pizza_count 
		FROM cte_ranked_orders 
		WHERE count_rank = 1;

	| pizza_count |
	|-------------|
	| 3           |

7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

	SOLUTION 1:

		SELECT
		customer_id,
		SUM(CASE WHEN exclusions IS NOT NULL OR extras IS NOT NULL THEN 1 ELSE 0 END) AS with_changes,
		SUM(CASE WHEN exclusions IS NULL AND extras IS NULL THEN 1 ELSE 0 END) AS no_changes
		FROM temp_customer_orders c
		INNER JOIN temp_runner_orders r ON c.order_id = r.order_id
		WHERE cancellation IS NULL OR cancellation NOT IN ('Restaurant Cancellation','Customer Cancellation')
		GROUP BY 1
		ORDER BY 1;

	SOLUTION 2 :

		SELECT
		customer_id,
		SUM(CASE WHEN exclusions IS NOT NULL OR extras IS NOT NULL THEN 1 ELSE 0 END) AS at_least_1_change,
		SUM(CASE WHEN exclusions IS NULL AND extras IS NULL THEN 1 ELSE 0 END) AS no_changes
		FROM temp_customer_orders AS t1
		WHERE EXISTS (
			SELECT 1 
			FROM temp_runner_orders AS t2
			WHERE t1.order_id = t2.order_id
			AND (t2.cancellation IS NULL
		     	OR t2.cancellation NOT IN ('Restaurant Cancellation', 'Customer Cancellation'))
		)
		GROUP BY customer_id
		ORDER BY customer_id;

	| customer_id | at_least_1_change | no_changes |
	|-------------|-------------------|------------|
	| 101         | 0                 | 2          |
	| 102         | 0                 | 3          |
	| 103         | 3                 | 0          |
	| 104         | 2                 | 1          |
	| 105         | 1                 | 0          |
	
8. How many pizzas were delivered that had both exclusions and extras?

		SELECT 
		SUM(CASE WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN 1 ELSE 0 END) as with_changes
		FROM temp_customer_orders c
		INNER JOIN temp_runner_orders r ON c.order_id=r.order_id
		WHERE cancellation IS NULL OR cancellation NOT IN ('Restaurant Cancellation','Customer Cancellation');

	| with_changes |
	|--------------|
	| 1            |
	
9. What was the total volume of pizzas ordered for each hour of the day?

		SELECT
		DATE_PART('hour', order_time) AS hour,
		COUNT(pizza_id)
		FROM temp_customer_orders
		GROUP BY 1
		ORDER BY 1;

	| hour | count |
	|------|-------|
	| 11   | 1     |
	| 13   | 3     |
	| 18   | 3     |
	| 19   | 1     |
	| 21   | 3     |
	| 23   | 3     |

10. What was the volume of orders for each day of the week?
	
		SELECT
		TO_CHAR(order_time, 'Day') AS day_of_week,
		COUNT(pizza_id)
		FROM temp_customer_orders
		GROUP BY 1
		ORDER BY 1;
	|  day_of_week | count |
	|-------------|-------|
	|  Friday      | 1     |
	|  Saturday    | 5     |
	|  Thursday    | 3     |
	|  Wednesday   | 5     |

## B. RUNNER AND CUSTOMER EXPERIENCE
1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

	SOLUTION 1:

		WITH cte_weeks AS (
		SELECT
			runner_id,
			registration_date,
			registration_date - ((registration_date - '2021-01-01') % 7)  AS start_of_week
		FROM runners
		)

		SELECT 
		start_of_week,
		COUNT(runner_id)
		FROM cte_weeks
		GROUP BY 1
		ORDER BY 1;


	SOLUTION 2:

		SELECT
		DATE_TRUNC('week', registration_date)::DATE + 4 AS registration_week,
		COUNT(*) AS runners
		FROM runners
		GROUP BY registration_week
		ORDER BY registration_week;

	| registration_week | runners |
	|-------------------|---------|
	| 2021-01-01        | 2       |
	| 2021-01-08        | 1       |
	| 2021-01-15        | 1       |

2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

	SOLUTION 1: 

		WITH cte_pickups AS (
		SELECT 
			r.runner_id,
			c.order_id,
			c.order_time,
			r.pickup_time,
			r.pickup_time::TIMESTAMP - c.order_time::TIMESTAMP AS time
		FROM temp_customer_orders c
		INNER JOIN temp_runner_orders r ON c.order_id=r.order_id
		ORDER BY r.runner_id
		)

		SELECT 
		runner_id,
		EXTRACT('minutes' FROM AVG(time)) AS avg_time
		FROM cte_pickups
		GROUP BY runner_id
		ORDER BY runner_id;

	| runner_id | avg_time |
	|-----------|----------|
	| 1         | 15       |
	| 2         | 23       |
	| 3         | 10       |

	SOLUTION 2:

		WITH cte_pickup_minutes AS (
		SELECT DISTINCT
			t1.order_id,
			DATE_PART('minutes', AGE(t1.pickup_time::TIMESTAMP,t2.order_time)) AS pickup_minutes
		FROM temp_runner_orders AS t1
		INNER JOIN temp_customer_orders AS t2 ON t1.order_id = t2.order_id
		WHERE t1.pickup_time IS NOT NULL
		)

		SELECT
		ROUND(AVG(pickup_minutes)::NUMERIC, 3) AS avg_pickup_minutes
		FROM cte_pickup_minutes;

	| avg_pickup_minutes |
	|--------------------|
	| 15.625             |

3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

	SOLUTION 1 (average time per number of pizzas):

		WITH pizzas_per_order AS(
		SELECT
			order_id,
			order_time,
			COUNT(pizza_id) AS number_of_pizzas
		FROM temp_customer_orders
		GROUP BY 1,2
		ORDER BY 1
		)

		, prep_time AS(
		SELECT
			p.order_id,
			p.order_time,
			r.pickup_time,
			p.number_of_pizzas,
			r.pickup_time::TIMESTAMP - p.order_time::TIMESTAMP AS time
		FROM pizzas_per_order p
		INNER JOIN temp_runner_orders r ON p.order_id=r.order_id
		)

		SELECT 
		number_of_pizzas,
		EXTRACT('minutes' FROM AVG(time)) AS avg_time
		FROM prep_time
		GROUP BY 1
		ORDER BY 1;

	| number_of_pizzas | avg_time |
	|------------------|----------|
	| 1                | 12       |
	| 2                | 18       |
	| 3                | 29       |

	SOLUTION 2 (time per order):

		SELECT DISTINCT
		t1.order_id,
		DATE_PART('min', AGE(t1.pickup_time::TIMESTAMP, t2.order_time))::INTEGER AS pickup_minutes,
		COUNT(t2.order_id) AS pizza_count
		FROM temp_runner_orders AS t1
		INNER JOIN temp_customer_orders AS t2 ON t1.order_id = t2.order_id
		WHERE t1.pickup_time IS NOT NULL
		GROUP BY t1.order_id, pickup_minutes
		ORDER BY pizza_count;

	| order_id | pickup_minutes | pizza_count |
	|----------|----------------|-------------|
	| 1        | 10             | 1           |
	| 2        | 10             | 1           |
	| 5        | 10             | 1           |
	| 7        | 10             | 1           |
	| 8        | 20             | 1           |
	| 3        | 21             | 2           |
	| 10       | 15             | 2           |
	| 4        | 29             | 3           |

4. What was the average distance travelled for each customer?

		WITH cte_customer_order_distances AS (
		SELECT DISTINCT
			t1.customer_id,
			t1.order_id,
			distance::NUMERIC
		FROM temp_customer_orders AS t1
		INNER JOIN temp_runner_orders AS t2 ON t1.order_id = t2.order_id
		WHERE t2.pickup_time IS NOT NULL
		)

		SELECT
		customer_id,
		ROUND(AVG(distance), 1) AS avg_distance
		FROM cte_customer_order_distances
		GROUP BY customer_id
		ORDER BY customer_id;

	| customer_id | avg_distance |
	|-------------|--------------|
	| 101         | 20.0         |
	| 102         | 18.4         |
	| 103         | 23.4         |
	| 104         | 10.0         |
	| 105         | 25.0         |

5. What was the difference between the longest and shortest delivery times for all orders?

		SELECT
		MAX(duration::numeric) - MIN(duration::numeric) AS difference
		FROM temp_runner_orders;

	| difference |
	|------------|
	| 30         |

6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

	SOLUTION 1 (comparing differences in speed based on the number of pizzas):

		WITH pizzas_per_order AS(
		SELECT
			order_id,
			order_time,
			COUNT(pizza_id) AS number_of_pizzas
		FROM temp_customer_orders
		GROUP BY 1,2
		ORDER BY 1
		)

		SELECT
		r.runner_id,
		r.order_id,
		ppo.number_of_pizzas,
		r.distance,
		r.duration,
		ROUND(distance::numeric/(duration::numeric/60),2) AS km_per_hour
		FROM temp_runner_orders r
		INNER JOIN pizzas_per_order ppo ON r.order_id=ppo.order_id
		WHERE cancellation IS NULL OR cancellation NOT IN ('Restaurant Cancellation','Customer Cancellation')
		ORDER BY runner_id, number_of_pizzas;
		
	| runner_id | order_id | number_of_pizzas | distance | duration | km_per_hour |
	|-----------|----------|------------------|----------|----------|-------------|
	| 1         | 2        | 1                | 20       | 27       | 44.44       |
	| 1         | 1        | 1                | 20       | 32       | 37.50       |
	| 1         | 10       | 2                | 10       | 10       | 60.00       |
	| 1         | 3        | 2                | 13.4     | 20       | 40.20       |
	| 2         | 7        | 1                | 25       | 25       | 60.00       |
	| 2         | 8        | 1                | 23.4     | 15       | 93.60       |
	| 2         | 4        | 3                | 23.4     | 40       | 35.10       |
	| 3         | 5        | 1                | 10       | 15       | 40.00       |

	SOLUTION 2 (comparing differences in speed based on hour of the day):

		WITH cte_adjusted_runner_orders AS (
		SELECT
			runner_id,
			order_id,
			DATE_PART('hour', pickup_time::TIMESTAMP) AS hour_of_day,
			distance::NUMERIC AS distance,
			duration::NUMERIC AS duration
		FROM temp_runner_orders
		WHERE pickup_time IS NOT NULL
		)

		SELECT
		runner_id,
		order_id,
		hour_of_day,
		distance,
		duration,
		ROUND(distance / (duration / 60), 1) AS avg_speed
		FROM cte_adjusted_runner_orders;

	| runner_id | order_id | hour_of_day | distance | duration | avg_speed |
	|-----------|----------|-------------|----------|----------|-----------|
	| 1         | 1        | 18          | 20       | 32       | 37.5      |
	| 1         | 2        | 19          | 20       | 27       | 44.4      |
	| 1         | 3        | 0           | 13.4     | 20       | 40.2      |
	| 2         | 4        | 13          | 23.4     | 40       | 35.1      |
	| 3         | 5        | 21          | 10       | 15       | 40.0      |
	| 2         | 7        | 21          | 25       | 25       | 60.0      |
	| 2         | 8        | 0           | 23.4     | 15       | 93.6      |
	| 1         | 10       | 18          | 10       | 10       | 60.0      |

7. What is the successful delivery percentage for each runner?

	SOLUTION 1 (with COUNT):

		SELECT
		runner_id,
		COUNT(pickup_time) AS delivered,
		COUNT(*) AS total,
		ROUND(100*COUNT(pickup_time)*1.0/COUNT(*)) AS percentage
		FROM temp_runner_orders
		GROUP BY 1
		ORDER BY 1;

	| runner_id | delivered | total | percentage |
	|-----------|-----------|-------|------------|
	| 1         | 4         | 4     | 100        |
	| 2         | 3         | 4     | 75         |
	| 3         | 1         | 2     | 50         |

	SOLUTION 2 (with SUM):

		SELECT
		runner_id,
		ROUND(100 * SUM(CASE WHEN pickup_time IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*)
		       ) AS success_percentage
		FROM temp_runner_orders
		GROUP BY runner_id
		ORDER BY runner_id;

	| runner_id | success_percentage |
	|-----------|--------------------|
	| 1         | 100                |
	| 2         | 75                 |
	| 3         | 50                 |

## C. INGREDIENT OPTIMISATION
1. What are the standard ingredients for each pizza?

		WITH cte_toppings AS(
		SELECT
			pn.pizza_id,
			pn.pizza_name,
			tr.toppings, 
			pt.topping_name
		FROM pizza_names pn
		JOIN temp_recipes tr ON pn.pizza_id=tr.pizza_id
		JOIN pizza_toppings pt ON tr.toppings=pt.topping_id
		ORDER BY 1,3
		)

		SELECT
		pizza_id,
		STRING_AGG(topping_name, ',' ORDER BY topping_name) AS topping_list
		FROM cte_toppings
		GROUP BY 1
		ORDER BY 1;

	| pizza_id | topping_list                                                   |
	|----------|----------------------------------------------------------------|
	| 1        | Bacon,BBQ Sauce,Beef,Cheese,Chicken,Mushrooms,Pepperoni,Salami |
	| 2        | Cheese,Mushrooms,Onions,Peppers,Tomato Sauce,Tomatoes          |

2. What was the most commonly added extra?

	SOLUTION 1:

		WITH cte_extras AS (
		SELECT
			UNNEST(string_to_array(extras, ', '))::INT AS extras
		FROM temp_customer_orders
		)
			
		SELECT 
		extras,
		topping_name,
		COUNT(*)
		FROM cte_extras ce1
		JOIN pizza_toppings pt ON ce1.extras=pt.topping_id
		GROUP BY 1,2
		ORDER BY 3 DESC;

	| extras | topping_name | count |
	|--------|--------------|-------|
	| 1      | Bacon        | 4     |
	| 4      | Cheese       | 1     |
	| 5      | Chicken      | 1     |

	SOLUTION 2:

		WITH cte_extras AS (
		SELECT
		  REGEXP_SPLIT_TO_TABLE(extras, '[,\s]+')::INTEGER AS topping_id
		FROM temp_customer_orders 
		)

		SELECT
		topping_name,
		COUNT(*) AS extras_count
		FROM cte_extras
		INNER JOIN pizza_toppings ON cte_extras.topping_id = pizza_toppings.topping_id
		GROUP BY topping_name
		ORDER BY extras_count DESC;

	| topping_name | extras_count |
	|--------------|--------------|
	| Bacon        | 4            |
	| Chicken      | 1            |
	| Cheese       | 1            |

3. What was the most common exclusion?

		WITH cte_exclusions AS (
		SELECT
			UNNEST(string_to_array(exclusions, ', '))::INT AS exclusions
		FROM temp_customer_orders)
			
		SELECT 
		exclusions,
		topping_name,
		COUNT(*)
		FROM cte_exclusions ce2
		JOIN pizza_toppings pt ON ce2.exclusions=pt.topping_id
		GROUP BY 1,2
		ORDER BY 3 DESC;

	| exclusions | topping_name | count |
	|------------|--------------|-------|
	| 4          | Cheese       | 4     |
	| 6          | Mushrooms    | 1     |
	| 2          | BBQ Sauce    | 1     |

4. Generate an order item for each record in the customers_orders table in the format of one of the following:
Meat Lovers
Meat Lovers - Exclude Beef
Meat Lovers - Extra Bacon
Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers


		WITH orders_cte AS (
		SELECT
			*,
			ROW_NUMBER() OVER() AS index
		FROM temp_customer_orders
		)

		, exclusions_cte AS (
		SELECT
			order_id,
		    pizza_id,
		    index,
		    string_to_array(exclusions, ', ') AS exclusions
		FROM orders_cte
		WHERE exclusions IS NOT NULL
		)

		, unnest_exclusions_cte AS (
		SELECT 
		    order_id,
		    pizza_id,
		    index,
			exclusions.exclusions::int
		FROM exclusions_cte
		CROSS JOIN UNNEST(exclusions) AS exclusions
		)

		, names_exclusions_cte AS (
		SELECT 
			order_id, 
			pizza_id,
			index,
			'- Exclude '|| STRING_AGG(topping_name, ', ') AS exclusions_names
		FROM unnest_exclusions_cte
		JOIN pizza_toppings ON exclusions = topping_id
		GROUP BY order_id, pizza_id, index
		ORDER BY index
		)

		, extras_cte AS (
		SELECT 
		    order_id,
		    pizza_id,
		    index,
		    string_to_array(extras, ', ') AS extras
		FROM orders_cte
		WHERE extras IS NOT NULL
		)

		, unnest_extras_cte AS (
		SELECT 
		    order_id,
		    pizza_id,
		    index,
			extras.extras::int
		FROM extras_cte
		CROSS JOIN UNNEST(extras) AS extras
		)

		, names_extras_cte AS(
		SELECT 
			order_id, 
			pizza_id,
			index,
			'- Include '|| STRING_AGG(topping_name, ', ') AS extras_names
		FROM unnest_extras_cte
		JOIN pizza_toppings ON extras = topping_id
		GROUP BY order_id, pizza_id, index
		ORDER BY index
		)

		SELECT 
		o.order_id,
		o.pizza_id,
		o.index,
		CASE  WHEN exclusions IS NULL AND extras IS NULL THEN pizza_name
			  WHEN exclusions IS NOT NULL AND extras IS NULL THEN pizza_name || ' ' || exclusions_names
			  WHEN exclusions IS NULL AND extras IS NOT NULL THEN pizza_name || ' ' || extras_names
			  WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN pizza_name || ' ' || exclusions_names || ' ' || extras_names
			  END AS order_item
		FROM orders_cte o
		LEFT JOIN pizza_names pn ON o.pizza_id=pn.pizza_id
		LEFT JOIN names_exclusions_cte nec1 ON o.index=nec1.index
		LEFT JOIN names_extras_cte nec2 ON o.index=nec2.index
		ORDER BY o.order_id;
	
	| order_id | pizza_id | index | order_item                                                        |
	|----------|----------|-------|-------------------------------------------------------------------|
	| 1        | 1        | 1     | Meatlovers                                                        |
	| 2        | 1        | 2     | Meatlovers                                                        |
	| 3        | 2        | 4     | Vegetarian                                                        |
	| 3        | 1        | 3     | Meatlovers                                                        |
	| 4        | 1        | 6     | Meatlovers - Exclude Cheese                                       |
	| 4        | 1        | 5     | Meatlovers - Exclude Cheese                                       |
	| 4        | 2        | 7     | Vegetarian - Exclude Cheese                                       |
	| 5        | 1        | 8     | Meatlovers - Include Bacon                                        |
	| 6        | 2        | 9     | Vegetarian                                                        |
	| 7        | 2        | 10    | Vegetarian - Include Bacon                                        |
	| 8        | 1        | 11    | Meatlovers                                                        |
	| 9        | 1        | 12    | Meatlovers - Exclude Cheese - Include Bacon, Chicken              |
	| 10       | 1        | 13    | Meatlovers                                                        |
	| 10       | 1        | 14    | Meatlovers - Exclude BBQ Sauce, Mushrooms - Include Bacon, Cheese |

5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients. For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"

		WITH cte_orders AS (
		SELECT
		    order_id,
		    customer_id,
		    pizza_id,
		    exclusions,
		    extras,
		    order_time,
		    ROW_NUMBER() OVER () AS original_row_number
		FROM temp_customer_orders
		)

		-- split the toppings using our previous solution
		, cte_regular_toppings AS (
		SELECT
			pizza_id,
			REGEXP_SPLIT_TO_TABLE(toppings, '[,\s]+')::INTEGER AS topping_id
		FROM pizza_recipes
		)

		-- now we can left join our regular toppings with all pizzas orders
		, cte_base_toppings AS (
		SELECT
		    cte_orders.order_id,
		    cte_orders.customer_id,
		    cte_orders.pizza_id,
		    cte_orders.order_time,
		    cte_orders.original_row_number,
		    cte_regular_toppings.topping_id
		FROM cte_orders
		LEFT JOIN cte_regular_toppings ON cte_orders.pizza_id = cte_regular_toppings.pizza_id
		) 

		-- now we can generate CTEs for exclusions and extras by the original row number
		, cte_exclusions AS (
		SELECT
		    order_id,
		    customer_id,
		    pizza_id,
		    order_time,
		    original_row_number,
		    REGEXP_SPLIT_TO_TABLE(exclusions, '[,\s]+')::INTEGER AS topping_id
		FROM cte_orders
		WHERE exclusions IS NOT NULL
		)

		, cte_extras AS (
		SELECT
		    order_id,
		    customer_id,
		    pizza_id,
		    order_time,
		    original_row_number,
		    REGEXP_SPLIT_TO_TABLE(extras, '[,\s]+')::INTEGER AS topping_id
		FROM cte_orders
		WHERE extras IS NOT NULL
		)

		-- now we can perform an except and a union all on the respective CTEs
		, cte_combined_orders AS (
		SELECT * FROM cte_base_toppings
		EXCEPT
		SELECT * FROM cte_exclusions
		UNION ALL
		SELECT * FROM cte_extras
		)

		-- aggregate the count of topping ID and join onto pizza toppings
		, cte_joined_toppings AS (
		SELECT
		    t1.order_id,
		    t1.customer_id,
		    t1.pizza_id,
		    t1.order_time,
		    t1.original_row_number,
		    t1.topping_id,
		    t2.pizza_name,
		    t3.topping_name,
		    COUNT(t1.*) AS topping_count
		FROM cte_combined_orders AS t1
		INNER JOIN pizza_names AS t2 ON t1.pizza_id = t2.pizza_id
		INNER JOIN pizza_toppings AS t3 ON t1.topping_id = t3.topping_id
		GROUP BY
		    t1.order_id,
		    t1.customer_id,
		    t1.pizza_id,
		    t1.order_time,
		    t1.original_row_number,
		    t1.topping_id,
		    t2.pizza_name,
		    t3.topping_name
		)

		SELECT
			order_id,
			customer_id,
			pizza_id,
			order_time,
			original_row_number,
			pizza_name || ': ' || STRING_AGG(
		    	CASE WHEN topping_count > 1 THEN topping_count || 'x ' || topping_name
		      	ELSE topping_name END, ', '
			) AS ingredients_list
		FROM cte_joined_toppings
		GROUP BY
			order_id,
			customer_id,
			pizza_id,
			order_time,
			original_row_number,
			pizza_name;
	
	| order_id | customer_id | pizza_id | order_time          | original_row_number | ingredients_list                                                                     |
	|----------|-------------|----------|---------------------|---------------------|--------------------------------------------------------------------------------------|
	| 1        | 101         | 1        | 2020-01-01 18:05:02 | 1                   | Meatlovers: Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami    |
	| 2        | 101         | 1        | 2020-01-01 19:00:52 | 2                   | Meatlovers: Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami    |
	| 3        | 102         | 1        | 2020-01-02 23:51:23 | 3                   | Meatlovers: Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami    |
	| 3        | 102         | 2        | 2020-01-02 23:51:23 | 4                   | Vegetarian: Cheese, Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce               |
	| 4        | 103         | 1        | 2020-01-04 13:23:46 | 5                   | Meatlovers: Bacon, BBQ Sauce, Beef, Chicken, Mushrooms, Pepperoni, Salami            |
	| 4        | 103         | 1        | 2020-01-04 13:23:46 | 6                   | Meatlovers: Bacon, BBQ Sauce, Beef, Chicken, Mushrooms, Pepperoni, Salami            |
	| 4        | 103         | 2        | 2020-01-04 13:23:46 | 7                   | Vegetarian: Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce                       |
	| 5        | 104         | 1        | 2020-01-08 21:00:29 | 8                   | Meatlovers: 2x Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami |
	| 6        | 101         | 2        | 2020-01-08 21:03:13 | 9                   | Vegetarian: Cheese, Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce               |
	| 7        | 105         | 2        | 2020-01-08 21:20:29 | 10                  | Vegetarian: Bacon, Cheese, Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce        |
	| 8        | 102         | 1        | 2020-01-09 23:54:33 | 11                  | Meatlovers: Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami    |
	| 9        | 103         | 1        | 2020-01-10 11:22:59 | 12                  | Meatlovers: 2x Bacon, BBQ Sauce, Beef, 2x Chicken, Mushrooms, Pepperoni, Salami      |
	| 10       | 104         | 1        | 2020-01-11 18:34:49 | 13                  | Meatlovers: Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami    |
	| 10       | 104         | 1        | 2020-01-11 18:34:49 | 14                  | Meatlovers: 2x Bacon, Beef, 2x Cheese, Chicken, Pepperoni, Salami                    |	  

6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

		WITH cte_orders AS (
		SELECT
		    order_id,
		    customer_id,
		    pizza_id,
		    exclusions,
		    extras,
		    order_time,
		    ROW_NUMBER() OVER () AS original_row_number
		FROM temp_customer_orders
		)

		-- split the toppings using our previous solution
		, cte_regular_toppings AS (
		SELECT
			pizza_id,
			REGEXP_SPLIT_TO_TABLE(toppings, '[,\s]+')::INTEGER AS topping_id
		FROM pizza_recipes
		)

		-- now we can left join our regular toppings with all pizzas orders
		, cte_base_toppings AS (
		SELECT
		    cte_orders.order_id,
		    cte_orders.customer_id,
		    cte_orders.pizza_id,
			-- we left out extras and exclusions, as we'll be adding them back in later
		    cte_orders.order_time,
		    cte_orders.original_row_number,
		    cte_regular_toppings.topping_id
		FROM cte_orders
		LEFT JOIN cte_regular_toppings ON cte_orders.pizza_id = cte_regular_toppings.pizza_id
		)

		-- now we can generate CTEs for exclusions and extras by the original row number
		, cte_exclusions AS (
		SELECT
		    order_id,
		    customer_id,
		    pizza_id,
		    order_time,
		    original_row_number,
		    REGEXP_SPLIT_TO_TABLE(exclusions, '[,\s]+')::INTEGER AS topping_id
		FROM cte_orders
		WHERE exclusions IS NOT NULL
		)

		, cte_extras AS (
		SELECT
		    order_id,
		    customer_id,
		    pizza_id,
		    order_time,
		    original_row_number,
		    REGEXP_SPLIT_TO_TABLE(extras, '[,\s]+')::INTEGER AS topping_id
		FROM cte_orders WHERE extras IS NOT NULL
		)

		-- now we can perform an except and a union all on the respective CTEs
		, cte_combined_orders AS (
		SELECT * FROM cte_base_toppings
		EXCEPT
		SELECT * FROM cte_exclusions
		UNION ALL
		SELECT * FROM cte_extras
		)

		SELECT
		t2.topping_name,
		COUNT(*) AS topping_count
		FROM cte_combined_orders AS t1
		INNER JOIN pizza_toppings AS t2 ON t1.topping_id = t2.topping_id
		GROUP BY t2.topping_name
		ORDER BY topping_count DESC;

	| topping_name | topping_count |
	|--------------|---------------|
	| Bacon        | 14            |
	| Mushrooms    | 13            |
	| Chicken      | 11            |
	| Cheese       | 11            |
	| Pepperoni    | 10            |
	| Salami       | 10            |
	| Beef         | 10            |
	| BBQ Sauce    | 9             |
	| Tomato Sauce | 4             |
	| Onions       | 4             |
	| Tomatoes     | 4             |
	| Peppers      | 4             |

## D. PRICING AND RATINGS
1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

		DROP TABLE IF EXISTS pizza_prices;
		CREATE TABLE pizza_prices (
		  "pizza_id" INTEGER,
		  "prices" INTEGER
		);
		INSERT INTO pizza_prices
		  ("pizza_id", "prices")
		VALUES
		  (1, 12),
		  (2, 10);

		SELECT
		SUM(prices) AS total
		FROM temp_customer_orders tco
		JOIN temp_runner_orders tro ON tco.order_id=tro.order_id
		JOIN pizza_prices pp ON tco.pizza_id=pp.pizza_id
		WHERE pickup_time IS NOT NULL

	| total |
	|-------|
	| 138   |

2. What if there was an additional $1 charge for any pizza extras?
Add cheese is $1 extra

	SOLUTION 1:

		WITH orders_cte AS(
		SELECT
			*,
			ROW_NUMBER() OVER() AS index
		FROM temp_customer_orders
		)

		, extras_cte as (
		SELECT 
		    order_id,
		    pizza_id,
		    index,
		    string_to_array(extras, ', ') AS extras
		FROM orders_cte
		WHERE extras IS NOT NULL
		)

		, unnest_extras_cte as (
		SELECT 
		    order_id,
		    pizza_id,
		    index,
			extras.extras::int
		FROM extras_cte
		CROSS JOIN UNNEST(extras) AS extras
		)

		, cost_extras AS(
		SELECT 
			uec.order_id,
			COUNT(extras) AS cost_of_extras
		FROM unnest_extras_cte uec
		JOIN temp_runner_orders tro ON uec.order_id=tro.order_id
		JOIN pizza_prices pp ON uec.pizza_id=pp.pizza_id
		WHERE pickup_time IS NOT NULL
		GROUP BY 1
		)

		SELECT
		SUM(cost_of_extras) AS total
		FROM cost_extras 

	| total |
	|-------|
	| 4     |

	SOLUTION 2:

		WITH cte_orders AS (
		SELECT
		    order_id,
		    customer_id,
		    pizza_id,
		    exclusions,
		    extras,
		    order_time,
		    ROW_NUMBER() OVER () AS original_row_number
		FROM temp_customer_orders t1
		WHERE EXISTS (
		    SELECT 1 
			FROM temp_runner_orders t2
		    WHERE t1.order_id = t2.order_id
		      AND t2.pickup_time IS NOT NULL)
		)
		SELECT
		SUM((CASE WHEN pizza_id = 1 THEN 12
		          WHEN pizza_id = 2 THEN 10
		     END) -
		     -- we can use CARDINALITY to find the length of array of extras
		     COALESCE( CARDINALITY(REGEXP_SPLIT_TO_ARRAY(extras, '[,\s]+')),0)) AS cost
		FROM cte_orders;

	| cost |
	|------|
	| 134  |

3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

		DROP TABLE IF EXISTS ratings;

		CREATE TABLE ratings(
		order_id int PRIMARY KEY,
		rating integer,
		customer_review VARCHAR(100));

		INSERT INTO ratings(order_id, rating, customer_review)
		VALUES (1, 5, 'Fast and delicious'),
			   (2, 3, 'Pretty good'),
			   (3, 2, 'Not bad but took a bit too long to get here'),
			   (4, 5, 'Best pizza I ever had!'),
			   (5, 4, 'Very good'),
			   (6, NULL, NULL),
			   (7, 1, 'It took a very long time for the delivery guy to get here and the pizza was cold'),
			   (8, 2, 'Meh'),
			   (9, NULL, NULL),
			   (10, 3, 'Nothing spectacular, but good')
			   
		SELECT *
		FROM ratings

	| order_id | rating | customer_review                                                                  |
	|----------|--------|----------------------------------------------------------------------------------|
	| 1        | 5      | Fast and delicious                                                               |
	| 2        | 3      | Pretty good                                                                      |
	| 3        | 2      | Not bad but took a bit too long to get here                                      |
	| 4        | 5      | Best pizza I ever had!                                                           |
	| 5        | 4      | Very good                                                                        |
	| 6        | NULL   | NULL                                                                             |
	| 7        | 1      | It took a very long time for the delivery guy to get here and the pizza was cold |
	| 8        | 2      | Meh                                                                              |
	| 9        | NULL   | NULL                                                                             |
	| 10       | 3      | Nothing spectacular, but good                                                    |

4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
customer_id
order_id
runner_id
rating
order_time
pickup_time
Time between order and pickup
Delivery duration
Average speed
Total number of pizzas
 
		SELECT
		tco.order_id,
		customer_id,
		runner_id,
		rating,
		customer_review,
		order_time,
		pickup_time,
		pickup_time::TIMESTAMP - order_time AS prep_time,
		distance,
		duration,
		ROUND(distance::numeric/(duration::numeric/60),2) AS km_per_hour,
		CASE WHEN pickup_time IS NULL THEN NULL
			 ELSE COUNT(*) END AS number_pizzas
		FROM temp_customer_orders tco 
		JOIN temp_runner_orders tro ON tco.order_id=tro.order_id
		JOIN ratings r ON tco.order_id=r.order_id
		GROUP BY 1,2,3,4,5,6,7,8,9,10
		ORDER BY 1,2

	| order_id | customer_id | runner_id | rating | customer_review                                                                  | order_time          | pickup_time         | prep_time | distance | duration | km_per_hour | number_pizzas |
	|----------|-------------|-----------|--------|----------------------------------------------------------------------------------|---------------------|---------------------|-----------|----------|----------|-------------|---------------|
	| 1        | 101         | 1         | 5      | Fast and delicious                                                               | 2020-01-01 18:05:02 | 2020-01-01 18:15:34 | 00:10:32  | 20       | 32       | 37.50       | 1             |
	| 2        | 101         | 1         | 3      | Pretty good                                                                      | 2020-01-01 19:00:52 | 2020-01-01 19:10:54 | 00:10:02  | 20       | 27       | 44.44       | 1             |
	| 3        | 102         | 1         | 2      | Not bad but took a bit too long to get here                                      | 2020-01-02 23:51:23 | 2020-01-03 00:12:37 | 00:21:14  | 13.4     | 20       | 40.20       | 2             |
	| 4        | 103         | 2         | 5      | Best pizza I ever had!                                                           | 2020-01-04 13:23:46 | 2020-01-04 13:53:03 | 00:29:17  | 23.4     | 40       | 35.10       | 3             |
	| 5        | 104         | 3         | 4      | Very good                                                                        | 2020-01-08 21:00:29 | 2020-01-08 21:10:57 | 00:10:28  | 10       | 15       | 40.00       | 1             |
	| 6        | 101         | 3         | NULL   | NULL                                                                             | 2020-01-08 21:03:13 | NULL                | NULL      | NULL     | NULL     | NULL        | NULL          |
	| 7        | 105         | 2         | 1      | It took a very long time for the delivery guy to get here and the pizza was cold | 2020-01-08 21:20:29 | 2020-01-08 21:30:45 | 00:10:16  | 25       | 25       | 60.00       | 1             |
	| 8        | 102         | 2         | 2      | Meh                                                                              | 2020-01-09 23:54:33 | 2020-01-10 00:15:02 | 00:20:29  | 23.4     | 15       | 93.60       | 1             |
	| 9        | 103         | 2         | NULL   | NULL                                                                             | 2020-01-10 11:22:59 | NULL                | NULL      | NULL     | NULL     | NULL        | NULL          |
	| 10       | 104         | 1         | 3      | Nothing spectacular, but good                                                    | 2020-01-11 18:34:49 | 2020-01-11 18:50:20 | 00:15:31  | 10       | 10       | 60.00       | 2             |

5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

		WITH revenue AS (
		SELECT
			tco.order_id,
			runner_id,
			rating,
			order_time,
			pickup_time,
			distance::NUMERIC,
			duration::NUMERIC,
			SUM(CASE WHEN tco.pizza_id = 1 THEN 1 ELSE 0 END) AS meatlovers_count,
			SUM(CASE WHEN tco.pizza_id = 2 THEN 1 ELSE 0 END) AS vegetarian_count
		FROM temp_customer_orders tco 
		JOIN temp_runner_orders tro ON tco.order_id=tro.order_id
		JOIN ratings r ON tco.order_id=r.order_id
		WHERE pickup_time IS NOT NULL
		GROUP BY 1,2,3,4,5,6,7
		ORDER BY 1,2
		)

		SELECT 
		SUM(12 * meatlovers_count + 10 * vegetarian_count - 0.3 * distance) AS total_revenue
		FROM revenue

	| total_revenue |
	|---------------|
	| 94.44         |

## E. BONUS QUESTION

If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?

	DROP TABLE IF EXISTS temp_pizza_names;
	CREATE TEMP TABLE temp_pizza_names AS
	SELECT * FROM pizza_names;

	INSERT INTO temp_pizza_names
	VALUES
	  (3, 'Supreme');

	DROP TABLE IF EXISTS temp_pizza_recipes;
	CREATE TEMP TABLE temp_pizza_recipes AS
	SELECT * FROM pizza_recipes;

	INSERT INTO temp_pizza_recipes
	SELECT
	  3,
	  STRING_AGG(topping_id::TEXT, ', ')
	FROM pizza_toppings;


	SELECT
	*
	FROM temp_pizza_recipes

| pizza_id | toppings                              |
|----------|---------------------------------------|
| 1        | 1, 2, 3, 4, 5, 6, 8, 10               |
| 2        | 4, 6, 7, 9, 11, 12                    |
| 3        | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 |




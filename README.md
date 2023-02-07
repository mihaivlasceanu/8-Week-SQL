# 8 Week SQL Challenge

Repository containing solutions for the 8 case studies in **[#8WeekSQLChallenge](https://8weeksqlchallenge.com/)**!

## Table of Contents

-   [🍣  Case Study #1 - Danny’s Diner](https://github.com/mihaivlasceanu/8-Week-SQL#-case-study-1-dannys-diner)
-   [🍕  Case Study #2 - Pizza Runner](https://github.com/mihaivlasceanu/8-Week-SQL#-case-study-2-pizza-runner)
-   [🍏  Case Study #3 - Foodie-Fi](https://github.com/mihaivlasceanu/8-Week-SQL#-case-study-3-foodie-fi)
-   [🏦  Case Study #4 - Data Bank](https://github.com/mihaivlasceanu/8-Week-SQL#-case-study-4-data-bank)
-   [🏬  Case Study #5 - Data Mart](https://github.com/mihaivlasceanu/8-Week-SQL#-case-study-5-data-mart)
-   [💻  Case Study #6 - Clique Bait](https://github.com/mihaivlasceanu/8-Week-SQL#-case-study-6-clique-bait)
-   [👕  Case Study #7 - Balanced Tree](https://github.com/mihaivlasceanu/8-Week-SQL#-case-study-7---balanced-tree)
-   [🍅  Case Study #8 - Fresh Segments](https://github.com/mihaivlasceanu/8-Week-SQL#-case-study-8-fresh-segments)

## 🍣 Case Study #1: Danny's Diner 
![Danny's Diner logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%201.png)

### Introduction

Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

### Problem Statement

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

### Available Data

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

### Entity Relationship Diagram

![Danny's Diner ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%201%20ERD.png)

<details>
<summary>Datasets</summary>

Danny has shared with you 3 key datasets for this case study:

-   `sales`
-   `menu`
-   `members`

### Table 1: sales

The  `sales`  table captures all  `customer_id`  level purchases with an corresponding  `order_date`  and  `product_id`  information for when and what menu items were ordered.

| customer_id | order_date | product_id |
|-------------|------------|------------|
| A           | 2021-01-01 | 1          |
| A           | 2021-01-01 | 2          |
| A           | 2021-01-07 | 2          |
| A           | 2021-01-10 | 3          |
| A           | 2021-01-11 | 3          |
| A           | 2021-01-11 | 3          |
| B           | 2021-01-01 | 2          |
| B           | 2021-01-02 | 2          |
| B           | 2021-01-04 | 1          |
| B           | 2021-01-11 | 1          |
| B           | 2021-01-16 | 3          |
| B           | 2021-02-01 | 3          |
| C           | 2021-01-01 | 3          |
| C           | 2021-01-01 | 3          |
| C           | 2021-01-07 | 3          |

### Table 2: menu

The  `menu`  table maps the  `product_id`  to the actual  `product_name`  and  `price`  of each menu item.

| product_id | product_name | price |
|------------|--------------|-------|
| 1          | sushi        | 10    |
| 2          | curry        | 15    |
| 3          | ramen        | 12    |

### Table 3: members

The final  `members`  table captures the  `join_date`  when a  `customer_id`  joined the beta version of the Danny’s Diner loyalty program.

| customer_id | join_date  |
|-------------|------------|
| A           | 2021-01-07 |
| B           | 2021-01-09 |

</details>

### Questions and Solutions

<details>
<summary>Questions</summary>

Each of the following case study questions can be answered using a single SQL statement:

1.  What is the total amount each customer spent at the restaurant?
2.  How many days has each customer visited the restaurant?
3.  What was the first item from the menu purchased by each customer?
4.  What is the most purchased item on the menu and how many times was it purchased by all customers?
5.  Which item was the most popular for each customer?
6.  Which item was purchased first by the customer after they became a member?
7.  Which item was purchased just before the customer became a member?
8.  What is the total items and amount spent for each member before they became a member?
9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10.  In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

### Bonus Questions

### Join All The Things

The following questions are related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.

11.  Recreate the following table output using the available data:

| customer_id | order_date | product_name | price | member |
|-------------|------------|--------------|-------|--------|
| A           | 2021-01-01 | curry        | 15    | N      |
| A           | 2021-01-01 | sushi        | 10    | N      |
| A           | 2021-01-07 | curry        | 15    | Y      |
| A           | 2021-01-10 | ramen        | 12    | Y      |
| A           | 2021-01-11 | ramen        | 12    | Y      |
| A           | 2021-01-11 | ramen        | 12    | Y      |
| B           | 2021-01-01 | curry        | 15    | N      |
| B           | 2021-01-02 | curry        | 15    | N      |
| B           | 2021-01-04 | sushi        | 10    | N      |
| B           | 2021-01-11 | sushi        | 10    | Y      |
| B           | 2021-01-16 | ramen        | 12    | Y      |
| B           | 2021-02-01 | ramen        | 12    | Y      |
| C           | 2021-01-01 | ramen        | 12    | N      |
| C           | 2021-01-01 | ramen        | 12    | N      |
| C           | 2021-01-07 | ramen        | 12    | N      |


### Rank All The Things

12.  Danny also requires further information about the  `ranking`  of customer products, but he purposely does not need the ranking for non-member purchases so he expects null  `ranking`  values for the records when customers are not yet part of the loyalty program.

| customer_id | order_date | product_name | price | member | ranking |
|-------------|------------|--------------|-------|--------|---------|
| A           | 2021-01-01 | curry        | 15    | N      | null    |
| A           | 2021-01-01 | sushi        | 10    | N      | null    |
| A           | 2021-01-07 | curry        | 15    | Y      | 1       |
| A           | 2021-01-10 | ramen        | 12    | Y      | 2       |
| A           | 2021-01-11 | ramen        | 12    | Y      | 3       |
| A           | 2021-01-11 | ramen        | 12    | Y      | 3       |
| B           | 2021-01-01 | curry        | 15    | N      | null    |
| B           | 2021-01-02 | curry        | 15    | N      | null    |
| B           | 2021-01-04 | sushi        | 10    | N      | null    |
| B           | 2021-01-11 | sushi        | 10    | Y      | 1       |
| B           | 2021-01-16 | ramen        | 12    | Y      | 2       |
| B           | 2021-02-01 | ramen        | 12    | Y      | 3       |
| C           | 2021-01-01 | ramen        | 12    | N      | null    |
| C           | 2021-01-01 | ramen        | 12    | N      | null    |
| C           | 2021-01-07 | ramen        | 12    | N      | null    |
</details>

To view solutions, [click here](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%231%20-%20Danny's%20Diner).

## 🍕 Case Study #2: Pizza Runner
![Pizza Runner logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%202.png)

### Introduction

Did you know that over  **115 million kilograms**  of pizza is consumed daily worldwide??? (Well according to Wikipedia anyway…)

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to  _Uberize_  it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

### Available Data

Because Danny had a few years of experience as a data scientist - he was very aware that data collection was going to be critical for his business’ growth.

He has prepared for us an entity relationship diagram of his database design but requires further assistance to clean his data and apply some basic calculations so he can better direct his runners and optimise Pizza Runner’s operations.

### Entity Relationship Diagram

![Pizza Runner ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%202%20ERD.png)

<details>
<summary>Datasets</summary>

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

</details>


### Questions and Solutions

<details>
<summary>Questions</summary>

This case study has  **LOTS**  of questions - they are broken up by area of focus including: * Pizza Metrics * Runner and Customer Experience * Ingredient Optimisation * Pricing and Ratings * Bonus DML Challenges (DML = Data Manipulation Language)

Each of the following case study questions can be answered using a single SQL statement.

Again, there are many questions in this case study - please feel free to pick and choose which ones you’d like to try!

Before you start writing your SQL queries however - you might want to investigate the data, you may want to do something with some of those  `null`  values and data types in the  `customer_orders`  and  `runner_orders`  tables!

### A. Pizza Metrics

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

### B. Runner and Customer Experience

1.  How many runners signed up for each 1 week period? (i.e. week starts  `2021-01-01`)
2.  What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
3.  Is there any relationship between the number of pizzas and how long the order takes to prepare?
4.  What was the average distance travelled for each customer?
5.  What was the difference between the longest and shortest delivery times for all orders?
6.  What was the average speed for each runner for each delivery and do you notice any trend for these values?
7.  What is the successful delivery percentage for each runner?

### C. Ingredient Optimisation

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

### D. Pricing and Ratings

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

### E. Bonus Questions

If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an  `INSERT`  statement to demonstrate what would happen if a new  `Supreme`  pizza with all the toppings was added to the Pizza Runner menu?
</details>

To view solutions, [click here](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%232%20-%20Pizza%20Runner).

## 🍏 Case Study #3: Foodie-Fi
![Foodie-Fi logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%203.png)

### Introduction

Subscription based businesses are super popular and Danny realised that there was a large gap in the market - he wanted to create a new streaming service that only had food related content - something like Netflix but with only cooking shows!

Danny finds a few smart friends to launch his new startup Foodie-Fi in 2020 and started selling monthly and annual subscriptions, giving their customers unlimited on-demand access to exclusive food videos from around the world!

Danny created Foodie-Fi with a data driven mindset and wanted to ensure all future investment decisions and new features were decided using data. This case study focuses on using subscription style digital data to answer important business questions.

### Available Data

Danny has shared the data design for Foodie-Fi and also short descriptions on each of the database tables - our case study focuses on only 2 tables but there will be a challenge to create a new table for the Foodie-Fi team.

### Entity Relationship Diagram

![Foodie-Fi ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%203%20ERD.png)

<details>
<summary>Datasets</summary>

### Table 1: plans

Customers can choose which plans to join Foodie-Fi when they first sign up.

Basic plan customers have limited access and can only stream their videos and is only available monthly at $9.90

Pro plan customers have no watch time limits and are able to download videos for offline viewing. Pro plans start at $19.90 a month or $199 for an annual subscription.

Customers can sign up to an initial 7 day free trial will automatically continue with the pro monthly subscription plan unless they cancel, downgrade to basic or upgrade to an annual pro plan at any point during the trial.

When customers cancel their Foodie-Fi service - they will have a  `churn`  plan record with a  `null`  price but their plan will continue until the end of the billing period.

| plan_id | plan_name     | price |
|---------|---------------|-------|
| 0       | trial         | 0     |
| 1       | basic monthly | 9.90  |
| 2       | pro monthly   | 19.90 |
| 3       | pro annual    | 199   |
| 4       | churn         | null  |

### Table 2: subscriptions

Customer subscriptions show the exact date where their specific  `plan_id`  starts.

If customers downgrade from a pro plan or cancel their subscription - the higher plan will remain in place until the period is over - the  `start_date`  in the  `subscriptions`  table will reflect the date that the actual plan changes.

When customers upgrade their account from a basic plan to a pro or annual pro plan - the higher plan will take effect straightaway.

When customers churn - they will keep their access until the end of their current billing period but the  `start_date`  will be technically the day they decided to cancel their service.

| customer_id | plan_id | start_date |
|-------------|---------|------------|
| 1           | 0       | 2020-08-01 |
| 1           | 1       | 2020-08-08 |
| 2           | 0       | 2020-09-20 |
| 2           | 3       | 2020-09-27 |
| 11          | 0       | 2020-11-19 |
| 11          | 4       | 2020-11-26 |
| 13          | 0       | 2020-12-15 |
| 13          | 1       | 2020-12-22 |
| 13          | 2       | 2021-03-29 |
| 15          | 0       | 2020-03-17 |
| 15          | 2       | 2020-03-24 |
| 15          | 4       | 2020-04-29 |
| 16          | 0       | 2020-05-31 |
| 16          | 1       | 2020-06-07 |
| 16          | 3       | 2020-10-21 |
| 18          | 0       | 2020-07-06 |
| 18          | 2       | 2020-07-13 |
| 19          | 0       | 2020-06-22 |
| 19          | 2       | 2020-06-29 |
| 19          | 3       | 2020-08-29 |

</details>

### Questions and Solutions

<details>
<summary>Questions</summary>

This case study is split into an initial data understanding question before diving straight into data analysis questions before finishing with 1 single extension challenge.

## A. Customer Journey

Based off the 8 sample customers provided in the sample from the  `subscriptions`  table, write a brief description about each customer’s onboarding journey.

Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!

## B. Data Analysis Questions

1.  How many customers has Foodie-Fi ever had?
2.  What is the monthly distribution of  `trial`  plan  `start_date`  values for our dataset - use the start of the month as the group by value
3.  What plan  `start_date`  values occur after the year 2020 for our dataset? Show the breakdown by count of events for each  `plan_name`
4.  What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
5.  How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
6.  What is the number and percentage of customer plans after their initial free trial?
7.  What is the customer count and percentage breakdown of all 5  `plan_name`  values at  `2020-12-31`?
8.  How many customers have upgraded to an annual plan in 2020?
9.  How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
10.  Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
11.  How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

## C. Challenge Payment Question

The Foodie-Fi team wants you to create a new  `payments`  table for the year 2020 that includes amounts paid by each customer in the  `subscriptions`  table with the following requirements:

-   monthly payments always occur on the same day of month as the original  `start_date`  of any monthly paid plan
-   upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately
-   upgrades from pro monthly to pro annual are paid at the end of the current billing period and also starts at the end of the month period
-   once a customer churns they will no longer make payments

Example outputs for this table might look like the following:

| customer_id | plan_id | plan_name     | payment_date | amount | payment_order |
|-------------|---------|---------------|--------------|--------|---------------|
| 1           | 1       | basic monthly | 2020-08-08   | 9.90   | 1             |
| 1           | 1       | basic monthly | 2020-09-08   | 9.90   | 2             |
| 1           | 1       | basic monthly | 2020-10-08   | 9.90   | 3             |
| 1           | 1       | basic monthly | 2020-11-08   | 9.90   | 4             |
| 1           | 1       | basic monthly | 2020-12-08   | 9.90   | 5             |
| 2           | 3       | pro annual    | 2020-09-27   | 199.00 | 1             |
| 7           | 1       | basic monthly | 2020-02-12   | 9.90   | 1             |
| 7           | 1       | basic monthly | 2020-03-12   | 9.90   | 2             |
| 7           | 1       | basic monthly | 2020-04-12   | 9.90   | 3             |
| 7           | 1       | basic monthly | 2020-05-12   | 9.90   | 4             |
| 7           | 2       | pro monthly   | 2020-05-22   | 10.00  | 5             |
| 7           | 2       | pro monthly   | 2020-06-22   | 19.90  | 6             |
| 7           | 2       | pro monthly   | 2020-07-22   | 19.90  | 7             |
| 7           | 2       | pro monthly   | 2020-08-22   | 19.90  | 8             |
| 7           | 2       | pro monthly   | 2020-09-22   | 19.90  | 9             |
| 7           | 2       | pro monthly   | 2020-10-22   | 19.90  | 10            |
| 7           | 2       | pro monthly   | 2020-11-22   | 19.90  | 11            |
| 7           | 2       | pro monthly   | 2020-12-22   | 19.90  | 12            |
| 13          | 1       | basic monthly | 2020-12-22   | 9.90   | 1             |
| 15          | 2       | pro monthly   | 2020-03-24   | 19.90  | 1             |
| 15          | 2       | pro monthly   | 2020-04-24   | 19.90  | 2             |
| 16          | 1       | basic monthly | 2020-06-07   | 9.90   | 1             |
| 16          | 1       | basic monthly | 2020-07-07   | 9.90   | 2             |
| 16          | 1       | basic monthly | 2020-08-07   | 9.90   | 3             |
| 16          | 1       | basic monthly | 2020-09-07   | 9.90   | 4             |
| 16          | 1       | basic monthly | 2020-10-07   | 9.90   | 5             |
| 16          | 3       | pro annual    | 2020-10-21   | 189.10 | 6             |
| 18          | 2       | pro monthly   | 2020-07-13   | 19.90  | 1             |
| 18          | 2       | pro monthly   | 2020-08-13   | 19.90  | 2             |
| 18          | 2       | pro monthly   | 2020-09-13   | 19.90  | 3             |
| 18          | 2       | pro monthly   | 2020-10-13   | 19.90  | 4             |
| 18          | 2       | pro monthly   | 2020-11-13   | 19.90  | 5             |
| 18          | 2       | pro monthly   | 2020-12-13   | 19.90  | 6             |
| 19          | 2       | pro monthly   | 2020-06-29   | 19.90  | 1             |
| 19          | 2       | pro monthly   | 2020-07-29   | 19.90  | 2             |
| 19          | 3       | pro annual    | 2020-08-29   | 199.00 | 3             |
| 25          | 1       | basic monthly | 2020-05-17   | 9.90   | 1             |
| 25          | 2       | pro monthly   | 2020-06-16   | 10.00  | 2             |
| 25          | 2       | pro monthly   | 2020-07-16   | 19.90  | 3             |
| 25          | 2       | pro monthly   | 2020-08-16   | 19.90  | 4             |
| 25          | 2       | pro monthly   | 2020-09-16   | 19.90  | 5             |
| 25          | 2       | pro monthly   | 2020-10-16   | 19.90  | 6             |
| 25          | 2       | pro monthly   | 2020-11-16   | 19.90  | 7             |
| 25          | 2       | pro monthly   | 2020-12-16   | 19.90  | 8             |
| 39          | 1       | basic monthly | 2020-06-04   | 9.90   | 1             |
| 39          | 1       | basic monthly | 2020-07-04   | 9.90   | 2             |
| 39          | 1       | basic monthly | 2020-08-04   | 9.90   | 3             |
| 39          | 2       | pro monthly   | 2020-08-25   | 10.00  | 4             |

## D. Outside The Box Questions

The following are open ended questions which might be asked during a technical interview for this case study - there are no right or wrong answers, but answers that make sense from both a technical and a business perspective make an amazing impression!

1.  How would you calculate the rate of growth for Foodie-Fi?
2.  What key metrics would you recommend Foodie-Fi management to track over time to assess performance of their overall business?
3.  What are some key customer journeys or experiences that you would analyse further to improve customer retention?
4.  If the Foodie-Fi team were to create an exit survey shown to customers who wish to cancel their subscription, what questions would you include in the survey?
5.  What business levers could the Foodie-Fi team use to reduce the customer churn rate? How would you validate the effectiveness of your ideas?

</details>

To view solutions, [click here](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%233%20-%20Foodie-Fi).

## 🏦 Case Study #4: Data Bank
![Data Bank logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%204.png)

### Introduction

There is a new innovation in the financial industry called Neo-Banks: new aged digital only banks without physical branches.

Danny thought that there should be some sort of intersection between these new age banks, cryptocurrency and the data world…so he decides to launch a new initiative - Data Bank!

Data Bank runs just like any other digital bank - but it isn’t only for banking activities, they also have the world’s most secure distributed data storage platform!

Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. There are a few interesting caveats that go with this business model, and this is where the Data Bank team need your help!

The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.

This case study is all about calculating metrics, growth and helping the business analyse their data in a smart way to better forecast and plan for their future developments!

### Available Data

The Data Bank team have prepared a data model for this case study as well as a few example rows from the complete dataset below to get you familiar with their tables.

### Entity Relationship Diagram

![Data Bank ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%204%20ERD.png)

<details>
<summary>Datasets</summary>

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

</details>

### Questions and Solutions
<details>
<summary>Questions</summary>

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
</details>

To view solutions, [click here](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%234%20-%20Data%20Bank).

## 🏬 Case Study #5: Data Mart
![Data Mart logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%205.png)

### Introduction

Data Mart is Danny’s latest venture and after running international operations for his online supermarket that specialises in fresh produce - Danny is asking for your support to analyse his sales performance.

In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.

Danny needs your help to quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.

The key business question he wants you to help him answer are the following:

-   What was the quantifiable impact of the changes introduced in June 2020?
-   Which platform, region, segment and customer types were the most impacted by this change?
-   What can we do about future introduction of similar sustainability updates to the business to minimise impact on sales?

### Available Data

For this case study there is only a single table:  `data_mart.weekly_sales`

The  `Entity Relationship Diagram`  is shown below with the data types made clear, please note that there is only this one table - hence why it looks a little bit lonely!

![Data Mart ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%205%20ERD.png)

### Column Dictionary

The columns are pretty self-explanatory based on the column names but here are some further details about the dataset:

1.  Data Mart has international operations using a multi-`region`  strategy
2.  Data Mart has both, a retail and online  `platform`  in the form of a Shopify store front to serve their customers
3.  Customer  `segment`  and  `customer_type`  data relates to personal age and demographics information that is shared with Data Mart
4.  `transactions`  is the count of unique purchases made through Data Mart and  `sales`  is the actual dollar amount of purchases

Each record in the dataset is related to a specific aggregated slice of the underlying sales data rolled up into a  `week_date`  value which represents the start of the sales week.

<details>
<summary>Dataset</summary>

10 random rows are shown in the table output below from  `data_mart.weekly_sales`:

| week_date | region        | platform | segment | customer_type | transactions | sales      |
|-----------|---------------|----------|---------|---------------|--------------|------------|
| 9/9/20    | OCEANIA       | Shopify  | C3      | New           | 610          | 110033.89  |
| 29/7/20   | AFRICA        | Retail   | C1      | New           | 110692       | 3053771.19 |
| 22/7/20   | EUROPE        | Shopify  | C4      | Existing      | 24           | 8101.54    |
| 13/5/20   | AFRICA        | Shopify  | null    | Guest         | 5287         | 1003301.37 |
| 24/7/19   | ASIA          | Retail   | C1      | New           | 127342       | 3151780.41 |
| 10/7/19   | CANADA        | Shopify  | F3      | New           | 51           | 8844.93    |
| 26/6/19   | OCEANIA       | Retail   | C3      | New           | 152921       | 5551385.36 |
| 29/5/19   | SOUTH AMERICA | Shopify  | null    | New           | 53           | 10056.2    |
| 22/8/18   | AFRICA        | Retail   | null    | Existing      | 31721        | 1718863.58 |
| 25/7/18   | SOUTH AMERICA | Retail   | null    | New           | 2136         | 81757.91   |

</details>

### Questions and Solutions
<details>
<summary>Questions</summary>

The following case study questions require some data cleaning steps before we start to unpack Danny’s key business questions in more depth.

### A. Data Cleansing Steps

In a single query, perform the following operations and generate a new table in the  `data_mart`  schema named  `clean_weekly_sales`:

-   Convert the  `week_date`  to a  `DATE`  format
    
-   Add a  `week_number`  as the second column for each  `week_date`  value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc
    
-   Add a  `month_number`  with the calendar month for each  `week_date`  value as the 3rd column
    
-   Add a  `calendar_year`  column as the 4th column containing either 2018, 2019 or 2020 values
    
-   Add a new column called  `age_band`  after the original  `segment`  column using the following mapping on the number inside the  `segment`  value

	|  segment | age_band     |
	|---------|--------------|
	|  1       | Young Adults |
	|  2       | Middle Aged  |
	|  3 or 4  | Retirees     |

-   Add a new  `demographic`  column using the following mapping for the first letter in the  `segment`  values:

	segment | demographic |  
	C | Couples |  
	F | Families |

-   Ensure all  `null`  string values with an  `"unknown"`  string value in the original  `segment`  column as well as the new  `age_band`  and  `demographic`  columns
    
-   Generate a new  `avg_transaction`  column as the  `sales`  value divided by  `transactions`  rounded to 2 decimal places for each record

### B. Data Exploration

1.  What day of the week is used for each  `week_date`  value?
2.  What range of week numbers are missing from the dataset?
3.  How many total transactions were there for each year in the dataset?
4.  What is the total sales for each region for each month?
5.  What is the total count of transactions for each platform
6.  What is the percentage of sales for Retail vs Shopify for each month?
7.  What is the percentage of sales by demographic for each year in the dataset?
8.  Which  `age_band`  and  `demographic`  values contribute the most to Retail sales?
9.  Can we use the  `avg_transaction`  column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?

### C. Before & After Analysis

This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.

Taking the  `week_date`  value of  `2020-06-15`  as the baseline week where the Data Mart sustainable packaging changes came into effect.

We would include all  `week_date`  values for  `2020-06-15`  as the start of the period  **after**  the change and the previous  `week_date`  values would be  **before**

Using this analysis approach - answer the following questions:

1.  What is the total sales for the 4 weeks before and after  `2020-06-15`? What is the growth or reduction rate in actual values and percentage of sales?
2.  What about the entire 12 weeks before and after?
3.  How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

### D. Bonus Question

Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?

-   `region`
-   `platform`
-   `age_band`
-   `demographic`
-   `customer_type`

Do you have any further recommendations for Danny’s team at Data Mart or any interesting insights based off this analysis?
</details>

To view solutions, [click here](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%235%20-%20Data%20Mart).

## 💻 Case Study #6: Clique Bait
![Clique Bait logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%206.png)

### Introduction

Clique Bait is not like your regular online seafood store - the founder and CEO Danny, was also a part of a digital data analytics team and wanted to expand his knowledge into the seafood industry!

In this case study - you are required to support Danny’s vision and analyse his dataset and come up with creative solutions to calculate funnel fallout rates for the Clique Bait online store.

### Available Data

For this case study there is a total of 5 datasets which you will need to combine to solve all of the questions.

<details>
<summary>Datasets</summary>

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

</details>

### Questions and Solutions
<details>
<summary>Questions</summary>

### A. Enterprise Relationship Diagram

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
### B. Digital Analysis

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

### C. Product Funnel Analysis

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

### D. Campaigns Analysis

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

</details>

To view solutions, [click here](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%236%20-%20Clique%20Bait).

## 👕 Case Study #7 - Balanced Tree
![Balanced Tree logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%207.png)

### Introduction

Balanced Tree Clothing Company prides themselves on providing an optimised range of clothing and lifestyle wear for the modern adventurer!

Danny, the CEO of this trendy fashion company has asked you to assist the team’s merchandising teams analyse their sales performance and generate a basic financial report to share with the wider business.

### Available Data

For this case study there is a total of 4 datasets for this case study - however you will only need to utilise 2 main tables to solve all of the regular questions, and the additional 2 tables are used only for the bonus challenge question!

<details>
<summary>Datasets</summary>

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

</details>

### Questions and Solutions

<details>
<summary>Questions</summary>

The following questions can be considered key business questions and metrics that the Balanced Tree team requires for their monthly reports.

Each question can be answered using a single query - but as you are writing the SQL to solve each individual problem, keep in mind how you would generate all of these metrics in a single SQL script which the Balanced Tree team can run each month.

### A. High Level Sales Analysis

1.  What was the total quantity sold for all products?
2.  What is the total generated revenue for all products before discounts?
3.  What was the total discount amount for all products?

### B. Transaction Analysis

1.  How many unique transactions were there?
2.  What is the average unique products purchased in each transaction?
3.  What are the 25th, 50th and 75th percentile values for the revenue per transaction?
4.  What is the average discount value per transaction?
5.  What is the percentage split of all transactions for members vs non-members?
6.  What is the average revenue for member transactions and non-member transactions?

### C. Product Analysis

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

### D. Bonus Challenge

Use a single SQL query to transform the  `product_hierarchy`  and  `product_prices`  datasets to the  `product_details`  table.

Hint: you may want to consider using a recursive CTE to solve this problem!
</details>

To view solutions, [click here](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%237%20-%20Balanced%20Tree).

## 🍅 Case Study #8: Fresh Segments
![Fresh Segments logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%208.png)

### Introduction

Danny created Fresh Segments, a digital marketing agency that helps other businesses analyse trends in online ad click behaviour for their unique customer base.

Clients share their customer lists with the Fresh Segments team who then aggregate interest metrics and generate a single dataset worth of metrics for further analysis.

In particular - the composition and rankings for different interests are provided for each client showing the proportion of their customer list who interacted with online assets related to each interest for each month.

Danny has asked for your assistance to analyse aggregated metrics for an example client and provide some high level insights about the customer list and their interests.

### Available Data

For this case study there is a total of 2 datasets which you will need to use to solve the questions.

<details>
<summary>Datasets</summary>

### Table 1: Interest Metrics

This table contains information about aggregated interest metrics for a specific major client of Fresh Segments which makes up a large proportion of their customer base.

Each record in this table represents the performance of a specific  `interest_id`  based on the client’s customer base interest measured through clicks and interactions with specific targeted advertising content.

| _month | _year | month_year | interest_id | composition | index_value | ranking | percentile_ranking |
|--------|-------|------------|-------------|-------------|-------------|---------|--------------------|
| 7      | 2018  | 07-2018    | 32486       | 11.89       | 6.19        | 1       | 99.86              |
| 7      | 2018  | 07-2018    | 6106        | 9.93        | 5.31        | 2       | 99.73              |
| 7      | 2018  | 07-2018    | 18923       | 10.85       | 5.29        | 3       | 99.59              |
| 7      | 2018  | 07-2018    | 6344        | 10.32       | 5.1         | 4       | 99.45              |
| 7      | 2018  | 07-2018    | 100         | 10.77       | 5.04        | 5       | 99.31              |
| 7      | 2018  | 07-2018    | 69          | 10.82       | 5.03        | 6       | 99.18              |
| 7      | 2018  | 07-2018    | 79          | 11.21       | 4.97        | 7       | 99.04              |
| 7      | 2018  | 07-2018    | 6111        | 10.71       | 4.83        | 8       | 98.9               |
| 7      | 2018  | 07-2018    | 6214        | 9.71        | 4.83        | 8       | 98.9               |
| 7      | 2018  | 07-2018    | 19422       | 10.11       | 4.81        | 10      | 98.63              |

For example - let’s interpret the first row of the `interest_metrics` table together:

| _month | _year | month_year | interest_id | composition | index_value | ranking | percentile_ranking |
|--------|-------|------------|-------------|-------------|-------------|---------|--------------------|
| 7      | 2018  | 07-2018    | 32486       | 11.89       | 6.19        | 1       | 99.86              |

In July 2018, the  `composition`  metric is 11.89, meaning that 11.89% of the client’s customer list interacted with the interest  `interest_id = 32486`  - we can link  `interest_id`  to a separate mapping table to find the segment name called “Vacation Rental Accommodation Researchers”

The  `index_value`  is 6.19, means that the  `composition`  value is 6.19x the average composition value for all Fresh Segments clients’ customer for this particular interest in the month of July 2018.

The  `ranking`  and  `percentage_ranking`  relates to the order of  `index_value`  records in each month year.

### Table 2: Interest Map

This mapping table links the  `interest_id`  with their relevant interest information. You will need to join this table onto the previous  `interest_details`  table to obtain the  `interest_name`  as well as any details about the summary information.

| id | interest_name             | interest_summary                                                                   | created_at          | last_modified       |
|----|---------------------------|------------------------------------------------------------------------------------|---------------------|---------------------|
| 1  | Fitness Enthusiasts       | Consumers using fitness tracking apps and websites.                                | 2016-05-26 14:57:59 | 2018-05-23 11:30:12 |
| 2  | Gamers                    | Consumers researching game reviews and cheat codes.                                | 2016-05-26 14:57:59 | 2018-05-23 11:30:12 |
| 3  | Car Enthusiasts           | Readers of automotive news and car reviews.                                        | 2016-05-26 14:57:59 | 2018-05-23 11:30:12 |
| 4  | Luxury Retail Researchers | Consumers researching luxury product reviews and gift ideas.                       | 2016-05-26 14:57:59 | 2018-05-23 11:30:12 |
| 5  | Brides & Wedding Planners | People researching wedding ideas and vendors.                                      | 2016-05-26 14:57:59 | 2018-05-23 11:30:12 |
| 6  | Vacation Planners         | Consumers reading reviews of vacation destinations and accommodations.             | 2016-05-26 14:57:59 | 2018-05-23 11:30:13 |
| 7  | Motorcycle Enthusiasts    | Readers of motorcycle news and reviews.                                            | 2016-05-26 14:57:59 | 2018-05-23 11:30:13 |
| 8  | Business News Readers     | Readers of online business news content.                                           | 2016-05-26 14:57:59 | 2018-05-23 11:30:12 |
| 12 | Thrift Store Shoppers     | Consumers shopping online for clothing at thrift stores and researching locations. | 2016-05-26 14:57:59 | 2018-03-16 13:14:00 |
| 13 | Advertising Professionals | People who read advertising industry news.                                         | 2016-05-26 14:57:59 | 2018-05-23 11:30:12 |

</details>

### Questions and Solutions

<details>
<summary>Questions</summary>

The following questions can be considered key business questions that are required to be answered for the Fresh Segments team.

Most questions can be answered using a single query however some questions are more open ended and require additional thought and not just a coded solution!

### A. Data Exploration and Cleansing

1.  Update the  `fresh_segments.interest_metrics`  table by modifying the  `month_year`  column to be a date data type with the start of the month
2.  What is count of records in the  `fresh_segments.interest_metrics`  for each  `month_year`  value sorted in chronological order (earliest to latest) with the null values appearing first?
3.  What do you think we should do with these null values in the  `fresh_segments.interest_metrics`
4.  How many  `interest_id`  values exist in the  `fresh_segments.interest_metrics`  table but not in the  `fresh_segments.interest_map`  table? What about the other way around?
5.  Summarise the  `id`  values in the  `fresh_segments.interest_map`  by its total record count in this table
6.  What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where  `interest_id = 21246`  in your joined output and include all columns from  `fresh_segments.interest_metrics`  and all columns from  `fresh_segments.interest_map`  except from the  `id`  column.
7.  Are there any records in your joined table where the  `month_year`  value is before the  `created_at`  value from the  `fresh_segments.interest_map`  table? Do you think these values are valid and why?

### B. Interest Analysis

1.  Which interests have been present in all  `month_year`  dates in our dataset?
2.  Using this same  `total_months`  measure - calculate the cumulative percentage of all records starting at 14 months - which  `total_months`  value passes the 90% cumulative percentage value?
3.  If we were to remove all  `interest_id`  values which are lower than the  `total_months`  value we found in the previous question - how many total data points would we be removing?
4.  Does this decision make sense to remove these data points from a business perspective? Use an example where there are all 14 months present to a removed  `interest`  example for your arguments - think about what it means to have less months present from a segment perspective. > 5. If we include all of our interests regardless of their counts - how many unique interests are there for each month?

### C. Segment Analysis

1.  Using the complete dataset - which are the top 10 and bottom 10 interests which have the largest composition values in any  `month_year`? Only use the maximum composition value for each interest but you must keep the corresponding  `month_year`
2.  Which 5 interests had the lowest average  `ranking`  value?
3.  Which 5 interests had the largest standard deviation in their  `percentile_ranking`  value?
4.  For the 5 interests found in the previous question - what was minimum and maximum  `percentile_ranking`  values for each interest and its corresponding  `year_month`  value? Can you describe what is happening for these 5 interests?
5.  How would you describe our customers in this segment based off their composition and ranking values? What sort of products or services should we show to these customers and what should we avoid?

### D. Index Analysis

The  `index_value`  is a measure which can be used to reverse calculate the average composition for Fresh Segments’ clients.

Average composition can be calculated by dividing the  `composition`  column by the  `index_value`  column rounded to 2 decimal places.

1.  What is the top 10 interests by the average composition for each month?
2.  For all of these top 10 interests - which interest appears the most often?
3.  What is the average of the average composition for the top 10 interests for each month?
4.  What is the 3 month rolling average of the max average composition value from September 2018 to August 2019 and include the previous top ranking interests in the same output shown below.
5.  Provide a possible reason why the max average composition might change from month to month? Could it signal something is not quite right with the overall business model for Fresh Segments?

Required output for question 4:

| month_year | interest_name                 | max_index_composition | 3_month_moving_avg | 1_month_ago                       | 2_months_ago                      |
|------------|-------------------------------|-----------------------|--------------------|-----------------------------------|-----------------------------------|
| 2018-09-01 | Work Comes First Travelers    | 8.26                  | 7.61               | Las Vegas Trip Planners: 7.21     | Las Vegas Trip Planners: 7.36     |
| 2018-10-01 | Work Comes First Travelers    | 9.14                  | 8.20               | Work Comes First Travelers: 8.26  | Las Vegas Trip Planners: 7.21     |
| 2018-11-01 | Work Comes First Travelers    | 8.28                  | 8.56               | Work Comes First Travelers: 9.14  | Work Comes First Travelers: 8.26  |
| 2018-12-01 | Work Comes First Travelers    | 8.31                  | 8.58               | Work Comes First Travelers: 8.28  | Work Comes First Travelers: 9.14  |
| 2019-01-01 | Work Comes First Travelers    | 7.66                  | 8.08               | Work Comes First Travelers: 8.31  | Work Comes First Travelers: 8.28  |
| 2019-02-01 | Work Comes First Travelers    | 7.66                  | 7.88               | Work Comes First Travelers: 7.66  | Work Comes First Travelers: 8.31  |
| 2019-03-01 | Alabama Trip Planners         | 6.54                  | 7.29               | Work Comes First Travelers: 7.66  | Work Comes First Travelers: 7.66  |
| 2019-04-01 | Solar Energy Researchers      | 6.28                  | 6.83               | Alabama Trip Planners: 6.54       | Work Comes First Travelers: 7.66  |
| 2019-05-01 | Readers of Honduran Content   | 4.41                  | 5.74               | Solar Energy Researchers: 6.28    | Alabama Trip Planners: 6.54       |
| 2019-06-01 | Las Vegas Trip Planners       | 2.77                  | 4.49               | Readers of Honduran Content: 4.41 | Solar Energy Researchers: 6.28    |
| 2019-07-01 | Las Vegas Trip Planners       | 2.82                  | 3.33               | Las Vegas Trip Planners: 2.77     | Readers of Honduran Content: 4.41 |
| 2019-08-01 | Cosmetics and Beauty Shoppers | 2.73                  | 2.77               | Las Vegas Trip Planners: 2.82     | Las Vegas Trip Planners: 2.77     |

</details>

To view solutions, [click here](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%238%20-%20Fresh%20Segments).


# Case Study #1 - Danny's Diner
![Danny's Diner Logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%201.png)

## 📚  Table of Contents

-   [📋  Introduction](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#briefcase-business-case)
-   [🔍  Problem Statement](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#mag-entity-relationship-diagram)
-   [📄 Available Data](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#bookmark_tabsexample-datasets)
-   [❓  Case Study Questions](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#triangular_flag_on_post-questions-and-solution)
-  [✔️  Solutions](https://github.com/tfkachmad/8-Week-SQL-Challenge/blob/main/Case-Study-4-Data-Bank/README.md#triangular_flag_on_post-questions-and-solution)

## Introduction

Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

## Problem Statement

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

## Available Data

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

Danny has shared with you 3 key datasets for this case study:

-   `sales`
-   `menu`
-   `members`

You can inspect the entity relationship diagram and example data below.

![Danny's Diner ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%201%20ERD.png)


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

# Case Study Questions

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

# Bonus Questions

## Join All The Things

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


## Rank All The Things

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

# Solutions


**1. What is the total amount each customer spent at the restaurant?**  

	SELECT
	customer_id,
	SUM(price)
	FROM sales s
	JOIN menu m ON s.product_id=m.product_id
	GROUP BY 1
	ORDER BY 1;

| customer_id | sum |
|-------------|-----|
| A           | 76  |
| B           | 74  |
| C           | 36  |

**2. How many days has each customer visited the restaurant?**

	SELECT
	customer_id,
	COUNT(DISTINCT order_date)
	FROM sales
	GROUP BY 1
	ORDER BY 1;

| customer_id | count |
|-------------|-------|
| A           | 4     |
| B           | 6     |
| C           | 2     |

**3. What was the first item from the menu purchased by each customer?**

	WITH first_order AS (
	SELECT 
		sales.customer_id,
		menu.product_name,
		RANK() OVER (PARTITION BY sales.customer_id ORDER BY sales.order_date) AS order_rank
	FROM sales
	JOIN menu ON sales.product_id=menu.product_id
	)

	SELECT DISTINCT
	  customer_id,
	  product_name,
	  order_rank
	FROM first_order
	WHERE order_rank=1;

| customer_id | product_name | order_rank |
|-------------|--------------|------------|
| A           | curry        | 1          |
| A           | sushi        | 1          |
| B           | curry        | 1          |
| C           | ramen        | 1          |

**4. What is the most purchased item on the menu and how many times was it purchased by all customers?**

	SELECT 
	menu.product_name,
	COUNT(product_name) AS times_ordered
	FROM sales
	JOIN menu ON sales.product_id=menu.product_id
	GROUP BY 1
	ORDER BY 2 DESC;

| product_name | times_ordered |
|--------------|---------------|
| ramen        | 8             |
| curry        | 4             |
| sushi        | 3             |

**5. Which item was the most popular for each customer?**

	WITH order_count AS (
	SELECT 
		sales.customer_id,
		menu.product_name,
		COUNT(*) AS times_ordered
	FROM sales
	JOIN menu ON sales.product_id=menu.product_id
	GROUP BY 1,2
	ORDER BY 1,3 DESC
	)

	, order_rank AS (
	SELECT 
		*,
		RANK() OVER (PARTITION BY customer_id ORDER BY times_ordered DESC) AS rank
	FROM order_count
	)

	SELECT *
	FROM order_rank
	WHERE rank=1;

| customer_id | product_name | times_ordered | rank |
|-------------|--------------|---------------|------|
| A           | ramen        | 3             | 1    |
| B           | sushi        | 2             | 1    |
| B           | curry        | 2             | 1    |
| B           | ramen        | 2             | 1    |
| C           | ramen        | 3             | 1    |

**6. Which item was purchased first by the customer after they became a member?**

	WITH sales_members AS (
	SELECT 
		sales.customer_id,
		sales.product_id,
		members.join_date,
		sales.order_date, 
		DENSE_RANK() OVER (PARTITION BY sales.customer_id ORDER BY sales.order_date) as rank
	FROM sales
	JOIN members ON sales.customer_id=members.customer_id
	WHERE join_date <= order_date
	)

	SELECT *
	FROM sales_members
	JOIN menu ON sales_members.product_id=menu.product_id
	WHERE rank=1;

| customer_id | product_id | join_date  | order_date | rank | product_id_2 | product_name | price |
|-------------|------------|------------|------------|------|--------------|--------------|-------|
| B           | 1          | 2021-01-09 | 2021-01-11 | 1    | 1            | sushi        | 10    |
| A           | 2          | 2021-01-07 | 2021-01-07 | 1    | 2            | curry        | 15    |

**7. Which item was purchased just before the customer became a member?**

	WITH sales_members AS (
	SELECT 
		sales.customer_id,
		sales.product_id,
		members.join_date,
		sales.order_date, 
		DENSE_RANK() OVER (PARTITION BY sales.customer_id ORDER BY sales.order_date DESC) AS rank
	FROM sales
	JOIN members ON sales.customer_id=members.customer_id
	WHERE join_date > order_date
	)

	SELECT *
	FROM sales_members
	JOIN menu ON sales_members.product_id=menu.product_id
	WHERE rank=1;

| customer_id | product_id | join_date  | order_date | rank | product_id_2 | product_name | price |
|-------------|------------|------------|------------|------|--------------|--------------|-------|
| B           | 1          | 2021-01-09 | 2021-01-04 | 1    | 1            | sushi        | 10    |
| A           | 1          | 2021-01-07 | 2021-01-01 | 1    | 1            | sushi        | 10    |
| A           | 2          | 2021-01-07 | 2021-01-01 | 1    | 2            | curry        | 15    |

**8. What is the total items and amount spent for each member before they became a member?**

	WITH sales_members AS (
	SELECT 
		sales.customer_id,
		sales.product_id,
		members.join_date,
		sales.order_date
	FROM sales
	JOIN members ON sales.customer_id=members.customer_id
	WHERE join_date > order_date
	)

	SELECT 
	sales_members.customer_id,
	COUNT (*) AS orders,
	SUM(price) AS total_spent
	FROM sales_members
	JOIN menu ON sales_members.product_id=menu.product_id
	GROUP BY 1
	ORDER BY 1;

| customer_id | orders | total_spent |
|-------------|--------|-------------|
| A           | 2      | 25          |
| B           | 3      | 40          |

**9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?**

	WITH points_table AS (
	SELECT 
	    s.customer_id,
		s.product_id,
		m.product_name,
		m.price,
		CASE WHEN m.product_name='sushi' THEN price*20 ELSE price*10 END AS points
	FROM sales s
	JOIN menu m ON s.product_id=m.product_id
	ORDER BY 1
	)
		
	SELECT customer_id,
	SUM(points) AS total_spent
	FROM points_table
	GROUP BY 1
	ORDER BY 1;

| customer_id | total_spent |
|-------------|-------------|
| A           | 860         |
| B           | 940         |
| C           | 360         |

**10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?**

	WITH sales_members AS (
	SELECT 	
		sales.customer_id,
		sales.product_id,
		members.join_date,
		sales.order_date
	FROM sales
	JOIN members ON sales.customer_id=members.customer_id
	)

	, sales_members_menu AS (
	SELECT 
		*,
		CASE WHEN product_name='sushi' THEN price*20
		     WHEN order_date BETWEEN join_date AND join_date + INTERVAL '1 week' THEN price*20 
			 ELSE price*10 END AS points	
	FROM sales_members sm
	JOIN menu m ON sm.product_id=m.product_id
	)

	SELECT customer_id,
	SUM(points) AS total_points
	FROM sales_members_menu
	WHERE order_date < '2021-01-31'
	GROUP BY customer_id
	ORDER BY customer_id;

| customer_id | total_points |
|-------------|--------------|
| A           | 1370         |
| B           | 940          |

**BONUS QUESTION - Join All The Things**

	SELECT
	sales.customer_id,
	sales.order_date,
	menu.product_name,
	menu.price,
	CASE WHEN sales.order_date>=members.join_date THEN 'Y' 
		 WHEN sales.order_date<members.join_date THEN 'N' 
		 ELSE 'N' END AS member
	FROM sales 
	LEFT JOIN menu ON sales.product_id=menu.product_id
	LEFT JOIN members ON sales.customer_id=members.customer_id
	ORDER BY sales.customer_id, sales.order_date, menu.price DESC;

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


**BONUS QUESTION - Rank All The Things**

Danny also requires further information about the ranking of customer products, 
but he purposely does not need the ranking for non-member purchases so he expects 
null ranking values for the records when customers are not yet part of the loyalty program.

	WITH cte_members AS (
	SELECT
		sales.customer_id,
		sales.order_date,
		menu.product_name,
		menu.price,
		CASE WHEN sales.order_date>=members.join_date THEN 'Y' 
			 WHEN sales.order_date<members.join_date THEN 'N' 
			 ELSE 'N' END AS member
	FROM sales 
	LEFT JOIN menu ON sales.product_id=menu.product_id
	LEFT JOIN members ON sales.customer_id=members.customer_id
	ORDER BY sales.customer_id, sales.order_date, menu.price DESC
	)

	SELECT 
	*,
	CASE WHEN member = 'Y' then DENSE_RANK() OVER (PARTITION BY customer_id, member ORDER BY order_date)
		 ELSE NULL END AS ranking
	FROM cte_members
	ORDER BY customer_id, order_date, price DESC ;


| customer_id | order_date | product_name | price | member | ranking |
|-------------|------------|--------------|-------|--------|---------|
| A           | 2021-01-01 | curry        | 15    | N      | NULL    |
| A           | 2021-01-01 | sushi        | 10    | N      | NULL    |
| A           | 2021-01-07 | curry        | 15    | Y      | 1       |
| A           | 2021-01-10 | ramen        | 12    | Y      | 2       |
| A           | 2021-01-11 | ramen        | 12    | Y      | 3       |
| A           | 2021-01-11 | ramen        | 12    | Y      | 3       |
| B           | 2021-01-01 | curry        | 15    | N      | NULL    |
| B           | 2021-01-02 | curry        | 15    | N      | NULL    |
| B           | 2021-01-04 | sushi        | 10    | N      | NULL    |
| B           | 2021-01-11 | sushi        | 10    | Y      | 1       |
| B           | 2021-01-16 | ramen        | 12    | Y      | 2       |
| B           | 2021-02-01 | ramen        | 12    | Y      | 3       |
| C           | 2021-01-01 | ramen        | 12    | N      | NULL    |
| C           | 2021-01-01 | ramen        | 12    | N      | NULL    |
| C           | 2021-01-07 | ramen        | 12    | N      | NULL    |


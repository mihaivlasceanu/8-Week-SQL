  
--1.What is the total amount each customer spent at the restaurant?  

SELECT
customer_id,
SUM(price)
FROM sales s
JOIN menu m ON s.product_id=m.product_id
GROUP BY 1
ORDER BY 1;

--2.How many days has each customer visited the restaurant?

SELECT
customer_id,
COUNT(DISTINCT order_date)
FROM sales
GROUP BY 1
ORDER BY 1;

--3.What was the first item from the menu purchased by each customer?

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

--4.What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT 
menu.product_name,
COUNT(product_name) AS times_ordered
FROM sales
JOIN menu ON sales.product_id=menu.product_id
GROUP BY 1
ORDER BY 2 DESC;

--5.Which item was the most popular for each customer?

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

--6.Which item was purchased first by the customer after they became a member?

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

--7.Which item was purchased just before the customer became a member?

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

--8.What is the total items and amount spent for each member before they became a member?

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

--9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

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

--10.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

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

--BONUS QUESTION - Join All The Things

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

--BONUS QUESTION - Rank All The Things
/*
Danny also requires further information about the ranking of customer products, 
but he purposely does not need the ranking for non-member purchases so he expects 
null ranking values for the records when customers are not yet part of the loyalty program.
*/

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

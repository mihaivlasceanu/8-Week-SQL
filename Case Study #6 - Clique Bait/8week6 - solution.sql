
-- A. Enterprise Relationship Diagram
-- https://dbdiagram.io/home


-- B. DIGITAL ANALYSIS
-- Using the available datasets - answer the following questions using a single query for each one:

-- 1. How many users are there?

SELECT
COUNT(DISTINCT user_id)
FROm users
	 
-- 2. How many cookies does each user have on average?

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

-- 3. What is the unique number of visits by all users per month?

SELECT
DATE_TRUNC('month',event_time)::date AS month,
COUNT(DISTINCT visit_id)
FROM events
GROUP BY 1
ORDER BY 1

-- 4. What is the number of events for each event type?

SELECT
event_type,
COUNT(event_time)
FROM events
GROUP BY 1
ORDER BY 1

-- If we want to include both the event type and name columns from the event_identifier table:

SELECT
event_identifier.event_type,
event_identifier.event_name,
COUNT(*) AS count_events 
FROM events
INNER JOIN event_identifier ON events.event_type = event_identifier.event_type
GROUP BY event_identifier.event_type, event_identifier.event_name
ORDER BY event_identifier.event_type, event_identifier.event_name;

-- 5. What is the percentage of visits which have a purchase event?

-- SOLUTION 1 (a bit slower because of the subquery):

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

-- 6. What is the percentage of visits which view the checkout page but do not have a purchase event?

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

-- SOLUTION 2:

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

-- 7. What are the top 3 pages by number of views?

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

-- 8. What is the number of views and cart adds for each product category?

SELECT
product_category,
COUNT(CASE WHEN event_name='Page View' THEN 1 ELSE NULL END) AS views,
COUNT(CASE WHEN event_name='Add to Cart' THEN 1 ELSE NULL END) AS additions_to_cart
FROM events e
JOIN page_hierarchy ph ON e.page_id=ph.page_id
JOIN event_identifier ei ON e.event_type=ei.event_type
WHERE product_category IS NOT NULL
GROUP BY 1

-- 9. What are the top 3 products by purchases?

-- SOLUTION 1:

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

-- SOLUTION 2:

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


-- C. PRODUCT FUNNEL ANALYSIS
/*
Using a single SQL query - create a new output table which has the following details:

- How many times was each product viewed?
- How many times was each product added to cart?
- How many times was each product added to a cart but not purchased (abandoned)?
- How many times was each product purchased?
*/

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

-- Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

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

-- Using your 2 new output tables - answer the following questions.

-- 1.Which product had the most views, cart adds and purchases?

SELECT
*
FROM product_analysis

-- 2. Which product was most likely to be abandoned?

SELECT
page_name,
ROUND(times_not_purchased / times_added_to_cart,2) AS abandoned_likelihood
FROM product_analysis
ORDER BY abandoned_likelihood DESC
LIMIT 1;


-- 3. Which product had the highest view to purchase percentage?

SELECT
page_name,
ROUND(1.0*100*times_purchased/times_viewed,2) AS views_to_purchase
FROM product_analysis
ORDER BY 2 DESC

-- 4. What is the average conversion rate from view to cart add?

-- 5. What is the average conversion rate from cart add to purchase?

SELECT
ROUND(1.0*100*AVG(times_added_to_cart/times_viewed),2) AS view_to_add,
ROUND(1.0*100*AVG(times_purchased/times_added_to_cart),2) AS add_to_purchase
FROM product_analysis


-- D. CAMPAIGN ANALYSIS

/*
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

*/

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

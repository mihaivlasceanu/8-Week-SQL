
/* A. Customer Journey
Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.

Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!
*/

SELECT 
*
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
ORDER BY customer_id
LIMIT 10;

--Choosing a few random customers to get a feel for the data:

SELECT 
*
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
WHERE customer_id=6
ORDER BY start_date;

--Customer with the ID of 6 started his free trial on the 23rd of December 2020, chose to downgrade to the basic monthly plan and eventually churned more than a year later, on the 26th of February 2021

SELECT 
*
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
WHERE customer_id=303
ORDER BY start_date;

-- CUstomer 303 started his free trial on the 13th of February 2020, downgraded to the basic monthly plan after a week, then churned less than 4 months later, on the 15th of June 2020.

SELECT 
*
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
WHERE customer_id=598
ORDER BY start_date;

-- Customer 598 started his free trial on the 28th of December 2020 and chose to remain on the pro monthly plan at the end of the trial, on the 4th of January 2021


-- B. DATA ANALYSIS QUESTIONS

-- 1. How many customers has Foodie-Fi ever had?

SELECT 
COUNT(DISTINCT customer_id)
FROM subscriptions

-- 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

SELECT
DATE_TRUNC('month', start_date)::DATE,
COUNT(DISTINCT customer_id)
FROM subscriptions
WHERE plan_id=0
GROUP BY 1
ORDER BY 1;

-- 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

SELECT 
plan_name,
COUNT(*)
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
WHERE EXTRACT('year' FROM start_date)>=2021
GROUP BY 1
ORDER BY 1

-- 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

-- SOLUTION 1:

SELECT 
COUNT(DISTINCT customer_id) AS churned,
ROUND(1.0*100*COUNT(DISTINCT customer_id)/ (SELECT 
							   				 COUNT(DISTINCT customer_id)
							   				 FROM subscriptions),1) AS churned_percentage
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
WHERE s.plan_id=4

--SOLUTION 2:

SELECT
SUM(CASE WHEN plan_id = 4 THEN 1 ELSE 0 END) AS churn_customers,
ROUND(
  100 * SUM(CASE WHEN plan_id = 4 THEN 1 ELSE 0 END) /
    COUNT(DISTINCT customer_id)::NUMERIC,1
) AS percentage
FROM subscriptions;

-- 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

--SOLUTION 1 (a bit overly complicated):

WITH first_date AS (
SELECT
	DISTINCT customer_id,
	FIRST_VALUE(start_date) OVER (PARTITION BY customer_id) as date1
FROM subscriptions
ORDER BY 1	
)

, second_date AS (
SELECT 
	customer_id,
	date1,
	(date1 + INTERVAL '7 days')::DATE AS date2
FROM first_date
)

, churn_cte AS (
SELECT 
	DISTINCT sd.customer_id,
	plan_id,
	sd.date2
FROM second_date sd
JOIN subscriptions subs ON sd.date2=subs.start_date
AND sd.customer_id=subs.customer_id
WHERE plan_id=4
ORDER BY 1
)

SELECT 
COUNT(DISTINCT customer_id) AS churned,
ROUND(100*COUNT(DISTINCT customer_id)*1.0 / (SELECT 
							   				 COUNT(DISTINCT customer_id)
							   				 FROM subscriptions),1) AS churned_percentage
FROM churn_cte

--SOLUTION 2 (more straightforward):

WITH ranked_plans AS (
SELECT
    customer_id,
    plan_id,
    ROW_NUMBER() OVER (
      PARTITION BY customer_id
      ORDER BY start_date) AS plan_rank
FROM subscriptions
)

SELECT
SUM(CASE WHEN plan_id = 4 THEN 1 ELSE 0 END) AS churn_customers,
ROUND(
  100 * SUM(CASE WHEN plan_id = 4 THEN 1 ELSE 0 END) /
  COUNT(*)::NUMERIC,1
) AS percentage
FROM ranked_plans
WHERE plan_rank = 2;

-- 6. What is the number and percentage of customer plans after their initial free trial?

--SOLUTION 1:

WITH first_date AS (
SELECT DISTINCT 
	customer_id,
	FIRST_VALUE(start_date) OVER (PARTITION BY customer_id) as date1
FROM subscriptions
ORDER BY 1
)

, second_date AS (
SELECT 
	customer_id,
	date1,
	(date1 + INTERVAL '7 days')::DATE AS date2
FROM first_date
)

, churn_cte AS (
SELECT DISTINCT 
	sd.customer_id,
	plan_id,
	sd.date2
FROM second_date sd
JOIN subscriptions subs ON sd.date2=subs.start_date
AND sd.customer_id=subs.customer_id
WHERE plan_id IN (1,2,3,4)
ORDER BY 1
)

SELECT 
plan_id,
COUNT(*),
ROUND(100*COUNT(DISTINCT customer_id)*1.0 / (SELECT 
							   				 COUNT(DISTINCT customer_id)
							   				 FROM subscriptions),1) AS churned_percentage
FROM churn_cte
GROUP BY plan_id

-- SOLUTION 2:

WITH ranked_plans AS (
SELECT
	customer_id,
	plan_id,
	ROW_NUMBER() OVER (
	PARTITION BY customer_id
	ORDER BY start_date) AS plan_rank
FROM subscriptions
)

SELECT
plans.plan_id,
plans.plan_name,
COUNT(*) AS customer_count,
ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER ()::NUMERIC) AS percentage
FROM ranked_plans
INNER JOIN plans ON ranked_plans.plan_id = plans.plan_id
WHERE plan_rank = 2
GROUP BY plans.plan_id, plans.plan_name
ORDER BY plans.plan_id;

-- 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

-- SOLUTION 1:

WITH last_date AS(
SELECT DISTINCT 
	customer_id,
	LAST_VALUE(start_date) OVER (PARTITION BY customer_id) as last_date
FROM subscriptions
WHERE start_date <= '2020-12-31'
ORDER BY customer_id
)

, last_plan AS(
SELECT 
	s.customer_id,
	ld.last_date,
	s.plan_id,
	plan_name
FROM subscriptions s
JOIN last_date ld ON s.start_date=ld.last_date
AND s.customer_id=ld.customer_id
JOIN plans p ON s.plan_id=p.plan_id
ORDER BY 1
)

SELECT 
plan_id,
plan_name,
COUNT(*),
ROUND(100*COUNT(DISTINCT customer_id)*1.0 / (SELECT 
							   				 COUNT(DISTINCT customer_id)
							   				 FROM subscriptions),1) AS percentage
FROM last_plan
GROUP BY 1,2
ORDER BY 1

-- SOLUTION 2: 

WITH valid_subscriptions AS (
SELECT
    customer_id,
    plan_id,
    start_date,
    ROW_NUMBER() OVER (
      PARTITION BY customer_id
      ORDER BY start_date DESC) AS plan_rank
FROM subscriptions
WHERE start_date <= '2020-12-31'
)

, summarised_plans AS (
SELECT
    plan_id,
    COUNT(DISTINCT customer_id) AS customers
FROM valid_subscriptions
WHERE plan_rank=1                      
GROUP BY plan_id
)

SELECT
plans.plan_id,
plans.plan_name,
customers,
ROUND(
  100 * customers /
    SUM(customers) OVER (),1) AS percentage
FROM summarised_plans
INNER JOIN plans ON summarised_plans.plan_id = plans.plan_id
ORDER BY plans.plan_id;

-- 8. How many customers have upgraded to an annual plan in 2020?

SELECT
COUNT(DISTINCT customer_id)
FROM subscriptions
WHERE start_date BETWEEN '2020-01-01' AND '2020-12-31'
AND plan_id=3

-- 9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

-- SOLUTION 1:

WITH first_date AS(
SELECT
	DISTINCT customer_id,
	start_date AS date1
FROM subscriptions
WHERE plan_id=0
ORDER BY 1
)

, upgrade_date AS(
SELECT DISTINCT 
	customer_id,
	start_date AS date2
FROM subscriptions
WHERE plan_id=3
ORDER BY 1
)

, interval_cte AS(
SELECT
	fd.customer_id,
	date1,
	date2,
	date2-date1 AS days_to_upgrade
FROM first_date fd
JOIN upgrade_date ud ON fd.customer_id=ud.customer_id
)

SELECT 
ROUND(AVG(days_to_upgrade))
FROM interval_cte

-- SOLUTION 2:

WITH annual_plan AS (
SELECT
    customer_id,
    start_date
FROM subscriptions
WHERE plan_id = 3
)

, trial AS (
SELECT
    customer_id,
    start_date
FROM subscriptions
WHERE plan_id = 0
)

SELECT
ROUND(AVG(DATE_PART('days', annual_plan.start_date::TIMESTAMP - trial.start_date::TIMESTAMP)))
FROM annual_plan
JOIN trial ON annual_plan.customer_id=trial.customer_id;

-- 10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

-- SOLUTION 1:

WITH first_date AS(
SELECT DISTINCT 
	customer_id,
	start_date as date1
FROM subscriptions
WHERE plan_id=0
ORDER BY 1
)

, upgrade_date AS(
SELECT DISTINCT 
	customer_id,
	start_date as date2
FROM subscriptions
WHERE plan_id=3
ORDER BY 1
)

, interval_cte AS(
SELECT
	fd.customer_id,
	date1,
	date2,
	date2-date1 as days_to_upgrade
FROM first_date fd
JOIN upgrade_date ud ON fd.customer_id=ud.customer_id
)

, interval_cte_2 AS(
SELECT
	customer_id,
	CASE WHEN days_to_upgrade <= 30 THEN '0-30'
	 	 WHEN days_to_upgrade <= 60 THEN '30-60'
	 	 WHEN days_to_upgrade <= 90 THEN '60-90'
	 	 WHEN days_to_upgrade <= 120 THEN '90-120'
	 	 WHEN days_to_upgrade <= 150 THEN '120-150' 
	 	 WHEN days_to_upgrade <= 180 THEN '150-180'
	 	 WHEN days_to_upgrade <= 210 THEN '180-210'
	 	 WHEN days_to_upgrade <= 240 THEN '210-240'
	 	 WHEN days_to_upgrade <= 270 THEN '240-270'
	 	 WHEN days_to_upgrade <= 300 THEN '270-300'
	 	 WHEN days_to_upgrade <= 330 THEN '300-330'
	 	 WHEN days_to_upgrade <= 360 THEN '330-360' END as days
FROM interval_cte
)

SELECT 
days,
COUNT(*)
FROM interval_cte_2
GROUP BY 1
ORDER BY CASE WHEN days = '0-30' THEN 0
			  WHEN days = '30-60' THEN 1
			  WHEN days = '60-90' THEN 2
			  WHEN days = '90-120' THEN 3
			  WHEN days = '120-150' THEN 4
			  WHEN days = '150-180' THEN 5
			  WHEN days = '180-210' THEN 6
			  WHEN days = '210-240' THEN 7
			  WHEN days = '240-270' THEN 8
			  WHEN days = '270-300' THEN 9
			  WHEN days = '300-330' THEN 10 END;

-- SOLUTION 2:

WITH annual_plan AS (
SELECT
	customer_id,
	start_date
FROM subscriptions
WHERE plan_id = 3
)

, trial AS (
SELECT
    customer_id,
    start_date
FROM subscriptions
WHERE plan_id = 0
)

, annual_days AS (
SELECT
	DATE_PART('days', annual_plan.start_date::TIMESTAMP - trial.start_date::TIMESTAMP)::INTEGER AS duration
FROM annual_plan
INNER JOIN trial ON annual_plan.customer_id = trial.customer_id
)

, breakdowns AS (
SELECT
	30 * ROUND(annual_days.duration / 30) || ' - ' || 30 * (1 + ROUND(annual_days.duration / 30)) || ' days' AS breakdown_period,
	COUNT(*) AS customers
FROM annual_days
GROUP BY breakdown_period 
)

SELECT
*
FROM breakdowns
ORDER BY ARRAY_POSITION(ARRAY['0 - 30 days','30 - 60 days','60 - 90 days','90 - 120 days','120 - 150 days','150 - 180 days','180 - 210 days','210 - 240 days','240 - 270 days','270 - 300 days','300 - 330 days','330 - 360 days'], breakdown_period);

-- 11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

WITH ranked_plans AS (
SELECT
	customer_id,
	plan_id,
	start_date,
	LAG(plan_id) OVER (PARTITION BY customer_id ORDER BY start_date DESC) AS lag_plan_id
FROM subscriptions
WHERE DATE_PART('year', start_date) = 2020
)

SELECT
COUNT(*)
FROM ranked_plans
WHERE lag_plan_id = 2 AND plan_id = 1;


-- C. CHALLENGE PAYMENT QUESTIONS

/*
The Foodie-Fi team wants you to create a new payments table for the year 2020 that includes amounts paid by each customer in the subscriptions table with the following requirements:
	-monthly payments always occur on the same day of month as the original start_date of any monthly paid plan
	-upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately
	-upgrades from pro monthly to pro annual are paid at the end of the current billing period and also starts at the end of the month period
	-once a customer churns they will no longer make payments
*/

-- SOLUTION 1:

WITH payments_cte AS (
SELECT
	customer_id,
	s.plan_id,
	plan_name,
	generate_series(
	start_date,
	CASE WHEN s.plan_id = 3 THEN start_date
     	WHEN s.plan_id = 4 THEN NULL
     	WHEN LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date) IS NOT NULL 
				THEN LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date)
          		ELSE '2020-12-31' :: date END,
	'1 month' + '1 second' :: interval) AS payment_date,
	price AS amount
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE s.plan_id <> 0 AND start_date < '2021-01-01' :: date
GROUP BY 
	customer_id,
	s.plan_id,
	plan_name,
	start_date,
	price
)

SELECT
customer_id,
plan_id,
plan_name,
payment_date ::date :: varchar,
CASE WHEN LAG(plan_id) OVER (PARTITION BY customer_id ORDER BY plan_id) <> plan_id
     AND DATE_PART('day',payment_date - LAG(payment_date) OVER (PARTITION BY customer_id ORDER BY plan_id)) < 30 
	 THEN amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY plan_id)
     ELSE amount END AS amount,
RANK() OVER(PARTITION BY customer_id ORDER BY payment_date) AS payment_order 
FROM payments_cte
ORDER BY customer_id

-- SOLUTION 2:

WITH lead_plans AS (
SELECT
	customer_id,
	plan_id,
	start_date,
	LEAD(plan_id) OVER (PARTITION BY customer_id ORDER BY start_date) AS lead_plan_id,
	LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date) AS lead_start_date
FROM subscriptions
WHERE DATE_PART('year', start_date) = 2020
AND plan_id != 0
)

-- case 1: non churn monthly customers
, case_1 AS (
SELECT
	customer_id,
	plan_id,
	start_date,
	DATE_PART('mon', AGE('2020-12-31'::DATE, start_date))::INTEGER AS month_diff
FROM lead_plans
WHERE lead_plan_id IS NULL
-- not churn and annual customers
AND plan_id NOT IN (3, 4)
)

-- generate a series to add the months to each start_date
, case_1_payments AS (
SELECT
    customer_id,
    plan_id,
    (start_date + GENERATE_SERIES(0, month_diff) * INTERVAL '1 month')::DATE AS start_date
FROM case_1
)

-- case 2: churn customers
, case_2 AS (
SELECT
    customer_id,
    plan_id,
    start_date,
    DATE_PART('mon', AGE(lead_start_date - 1, start_date))::INTEGER AS month_diff
FROM lead_plans
-- churn accounts only
WHERE lead_plan_id = 4
)

, case_2_payments AS (
SELECT
    customer_id,
    plan_id,
    (start_date + GENERATE_SERIES(0, month_diff) * INTERVAL '1 month')::DATE AS start_date
FROM case_2
)

-- case 3: customers who move from basic to pro plans
, case_3 AS (
SELECT
    customer_id,
    plan_id,
    start_date,
    DATE_PART('mon', AGE(lead_start_date - 1, start_date))::INTEGER AS month_diff
FROM lead_plans
WHERE plan_id = 1 AND lead_plan_id IN (2, 3)
)

, case_3_payments AS (
SELECT
    customer_id,
    plan_id,
    (start_date + GENERATE_SERIES(0, month_diff) * INTERVAL '1 month')::DATE AS start_date
FROM case_3
)

-- case 4: pro monthly customers who move up to annual plans
, case_4 AS (
SELECT
    customer_id,
    plan_id,
    start_date,
    DATE_PART('mon', AGE(lead_start_date - 1, start_date))::INTEGER AS month_diff
FROM lead_plans
WHERE plan_id = 2 AND lead_plan_id = 3
)

, case_4_payments AS (
SELECT
    customer_id,
    plan_id,
    (start_date + GENERATE_SERIES(0, month_diff) * INTERVAL '1 month')::DATE AS start_date
FROM case_4
)

-- case 5: annual pro payments
, case_5_payments AS (
SELECT
    customer_id,
    plan_id,
    start_date
FROM lead_plans
WHERE plan_id = 3
),

-- union all where we union all parts
union_output AS (
SELECT * FROM case_1_payments
	UNION ALL
SELECT * FROM case_2_payments
	UNION ALL
SELECT * FROM case_3_payments
	UNION ALL
SELECT * FROM case_4_payments
	UNION ALL
SELECT * FROM case_5_payments
)

SELECT
customer_id,
plans.plan_id,
plans.plan_name,
start_date AS payment_date,
-- price deductions are applied here
CASE WHEN union_output.plan_id IN (2, 3) AND
     LAG(union_output.plan_id) OVER w = 1
     THEN plans.price - 9.90
     ELSE plans.price
     END AS amount,
RANK() OVER w AS payment_order
FROM union_output
INNER JOIN plans ON union_output.plan_id = plans.plan_id
-- where filter for outputs for testing
WHERE customer_id IN (1, 2, 7, 11, 13, 15, 16, 18, 19, 25, 39)
WINDOW w AS (
	PARTITION BY union_output.customer_id
	ORDER BY start_date
);

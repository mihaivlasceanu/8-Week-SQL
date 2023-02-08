# Case Study #3 - Foodie-Fi

![Foodie-Fi logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%203.png)

## 📚  Table of Contents

-   [📋  Introduction](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%233%20-%20Foodie-Fi#introduction)
-   [📄 Available Data](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%233%20-%20Foodie-Fi#available-data)
-   [❓  Case Study Questions](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%233%20-%20Foodie-Fi#case-study-questions)
-  [✔️  Solutions](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%233%20-%20Foodie-Fi#solutions)

# Introduction

Subscription based businesses are super popular and Danny realised that there was a large gap in the market - he wanted to create a new streaming service that only had food related content - something like Netflix but with only cooking shows!

Danny finds a few smart friends to launch his new startup Foodie-Fi in 2020 and started selling monthly and annual subscriptions, giving their customers unlimited on-demand access to exclusive food videos from around the world!

Danny created Foodie-Fi with a data driven mindset and wanted to ensure all future investment decisions and new features were decided using data. This case study focuses on using subscription style digital data to answer important business questions.

# Available Data

Danny has shared the data design for Foodie-Fi and also short descriptions on each of the database tables - our case study focuses on only 2 tables but there will be a challenge to create a new table for the Foodie-Fi team.

## Entity Relationship Diagram

![Foodie-Fi ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%203%20ERD.png)

## Datasets

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

# Case Study Questions

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

# Solutions

## A. Customer Journey
Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.

Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!
```sql
SELECT 
*
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
ORDER BY customer_id
LIMIT 10;
```
| customer_id | plan_id | start_date | plan_id-2 | plan_name     | price |
|-------------|---------|------------|-----------|---------------|-------|
| 1           | 0       | 2020-08-01 | 0         | trial         | 0.0   |
| 1           | 1       | 2020-08-08 | 1         | basic monthly | 9.9   |
| 2           | 0       | 2020-09-20 | 0         | trial         | 0.0   |
| 2           | 3       | 2020-09-27 | 3         | pro annual    | 199.0 |
| 3           | 1       | 2020-01-20 | 1         | basic monthly | 9.9   |
| 3           | 0       | 2020-01-13 | 0         | trial         | 0.0   |
| 4           | 0       | 2020-01-17 | 0         | trial         | 0.0   |
| 4           | 1       | 2020-01-24 | 1         | basic monthly | 9.9   |
| 4           | 4       | 2020-04-21 | 4         | churn         | NULL  |
| 5           | 1       | 2020-08-10 | 1         | basic monthly | 9.9   |

Choosing a few random customers to get a feel for the data:
```sql
SELECT 
*
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
WHERE customer_id=6
ORDER BY start_date;
```
| customer_id | plan_id | start_date | plan_id-2 | plan_name     | price |
|-------------|---------|------------|-----------|---------------|-------|
| 6           | 0       | 2020-12-23 | 0         | trial         | 0.00  |
| 6           | 1       | 2020-12-30 | 1         | basic monthly | 9.90  |
| 6           | 4       | 2021-02-26 | 4         | churn         | NULL  |

Customer with the ID of 6 started his free trial on the 23rd of December 2020, chose to downgrade to the basic monthly plan and eventually churned more than a year later, on the 26th of February 2021
```sql
SELECT 
*
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
WHERE customer_id=303
ORDER BY start_date;
```
| customer_id | plan_id | start_date | plan_id-2 | plan_name     | price |
|-------------|---------|------------|-----------|---------------|-------|
| 303         | 0       | 2020-02-13 | 0         | trial         | 0.00  |
| 303         | 1       | 2020-02-20 | 1         | basic monthly | 9.90  |
| 303         | 4       | 2020-06-15 | 4         | churn         | NULL  |

Customer 303 started his free trial on the 13th of February 2020, downgraded to the basic monthly plan after a week, then churned less than 4 months later, on the 15th of June 2020.
```sql
SELECT 
*
FROM subscriptions s
JOIN plans p ON s.plan_id=p.plan_id
WHERE customer_id=598
ORDER BY start_date;
```
| customer_id | plan_id | start_date | plan_id-2 | plan_name   | price |
|-------------|---------|------------|-----------|-------------|-------|
| 598         | 0       | 2020-12-28 | 0         | trial       | 0.00  |
| 598         | 2       | 2021-01-04 | 2         | pro monthly | 19.90 |

Customer 598 started his free trial on the 28th of December 2020 and chose to remain on the pro monthly plan at the end of the trial, on the 4th of January 2021

## B. DATA  ANALYSIS QUESTIONS

1. How many customers has Foodie-Fi ever had?
	```sql
	SELECT 
	COUNT(DISTINCT customer_id)
	FROM subscriptions
	```
	| count |
	|-------|
	| 1000  |

2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
	```sql
	SELECT
	DATE_TRUNC('month', start_date)::DATE,
	COUNT(DISTINCT customer_id)
	FROM subscriptions
	WHERE plan_id=0
	GROUP BY 1
	ORDER BY 1;
	```
	| date_trunc | count |
	|------------|-------|
	| 2020-01-01 | 88    |
	| 2020-02-01 | 68    |
	| 2020-03-01 | 94    |
	| 2020-04-01 | 81    |
	| 2020-05-01 | 88    |
	| 2020-06-01 | 79    |
	| 2020-07-01 | 89    |
	| 2020-08-01 | 88    |
	| 2020-09-01 | 87    |
	| 2020-10-01 | 79    |
	| 2020-11-01 | 75    |
	| 2020-12-01 | 84    |

3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
	```sql
	SELECT 
	plan_name,
	COUNT(*)
	FROM subscriptions s
	JOIN plans p ON s.plan_id=p.plan_id
	WHERE EXTRACT('year' FROM start_date)>=2021
	GROUP BY 1
	ORDER BY 1
	```
	| plan_name     | count |
	|---------------|-------|
	| basic monthly | 8     |
	| churn         | 71    |
	| pro annual    | 63    |
	| pro monthly   | 60    |

4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

	SOLUTION 1:
	```sql
	SELECT 
	COUNT(DISTINCT customer_id) AS churned,
	ROUND(1.0*100*COUNT(DISTINCT customer_id)/ (SELECT COUNT(DISTINCT customer_id)
	FROM subscriptions),1) AS churned_percentage
	FROM subscriptions s
	JOIN plans p ON s.plan_id=p.plan_id
	WHERE s.plan_id=4
	```
	SOLUTION 2:
	```sql
	SELECT
	SUM(CASE WHEN plan_id = 4 THEN 1 ELSE 0 END) AS churn_customers,
	ROUND(
	  100 * SUM(CASE WHEN plan_id = 4 THEN 1 ELSE 0 END) /
	    COUNT(DISTINCT customer_id)::NUMERIC,1
	) AS percentage
	FROM subscriptions;
	```
	| churn_customers | percentage |
	|-----------------|------------|
	| 307             | 30.7       |

5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

	SOLUTION 1 (a bit overly complicated):
	```sql
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
	```
	SOLUTION 2 (more straightforward):
	```sql
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
	```
	| churn_customers | percentage |
	|-----------------|------------|
	| 92              | 9.2        |

6. What is the number and percentage of customer plans after their initial free trial?

	SOLUTION 1:
	```sql
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
	```		
	| plan_id | count | churned_percentage |
	|---------|-------|--------------------|
	| 1       | 546   | 54.6               |
	| 2       | 325   | 32.5               |
	| 3       | 37    | 3.7                |
	| 4       | 92    | 9.2                |

	SOLUTION 2:
	```sql
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
	```
	| plan_id | plan_name     | customer_count | percentage |
	|---------|---------------|----------------|------------|
	| 1       | basic monthly | 546            | 55         |
	| 2       | pro monthly   | 325            | 33         |
	| 3       | pro annual    | 37             | 4          |
	| 4       | churn         | 92             | 9          |

7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

	SOLUTION 1:
	```sql
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
	```
	SOLUTION 2: 
	```sql
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
	```
	| plan_id | plan_name     | customers | percentage |
	|---------|---------------|-----------|------------|
	| 0       | trial         | 19        | 1.9        |
	| 1       | basic monthly | 224       | 22.4       |
	| 2       | pro monthly   | 326       | 32.6       |
	| 3       | pro annual    | 195       | 19.5       |
	| 4       | churn         | 236       | 23.6       |

8. How many customers have upgraded to an annual plan in 2020?
	```sql
	SELECT
	COUNT(DISTINCT customer_id)
	FROM subscriptions
	WHERE start_date BETWEEN '2020-01-01' AND '2020-12-31'
	AND plan_id=3
	```
	| count |
	|-------|
	| 195   |

9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

	SOLUTION 1:
	```sql
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
	```
	SOLUTION 2:
	```sql
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
	```
	| count |
	|-------|
	| 195   |

10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

	SOLUTION 1:
	```sql		
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
	```
		
	|  days    | count |
	|---------|-------|
	|  0-30    | 49    |
	|  30-60   | 24    |
	|  60-90   | 34    |
	|  90-120  | 35    |
	|  120-150 | 42    |
	|  150-180 | 36    |
	|  180-210 | 26    |
	|  210-240 | 4     |
	|  240-270 | 5     |
	|  270-300 | 1     |
	|  300-330 | 1     |
	|  330-360 | 1     |

	SOLUTION 2:
	```sql
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
	```
	|  breakdown_period | customers |
	|------------------|-----------|
	|  0 - 30 days      | 48        |
	|  30 - 60 days     | 25        |
	|  60 - 90 days     | 33        |
	|  90 - 120 days    | 35        |
	|  120 - 150 days   | 43        |
	|  150 - 180 days   | 35        |
	|  180 - 210 days   | 27        |
	|  210 - 240 days   | 4         |
	|  240 - 270 days   | 5         |
	|  270 - 300 days   | 1         |
	|  300 - 330 days   | 1         |
	|  330 - 360 days   | 1         |

11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
	```sql
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
	```
	|  count |
	|-------|
	|  163   |

## C. CHALLENGE PAYMENT QUESTIONS

The Foodie-Fi team wants you to create a new payments table for the year 2020 that includes amounts paid by each customer in the subscriptions table with the following requirements:
	-monthly payments always occur on the same day of month as the original start_date of any monthly paid plan
	-upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately
	-upgrades from pro monthly to pro annual are paid at the end of the current billing period and also starts at the end of the month period
	-once a customer churns they will no longer make payments

SOLUTION 1:
```sql
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
```
SOLUTION 2:
```sql
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
```
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

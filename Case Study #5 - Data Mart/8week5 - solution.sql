 
-- A. DATA CLEANSING STEPS
  
/*
In a single query, perform the following operations and generate a new table in the data_mart schema named clean_weekly_sales:

- Convert the week_date to a DATE format

- Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc

- Add a month_number with the calendar month for each week_date value as the 3rd column

- Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values

- Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value

- Add a new demographic column using the following mapping for the first letter in the segment values:

- Ensure all null string values with an "unknown" string value in the original segment column as well as the new age_band and demographic columns

- Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record
*/

SELECT
TO_DATE(week_date, 'DD/MM/YY') AS week_date,
DATE_PART('week', week_date::DATE) AS week_number,
DATE_PART('month', week_date::DATE) AS month_number,
DATE_PART('year', week_date::DATE) AS calendar_year,
region,
platform,
CASE WHEN segment = 'null' THEN 'unknown'
     ELSE segment END AS segment,
CASE WHEN RIGHT(segment,1) = '1' THEN 'Young Adults'
	 WHEN RIGHT(segment,1) = '2' THEN 'Middle Aged'
     WHEN RIGHT(segment,1) IN ('3','4') THEN 'Retirees' 
	 ELSE 'unknown' END AS age_band,
CASE WHEN LEFT(segment,1) = 'C' THEN 'Couples'
     WHEN LEFT (segment,1) = 'F' THEN 'Families' 
	 ELSE 'unknown' END AS demographic,
customer_type,
sales,
transactions,
ROUND(sales::numeric/transactions,2) AS avg_transaction
INTO clean_weekly_sales
FROM weekly_sales 

SELECT 
*
FROM clean_weekly_sales
LIMIT 10;


-- B. DATA EXPLORATION

-- 1. What day of the week is used for each week_date value?

SELECT
DISTINCT TO_CHAR(week_date,'day')
FROM clean_weekly_sales

-- 2. What range of week numbers are missing from the dataset?

WITH all_week_numbers AS (
SELECT 
	GENERATE_SERIES(1, 26) AS week_number
)

SELECT
week_number
FROM all_week_numbers AS t1
WHERE EXISTS (
	SELECT 1
	FROM clean_weekly_sales AS t2
	WHERE t1.week_number = t2.week_number
);

-- 3. How many total transactions were there for each year in the dataset?

SELECT
calendar_year,
SUM(transactions) AS total_transactions
FROM clean_weekly_sales
GROUP BY 1
ORDER BY 1

-- 4. What is the total sales for each region for each month?

SELECT
DATE_TRUNC('month', week_date)::DATE AS calendar_month,
region,
SUM(sales) AS total_sales
FROM clean_weekly_sales
GROUP BY calendar_month, region
ORDER BY calendar_month, region
LIMIT 10;

-- 5. What is the total count of transactions for each platform?

SELECT
platform, 
SUM(transactions)
FROM clean_weekly_sales
GROUP BY 1
ORDER BY 1

-- 6. What is the percentage of sales for Retail vs Shopify for each month?

-- Solution 1

WITH platform_sales AS (
SELECT
	calendar_year,
	month_number, 
	platform,
	SUM(sales) AS separate_sales,
	SUM(SUM(sales)) OVER (PARTITION BY calendar_year, month_number) AS total_sales
FROM clean_weekly_sales
GROUP BY 1,2,3
ORDER BY 1,2,3
)

, percentage_sales AS (
SELECT 
	calendar_year,
	month_number, 
	platform,
	ROUND(separate_sales/total_sales*100,2) AS percentage
FROM platform_sales
ORDER BY 1,2,3
) 

SELECT
calendar_year,
month_number,
CASE WHEN platform='Retail' THEN percentage ELSE 100 - percentage END AS retail_percentage,
CASE WHEN platform='Shopify' THEN percentage ELSE 100 - percentage END AS shopify_percentage
FROM percentage_sales
--GROUP BY month_number
GROUP BY 1,2,3,4
ORDER BY 1,2,3,4

-- Solution 2 (less is more/better)

WITH sales_cte AS (
SELECT 
	calendar_year,
	month_number,
	SUM(CASE WHEN platform='Retail' THEN sales END) AS retail_sales,
	SUM(CASE WHEN platform='Shopify' THEN sales END) AS shopify_sales,
	SUM(sales) AS total_sales
FROM clean_weekly_sales
GROUP BY 1,2
ORDER BY 1,2
)

SELECT 
calendar_year,
month_number,
ROUND(1.0*retail_sales/total_sales*100, 2) AS retail_percent,
ROUND(1.0*shopify_sales/total_sales*100, 2) AS shopify_percent
FROM sales_cte;

-- 7. What is the (amount and the) percentage of sales by demographic for each year in the dataset?

-- SOLUTION 1:

WITH demographic_sales AS (
SELECT
	calendar_year,
	SUM(CASE WHEN demographic = 'Couples' THEN sales END) AS couple_sales,
	SUM(CASE WHEN demographic = 'Families' THEN sales END) AS family_sales,
	SUM(CASE WHEN demographic = 'unknown' THEN sales END) AS unknown_sales,
	SUM(sales) as total_sales
FROM clean_weekly_sales
GROUP BY 1
)

SELECT
calendar_year,
ROUND(1.0*couple_sales/total_sales*100,2) AS couple_percentage,
ROUND(1.0*family_sales/total_sales*100,2) AS family_sales,
ROUND(1.0*unknown_sales/total_sales*100,2) AS unknown_sales
FROM demographic_sales
ORDER BY 1

-- SOLUTION 2 (differently displayed):

SELECT
calendar_year,
demographic,
SUM(sales) AS yearly_sales,
ROUND((100 * SUM(sales) / SUM(SUM(sales)) OVER (PARTITION BY calendar_year))::NUMERIC, 2) AS percentage
FROM clean_weekly_sales
GROUP BY
calendar_year,
demographic
ORDER BY
calendar_year,
demographic;

-- 8. Which age_band and demographic values contribute the most to Retail sales?

-- age band only
SELECT
age_band,
SUM(sales) AS total_sales,
ROUND(100 * SUM(sales)/ SUM(SUM(sales)) OVER ()) AS sales_percentage     -- important NOT to partition inside the window function
FROM clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY age_band
ORDER BY sales_percentage DESC;

-- demographic only
SELECT
demographic,
SUM(sales) AS total_sales,
ROUND(100 * SUM(sales) / SUM(SUM(sales)) OVER ()) AS sales_percentage
FROM clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY demographic
ORDER BY sales_percentage DESC;

-- both age and demographic
SELECT
age_band,
demographic,
SUM(sales) AS total_sales,
ROUND(100 * SUM(sales) / SUM(SUM(sales)) OVER ()) AS sales_percentage
FROM clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY age_band, demographic
ORDER BY sales_percentage DESC;

-- 9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?

--Answer: No, because averages of averages are to be avoided (incorrect denominator)

SELECT 
calendar_year,
platform,
ROUND(1.0*SUM(sales)/SUM(transactions),2) AS average_transaction
FROM clean_weekly_sales
GROUP BY 1,2
ORDER BY 1,2


-- C. BEFORE AND AFTER ANALYSIS

/* 
This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.

Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart sustainable packaging changes came into effect.

We would include all week_date values for 2020-06-15 as the start of the period after the change and the previous week_date values would be before

Using this analysis approach - answer the following questions:

1. What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?
2. What about the entire 12 weeks before and after?
3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?
*/


--1. 4 weeks before and after

WITH four_weeks_2020 AS (
SELECT
	week_date,
	SUM(sales) AS weekly_sales
FROM clean_weekly_sales 
WHERE week_date BETWEEN '2020-06-15'::date - INTERVAL '4 weeks' AND '2020-06-15'::date + INTERVAL '3 weeks'
GROUP BY 1
ORDER BY 1
)

, four_before_after AS (
SELECT 
	SUM(CASE WHEN week_date <'2020-06-15' THEN weekly_sales END) AS previous_4,
	SUM(CASE WHEN week_date >='2020-06-15' THEN weekly_sales END) AS following_4
FROM four_weeks_2020
)

SELECT 
previous_4,
following_4,
following_4 - previous_4 AS absolute_growth,
ROUND(1.0*100*(following_4-previous_4)/previous_4,2) AS pct_growth
FROM four_before_after

-- 2. 12 weeks before and after

WITH twelve_weeks_2020 AS (
SELECT
	week_date,
	SUM(sales) as weekly_sales
FROM clean_weekly_sales 
WHERE week_date BETWEEN '2020-06-15'::date - INTERVAL '12 weeks' AND '2020-06-15'::date + INTERVAL '11 weeks'
GROUP BY 1
ORDER BY 1
)

, twelve_before_after AS (
SELECT 
	SUM(CASE WHEN week_date <'2020-06-15' THEN weekly_sales END) AS previous_12,
	SUM(CASE WHEN week_date >='2020-06-15' THEN weekly_sales END) AS following_12
FROM twelve_weeks_2020
)

SELECT 
previous_12,
following_12,
following_12 - previous_12 AS absolute_growth,
ROUND(1.0*100*(following_12-previous_12)/previous_12,2) AS pct_growth
FROM twelve_before_after

-- 3. same periods but for 2018 and 2019 - using a slightly different approach (by taking advantage of our week_number column)
-- a. 4 weeks

WITH year_to_year AS (
SELECT
	calendar_year,
	week_number,
	SUM(sales) AS weekly_sales
FROM clean_weekly_sales 
WHERE week_number BETWEEN 21 AND 28
GROUP BY 1,2
ORDER BY 1
)

, year_to_year_2 AS (
SELECT 
	calendar_year,
	SUM(CASE WHEN week_number BETWEEN 21 AND 24 THEN weekly_sales END) AS previous_4,
	SUM(CASE WHEN week_number BETWEEN 25 AND 28 THEN weekly_sales END) AS following_4
FROM year_to_year
GROUP BY 1
)

SELECT 
calendar_year,
previous_4,
following_4,
following_4 - previous_4 AS absolute_growth,
ROUND(1.0*100*(following_4-previous_4)/previous_4,2) AS pct_growth
FROM year_to_year_2

-- b. 12 weeks

WITH year_to_year AS (
SELECT
	calendar_year,
	week_number,
SUM(sales) AS weekly_sales
FROM clean_weekly_sales 
WHERE week_number BETWEEN 13 AND 37
GROUP BY 1,2
ORDER BY 1
)

, year_to_year_2 AS (
SELECT 
	calendar_year,
	SUM(CASE WHEN week_number BETWEEN 13 AND 24 THEN weekly_sales END) AS previous_4,
	SUM(CASE WHEN week_number BETWEEN 25 AND 37 THEN weekly_sales END) AS following_4
FROM year_to_year
GROUP BY 1
)

SELECT 
calendar_year,
previous_4,
following_4,
following_4 - previous_4 AS absolute_growth,
ROUND(1.0*100*(following_4-previous_4)/previous_4,2) AS pct_growth
FROM year_to_year_2


-- D. BONUS QUESTION
/* 
Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?

- region
- platform
- age_band
- demographic
- customer_type
Do you have any further recommendations for Danny’s team at Data Mart or any interesting insights based off this analysis?
*/

WITH twelve_weeks_2020 AS (
SELECT
	week_date,
	region,
	--platform,
	--age_band,
	--demographic,
	--customer_type,
	SUM(sales) AS weekly_sales
FROM clean_weekly_sales 
WHERE week_date BETWEEN '2020-06-15'::date - INTERVAL '12 weeks' AND '2020-06-15'::date + INTERVAL '11 weeks'
GROUP BY 1,2 --,2,3,4,5,6
ORDER BY 1
)

, twelve_before_after AS (
SELECT 
	region,
	--platform,
	--age_band,
	--demographic,
	--customer_type,
	SUM(CASE WHEN week_date <'2020-06-15' THEN weekly_sales END) AS previous_12,
	SUM(CASE WHEN week_date >='2020-06-15' THEN weekly_sales END) AS following_12
FROM twelve_weeks_2020
GROUP BY 1
)

SELECT 
region,
--platform,
--age_band,
--demographic,
--customer_type,
previous_12,
following_12,
following_12 - previous_12 AS absolute_growth,
ROUND(1.0*100*(following_12-previous_12)/previous_12,2) AS pct_growth
FROM twelve_before_after
ORDER BY pct_growth


/*
Testing out area by area, we find that:
- when it comes to the regions we analyzed, only Europe registered positive growth 
- Shopify grew significantly, while Retail experienced a drop in sales
- the middle aged and retired customers experienced the biggest drop in sales
- family sales dropped more than couples'
- sales for guests and existing customers dropped while those for new customers increased slightly
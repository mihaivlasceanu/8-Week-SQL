# Case Study #5 - Data Mart

![Data Mart logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%205.png)

## 📚  Table of Contents

-   [📋  Introduction](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%235%20-%20Data%20Mart#introduction)
-   [📄 Available Data](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%235%20-%20Data%20Mart#available-data)
-   [❓  Case Study Questions](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%235%20-%20Data%20Mart#case-study-questions)
-  [✔️  Solutions](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%235%20-%20Data%20Mart#solutions)

# Introduction

Data Mart is Danny’s latest venture and after running international operations for his online supermarket that specialises in fresh produce - Danny is asking for your support to analyse his sales performance.

In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.

Danny needs your help to quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.

The key business question he wants you to help him answer are the following:

-   What was the quantifiable impact of the changes introduced in June 2020?
-   Which platform, region, segment and customer types were the most impacted by this change?
-   What can we do about future introduction of similar sustainability updates to the business to minimise impact on sales?

# Available Data

For this case study there is only a single table:  `data_mart.weekly_sales`

The  `Entity Relationship Diagram`  is shown below with the data types made clear, please note that there is only this one table - hence why it looks a little bit lonely!

![Data Mart ERD](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%205%20ERD.png)

## Column Dictionary

The columns are pretty self-explanatory based on the column names but here are some further details about the dataset:

1.  Data Mart has international operations using a multi-`region`  strategy
2.  Data Mart has both, a retail and online  `platform`  in the form of a Shopify store front to serve their customers
3.  Customer  `segment`  and  `customer_type`  data relates to personal age and demographics information that is shared with Data Mart
4.  `transactions`  is the count of unique purchases made through Data Mart and  `sales`  is the actual dollar amount of purchases

Each record in the dataset is related to a specific aggregated slice of the underlying sales data rolled up into a  `week_date`  value which represents the start of the sales week.

## Example Rows

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

# Case Study Questions

The following case study questions require some data cleaning steps before we start to unpack Danny’s key business questions in more depth.

## A. Data Cleansing Steps

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

## B. Data Exploration

1.  What day of the week is used for each  `week_date`  value?
2.  What range of week numbers are missing from the dataset?
3.  How many total transactions were there for each year in the dataset?
4.  What is the total sales for each region for each month?
5.  What is the total count of transactions for each platform
6.  What is the percentage of sales for Retail vs Shopify for each month?
7.  What is the percentage of sales by demographic for each year in the dataset?
8.  Which  `age_band`  and  `demographic`  values contribute the most to Retail sales?
9.  Can we use the  `avg_transaction`  column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?

## C. Before & After Analysis

This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.

Taking the  `week_date`  value of  `2020-06-15`  as the baseline week where the Data Mart sustainable packaging changes came into effect.

We would include all  `week_date`  values for  `2020-06-15`  as the start of the period  **after**  the change and the previous  `week_date`  values would be  **before**

Using this analysis approach - answer the following questions:

1.  What is the total sales for the 4 weeks before and after  `2020-06-15`? What is the growth or reduction rate in actual values and percentage of sales?
2.  What about the entire 12 weeks before and after?
3.  How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

## D. Bonus Question

Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?

-   `region`
-   `platform`
-   `age_band`
-   `demographic`
-   `customer_type`

Do you have any further recommendations for Danny’s team at Data Mart or any interesting insights based off this analysis?

# Solutions

## A. DATA CLEANSING STEPS
  
In a single query, perform the following operations and generate a new table in the data_mart schema named clean_weekly_sales:

- Convert the week_date to a DATE format

- Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc

- Add a month_number with the calendar month for each week_date value as the 3rd column

- Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values

- Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value

- Add a new demographic column using the following mapping for the first letter in the segment values:

- Ensure all null string values with an "unknown" string value in the original segment column as well as the new age_band and demographic columns

- Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record

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

| week_date  | week_number | month_number | calendar_year | region | platform | segment | age_band     | demographic | customer_type | sales    | transactions | avg_transaction |
|------------|-------------|--------------|---------------|--------|----------|---------|--------------|-------------|---------------|----------|--------------|-----------------|
| 2020-08-31 | 36          | 8            | 2020          | ASIA   | Retail   | C3      | Retirees     | Couples     | New           | 3656163  | 120631       | 30.31           |
| 2020-08-31 | 36          | 8            | 2020          | ASIA   | Retail   | F1      | Young Adults | Families    | New           | 996575   | 31574        | 31.56           |
| 2020-08-31 | 36          | 8            | 2020          | USA    | Retail   | unknown | unknown      | unknown     | Guest         | 16509610 | 529151       | 31.2            |
| 2020-08-31 | 36          | 8            | 2020          | EUROPE | Retail   | C1      | Young Adults | Couples     | New           | 141942   | 4517         | 31.42           |
| 2020-08-31 | 36          | 8            | 2020          | AFRICA | Retail   | C2      | Middle Aged  | Couples     | New           | 1758388  | 58046        | 30.29           |
| 2020-08-31 | 36          | 8            | 2020          | CANADA | Shopify  | F2      | Middle Aged  | Families    | Existing      | 243878   | 1336         | 182.54          |
| 2020-08-31 | 36          | 8            | 2020          | AFRICA | Shopify  | F3      | Retirees     | Families    | Existing      | 519502   | 2514         | 206.64          |
| 2020-08-31 | 36          | 8            | 2020          | ASIA   | Shopify  | F1      | Young Adults | Families    | Existing      | 371417   | 2158         | 172.11          |
| 2020-08-31 | 36          | 8            | 2020          | AFRICA | Shopify  | F2      | Middle Aged  | Families    | New           | 49557    | 318          | 155.84          |
| 2020-08-31 | 36          | 8            | 2020          | AFRICA | Retail   | C3      | Retirees     | Couples     | New           | 3888162  | 111032       | 35.02           |

## B. DATA EXPLORATION

1. What day of the week is used for each week_date value?

		SELECT
		DISTINCT TO_CHAR(week_date,'day')
		FROM clean_weekly_sales
	| to_char |
	|---------|
	| monday  |

2. What range of week numbers are missing from the dataset?

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
	
	| week_number |
	|-------------|
	| 13          |
	| 14          |
	| 15          |
	| 16          |
	| 17          |
	| 18          |
	| 19          |
	| 20          |
	| 21          |
	| 22          |
	| 23          |
	| 24          |
	| 25          |
	| 26          |

 3. How many total transactions were there for each year in the dataset?

		SELECT
		calendar_year,
		SUM(transactions) AS total_transactions
		FROM clean_weekly_sales
		GROUP BY 1
		ORDER BY 1

	|  calendar_year | total_transactions |
	|---------------|--------------------|
	|  2018          | 346406460          |
	|  2019          | 365639285          |
	|  2020          | 375813651          |

4. What is the total sales for each region for each month?

		SELECT
		DATE_TRUNC('month', week_date)::DATE AS calendar_month,
		region,
		SUM(sales) AS total_sales
		FROM clean_weekly_sales
		GROUP BY calendar_month, region
		ORDER BY calendar_month, region
		LIMIT 10;

	| calendar_month | region        | total_sales |
	|----------------|---------------|-------------|
	| 2018-03-01     | AFRICA        | 130542213   |
	| 2018-03-01     | ASIA          | 119180883   |
	| 2018-03-01     | CANADA        | 33815571    |
	| 2018-03-01     | EUROPE        | 8402183     |
	| 2018-03-01     | OCEANIA       | 175777460   |
	| 2018-03-01     | SOUTH AMERICA | 16302144    |
	| 2018-03-01     | USA           | 52734998    |
	| 2018-04-01     | AFRICA        | 650194751   |
	| 2018-04-01     | ASIA          | 603716301   |
	| 2018-04-01     | CANADA        | 163479820   |

5. What is the total count of transactions for each platform?

		SELECT
		platform, 
		SUM(transactions)
		FROM clean_weekly_sales
		GROUP BY 1
		ORDER BY 1

	| platform | sum        |
	|----------|------------|
	| Retail   | 1081934227 |
	| Shopify  | 5925169    |

6. What is the percentage of sales for Retail vs Shopify for each month?

	SOLUTION 1

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

	SOLUTION 2

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

	| calendar_year | month_number | retail_percent | shopify_percent |
	|---------------|--------------|----------------|-----------------|
	| 2018          | 3            | 97.92          | 2.08            |
	| 2018          | 4            | 97.93          | 2.07            |
	| 2018          | 5            | 97.73          | 2.27            |
	| 2018          | 6            | 97.76          | 2.24            |
	| 2018          | 7            | 97.75          | 2.25            |
	| 2018          | 8            | 97.71          | 2.29            |
	| 2018          | 9            | 97.68          | 2.32            |
	| 2019          | 3            | 97.71          | 2.29            |
	| 2019          | 4            | 97.80          | 2.20            |
	| 2019          | 5            | 97.52          | 2.48            |
	| 2019          | 6            | 97.42          | 2.58            |
	| 2019          | 7            | 97.35          | 2.65            |
	| 2019          | 8            | 97.21          | 2.79            |
	| 2019          | 9            | 97.09          | 2.91            |
	| 2020          | 3            | 97.30          | 2.70            |
	| 2020          | 4            | 96.96          | 3.04            |
	| 2020          | 5            | 96.71          | 3.29            |
	| 2020          | 6            | 96.80          | 3.20            |
	| 2020          | 7            | 96.67          | 3.33            |
	| 2020          | 8            | 96.51          | 3.49            |

7. What is the (amount and the) percentage of sales by demographic for each year in the dataset?

	SOLUTION 1:

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

	| calendar_year | couple_percentage | family_sales | unknown_sales |
	|---------------|-------------------|--------------|---------------|
	| 2018          | 26.38             | 31.99        | 41.63         |
	| 2019          | 27.28             | 32.47        | 40.25         |
	| 2020          | 28.72             | 32.73        | 38.55         |

	SOLUTION 2 (differently displayed):

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

	| calendar_year | demographic | yearly_sales | percentage |
	|---------------|-------------|--------------|------------|
	| 2018          | Couples     | 3402388688   | 26.38      |
	| 2018          | Families    | 4125558033   | 31.99      |
	| 2018          | unknown     | 5369434106   | 41.63      |
	| 2019          | Couples     | 3749251935   | 27.28      |
	| 2019          | Families    | 4463918344   | 32.47      |
	| 2019          | unknown     | 5532862221   | 40.25      |
	| 2020          | Couples     | 4049566928   | 28.72      |
	| 2020          | Families    | 4614338065   | 32.73      |
	| 2020          | unknown     | 5436315907   | 38.55      |

8. Which age_band and demographic values contribute the most to Retail sales?

- age band only

		SELECT
		age_band,
		SUM(sales) AS total_sales,
		ROUND(100 * SUM(sales)/ SUM(SUM(sales)) OVER ()) AS sales_percentage     -- important NOT to partition inside the window function
		FROM clean_weekly_sales
		WHERE platform = 'Retail'
		GROUP BY age_band
		ORDER BY sales_percentage DESC;

	| age_band     | total_sales | sales_percentage |
	|--------------|-------------|------------------|
	| unknown      | 16067285533 | 41               |
	| Retirees     | 13005266930 | 33               |
	| Middle Aged  | 6208251884  | 16               |
	| Young Adults | 4373812090  | 11               |

- demographic only

		SELECT
		demographic,
		SUM(sales) AS total_sales,
		ROUND(100 * SUM(sales) / SUM(SUM(sales)) OVER ()) AS sales_percentage
		FROM clean_weekly_sales
		WHERE platform = 'Retail'
		GROUP BY demographic
		ORDER BY sales_percentage DESC;

	| demographic | total_sales | sales_percentage |
	|-------------|-------------|------------------|
	| unknown     | 16067285533 | 41               |
	| Families    | 12759667763 | 32               |
	| Couples     | 10827663141 | 27               |

- both age and demographic

		SELECT
		age_band,
		demographic,
		SUM(sales) AS total_sales,
		ROUND(100 * SUM(sales) / SUM(SUM(sales)) OVER ()) AS sales_percentage
		FROM clean_weekly_sales
		WHERE platform = 'Retail'
		GROUP BY age_band, demographic
		ORDER BY sales_percentage DESC;

	| age_band     | demographic | total_sales | sales_percentage |
	|--------------|-------------|-------------|------------------|
	| unknown      | unknown     | 16067285533 | 41               |
	| Retirees     | Families    | 6634686916  | 17               |
	| Retirees     | Couples     | 6370580014  | 16               |
	| Middle Aged  | Families    | 4354091554  | 11               |
	| Young Adults | Couples     | 2602922797  | 7                |
	| Middle Aged  | Couples     | 1854160330  | 5                |
	| Young Adults | Families    | 1770889293  | 4                |

9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?

	--Answer: No, because averages of averages are to be avoided (incorrect denominator)

		SELECT 
		calendar_year,
		platform,
		ROUND(1.0*SUM(sales)/SUM(transactions),2) AS average_transaction
		FROM clean_weekly_sales
		GROUP BY 1,2
		ORDER BY 1,2

	| calendar_year | platform | average_transaction |
	|---------------|----------|---------------------|
	| 2018          | Retail   | 36.56               |
	| 2018          | Shopify  | 192.48              |
	| 2019          | Retail   | 36.83               |
	| 2019          | Shopify  | 183.36              |
	| 2020          | Retail   | 36.56               |
	| 2020          | Shopify  | 179.03              |

## C. BEFORE AND AFTER ANALYSIS

This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.

Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart sustainable packaging changes came into effect.

We would include all week_date values for 2020-06-15 as the start of the period after the change and the previous week_date values would be before

Using this analysis approach - answer the following questions:

- What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?
- What about the entire 12 weeks before and after?
- How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

1. 4 weeks before and after

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

	| previous_4 | following_4 | absolute_growth | pct_growth |
	|------------|-------------|-----------------|------------|
	| 2345878357 | 2318994169  | -26884188       | -1.15      |

2. 12 weeks before and after

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

	| previous_12 | following_12 | absolute_growth | pct_growth |
	|-------------|--------------|-----------------|------------|
	| 7126273147  | 6973947753   | -152325394      | -2.14      |

3. same periods but for 2018 and 2019 - using a slightly different approach (by taking advantage of our week_number column)
- 4 weeks

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

	| calendar_year | previous_4 | following_4 | absolute_growth | pct_growth |
	|---------------|------------|-------------|-----------------|------------|
	| 2018          | 2125140809 | 2129242914  | 4102105         | 0.19       |
	| 2019          | 2249989796 | 2252326390  | 2336594         | 0.10       |
	| 2020          | 2345878357 | 2318994169  | -26884188       | -1.15      |

- 12 weeks

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

	| calendar_year | previous_4 | following_4 | absolute_growth | pct_growth |
	|---------------|------------|-------------|-----------------|------------|
	| 2018          | 6396562317 | 6500818510  | 104256193       | 1.63       |
	| 2019          | 6883386397 | 6862646103  | -20740294       | -0.30      |
	| 2020          | 7126273147 | 6973947753  | -152325394      | -2.14      |

## D. BONUS QUESTION
Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?

- region
- platform
- age_band
- demographic
- customer_type
Do you have any further recommendations for Danny’s team at Data Mart or any interesting insights based off this analysis?

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

Testing out area by area, we find that:
- when it comes to the regions we analyzed, only Europe registered positive growth 
- Shopify grew significantly, while Retail experienced a drop in sales
- the middle aged and retired customers experienced the biggest drop in sales
- family sales dropped more than those for couples
- sales for guests and existing customers dropped while those for new customers increased slightly



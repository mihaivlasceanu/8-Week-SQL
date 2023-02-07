# Case Study #8 - Fresh Segments

![Fresh Segments logo](https://github.com/mihaivlasceanu/8-Week-SQL/blob/main/images/Week%208.png)

## 📚  Table of Contents

-   [📋  Introduction](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%238%20-%20Fresh%20Segments#introduction)
-   [📄 Available Data](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%238%20-%20Fresh%20Segments#available-data)
-   [❓  Case Study Questions](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%238%20-%20Fresh%20Segments#case-study-questions)
-  [✔️  Solutions](https://github.com/mihaivlasceanu/8-Week-SQL/tree/main/Case%20Study%20%238%20-%20Fresh%20Segments#solutions)

# Introduction

Danny created Fresh Segments, a digital marketing agency that helps other businesses analyse trends in online ad click behaviour for their unique customer base.

Clients share their customer lists with the Fresh Segments team who then aggregate interest metrics and generate a single dataset worth of metrics for further analysis.

In particular - the composition and rankings for different interests are provided for each client showing the proportion of their customer list who interacted with online assets related to each interest for each month.

Danny has asked for your assistance to analyse aggregated metrics for an example client and provide some high level insights about the customer list and their interests.

# Available Data

For this case study there is a total of 2 datasets which you will need to use to solve the questions.

##  Datasets

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

# Case Study Questions

The following questions can be considered key business questions that are required to be answered for the Fresh Segments team.

Most questions can be answered using a single query however some questions are more open ended and require additional thought and not just a coded solution!

## A. Data Exploration and Cleansing

1.  Update the  `fresh_segments.interest_metrics`  table by modifying the  `month_year`  column to be a date data type with the start of the month
2.  What is count of records in the  `fresh_segments.interest_metrics`  for each  `month_year`  value sorted in chronological order (earliest to latest) with the null values appearing first?
3.  What do you think we should do with these null values in the  `fresh_segments.interest_metrics`
4.  How many  `interest_id`  values exist in the  `fresh_segments.interest_metrics`  table but not in the  `fresh_segments.interest_map`  table? What about the other way around?
5.  Summarise the  `id`  values in the  `fresh_segments.interest_map`  by its total record count in this table
6.  What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where  `interest_id = 21246`  in your joined output and include all columns from  `fresh_segments.interest_metrics`  and all columns from  `fresh_segments.interest_map`  except from the  `id`  column.
7.  Are there any records in your joined table where the  `month_year`  value is before the  `created_at`  value from the  `fresh_segments.interest_map`  table? Do you think these values are valid and why?

## B. Interest Analysis

1.  Which interests have been present in all  `month_year`  dates in our dataset?
2.  Using this same  `total_months`  measure - calculate the cumulative percentage of all records starting at 14 months - which  `total_months`  value passes the 90% cumulative percentage value?
3.  If we were to remove all  `interest_id`  values which are lower than the  `total_months`  value we found in the previous question - how many total data points would we be removing?
4.  Does this decision make sense to remove these data points from a business perspective? Use an example where there are all 14 months present to a removed  `interest`  example for your arguments - think about what it means to have less months present from a segment perspective. > 5. If we include all of our interests regardless of their counts - how many unique interests are there for each month?

## C. Segment Analysis

1.  Using the complete dataset - which are the top 10 and bottom 10 interests which have the largest composition values in any  `month_year`? Only use the maximum composition value for each interest but you must keep the corresponding  `month_year`
2.  Which 5 interests had the lowest average  `ranking`  value?
3.  Which 5 interests had the largest standard deviation in their  `percentile_ranking`  value?
4.  For the 5 interests found in the previous question - what was minimum and maximum  `percentile_ranking`  values for each interest and its corresponding  `year_month`  value? Can you describe what is happening for these 5 interests?
5.  How would you describe our customers in this segment based off their composition and ranking values? What sort of products or services should we show to these customers and what should we avoid?

## D. Index Analysis

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

# Solutions 

## A. Data Exploration and Cleaning

1. Update the interest_metrics table by modifying the month_year column to be a date data type with the start of the month

	SOLUTION 1:

		ALTER TABLE interest_metrics
		ALTER month_year TYPE DATE USING (TO_DATE(month_year,'MM-YYYY'))
										 
		SELECT 
		*
		FROM interest_metrics
		LIMIT 10;

	| _month | _year | month_year | interest_id | composition | index_value | ranking | percentile_ranking |
	|--------|-------|------------|-------------|-------------|-------------|---------|--------------------|
	| 7      | 2018  | 2018-07-01 | 32486       | 11.89       | 6.19        | 1       | 99.86              |
	| 7      | 2018  | 2018-07-01 | 6106        | 9.93        | 5.31        | 2       | 99.73              |
	| 7      | 2018  | 2018-07-01 | 18923       | 10.85       | 5.29        | 3       | 99.59              |
	| 7      | 2018  | 2018-07-01 | 6344        | 10.32       | 5.1         | 4       | 99.45              |
	| 7      | 2018  | 2018-07-01 | 100         | 10.77       | 5.04        | 5       | 99.31              |
	| 7      | 2018  | 2018-07-01 | 69          | 10.82       | 5.03        | 6       | 99.18              |
	| 7      | 2018  | 2018-07-01 | 79          | 11.21       | 4.97        | 7       | 99.04              |
	| 7      | 2018  | 2018-07-01 | 6111        | 10.71       | 4.83        | 8       | 98.9               |
	| 7      | 2018  | 2018-07-01 | 6214        | 9.71        | 4.83        | 8       | 98.9               |
	| 7      | 2018  | 2018-07-01 | 19422       | 10.11       | 4.81        | 10      | 98.63              |

2. What is count of records in the interest_metrics for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?

		SELECT
		month_year,
		COUNT(*)
		FROM interest_metrics
		GROUP BY 1
		ORDER BY 1 NULLS FIRST

	| month_year | count |
	|------------|-------|
	| NULL       | 1194  |
	| 2018-07-01 | 729   |
	| 2018-08-01 | 767   |
	| 2018-09-01 | 780   |
	| 2018-10-01 | 857   |
	| 2018-11-01 | 928   |
	| 2018-12-01 | 995   |
	| 2019-01-01 | 973   |
	| 2019-02-01 | 1121  |
	| 2019-03-01 | 1136  |
	| 2019-04-01 | 1099  |
	| 2019-05-01 | 857   |
	| 2019-06-01 | 824   |
	| 2019-07-01 | 864   |
	| 2019-08-01 | 1149  |

3. What do you think we should do with these null values in the interest_metrics

		SELECT
		month_year,
		COUNT(*),
		ROUND(1.0*100*COUNT(*)/(SELECT COUNT(*)
								FROM interest_metrics),2) AS pct_of_total
		FROM interest_metrics
		WHERE month_year IS NULL
		GROUP BY 1

	**Answer**: We notice how records that have NULLs for month_year also have NULLs for interest_id and therefore are useless to us. What is more, seeing as the number of NULL values is below 10%, we might decide to simply remove them but it would be best to talk it out with our stakeholders beforehand.

4. How many interest_id values exist in the interest_metrics table but not in the interest_map table? What about the other way around?

		SELECT
		COUNT(interest_id)
		FROM interest_metrics
		WHERE interest_id::int NOT IN (SELECT id FROM interest_map)

	=> 0 values in interest_metrics and not in interest_map

		SELECT
		COUNT(id)
		FROM interest_map
		WHERE id NOT IN (SELECT interest_id::int FROM interest_metrics WHERE interest_id IS NOT NULL)

	=> 7 values in interest_map and not in interest_metrics

	SOLUTION 2:

		SELECT
		COUNT(DISTINCT interest_metrics.interest_id) AS all_interest_metric,
		COUNT(DISTINCT interest_map.id) AS all_interest_map,
		COUNT(CASE WHEN interest_map.id IS NULL THEN interest_metrics.interest_id ELSE NULL END) AS not_in_map,
		COUNT(CASE WHEN interest_metrics.interest_id IS NULL THEN interest_map.id ELSE NULL END)  AS not_in_metrics
		FROM interest_metrics
		FULL OUTER JOIN interest_map
		ON interest_metrics.interest_id::INT = interest_map.id;

	| all_interest_metric | all_interest_map | not_in_map | not_in_metrics |
	|---------------------|------------------|------------|----------------|
	| 1202                | 1209             | 0          | 7              |

5. Summarise the id values in the interest_map by its total record count in this table

		WITH cte_id_records AS (
		SELECT
			id,
			COUNT(*) AS record_count
		FROM interest_map
		GROUP BY id
		)

		SELECT
		record_count,
		COUNT(*) AS id_count
		FROM cte_id_records
		GROUP BY record_count
		ORDER BY record_count;

	| record_count | id_count |
	|--------------|----------|
	| 1            | 1209     |

6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where interest_id = 21246 in your joined output and include all columns from interest_metrics and all columns from interest_map except from the id column.

	**Answe**r: It depends on our approach. If we want to keep the NULL values previously identified, we will use a LEFT join, otherwise an INNER JOIN might be more advisable.

		WITH cte_join AS (
		SELECT
			interest_metrics.*,
			interest_map.interest_name,
			interest_map.interest_summary,
			interest_map.created_at,
			interest_map.last_modified
		FROM interest_metrics
		INNER JOIN interest_map ON interest_metrics.interest_id::INT = interest_map.id
		WHERE interest_metrics.month_year IS NOT NULL
		)

		SELECT * FROM cte_join
		WHERE interest_id::INT = 21246;

	| _month | _year | month_year | interest_id | composition | index_value | ranking | percentile_ranking | interest_name                    | interest_summary                                      | created_at          | last_modified       |
	|--------|-------|------------|-------------|-------------|-------------|---------|--------------------|----------------------------------|-------------------------------------------------------|---------------------|---------------------|
	| 7      | 2018  | 2018-07-01 | 21246       | 2.26        | 0.65        | 722     | 0.96               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 8      | 2018  | 2018-08-01 | 21246       | 2.13        | 0.59        | 765     | 0.26               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 9      | 2018  | 2018-09-01 | 21246       | 2.06        | 0.61        | 774     | 0.77               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 10     | 2018  | 2018-10-01 | 21246       | 1.74        | 0.58        | 855     | 0.23               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 11     | 2018  | 2018-11-01 | 21246       | 2.25        | 0.78        | 908     | 2.16               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 12     | 2018  | 2018-12-01 | 21246       | 1.97        | 0.7         | 983     | 1.21               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 1      | 2019  | 2019-01-01 | 21246       | 2.05        | 0.76        | 954     | 1.95               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 2      | 2019  | 2019-02-01 | 21246       | 1.84        | 0.68        | 1109    | 1.07               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 3      | 2019  | 2019-03-01 | 21246       | 1.75        | 0.67        | 1123    | 1.14               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
	| 4      | 2019  | 2019-04-01 | 21246       | 1.58        | 0.63        | 1092    | 0.64               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |

7. Are there any records in your joined table where the month_year value is before the created_at value from the interest_map table? Do you think these values are valid and why?

	SOLUTION 1:

		SELECT
		COUNT(*)
		FROM interest_metrics mtx
		JOIN interest_map map ON mtx.interest_id::int=map.id
		WHERE month_year < created_at::date


	SOLUTION 2:

		SELECT   						 -- making sure there are no multiple entries per id value (static snapshot rather than a Slow Changing Dimension table)
		id,
		COUNT(*)
		FROM interest_map
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 5;

	| id    | count |
	|-------|-------|
	| 10978 | 1     |
	| 7546  | 1     |
	| 51    | 1     |
	| 45524 | 1     |
	| 6062  | 1     |

		WITH cte_join AS (
		SELECT
			interest_metrics.*,
			interest_map.interest_name,
			interest_map.interest_summary,
			interest_map.created_at,
			interest_map.last_modified
		FROM interest_metrics
		INNER JOIN interest_map ON interest_metrics.interest_id::int = interest_map.id
		WHERE interest_metrics.month_year IS NOT NULL
		)

		SELECT
		COUNT(*)
		FROM cte_join
		WHERE month_year < created_at;

	| count |
	|-------|
	| 188   |

	**Answer**: We have 188 such records but we must keep in mind that our month_year column was modified to show only the first day of each month. So the values are valid. To check this:

		WITH cte_join AS (
		SELECT
			interest_metrics.*,
			interest_map.interest_name,
			interest_map.interest_summary,
			interest_map.created_at,
			interest_map.last_modified
		FROM interest_metrics
		INNER JOIN interest_map ON interest_metrics.interest_id::int = interest_map.id
		WHERE interest_metrics.month_year IS NOT NULL
		)

		SELECT
		COUNT(*)
		FROM cte_join
		WHERE month_year < DATE_TRUNC('mon', created_at);

	| count |
	|-------|
	| 0     |

## B. INTEREST ANALYSIS

1. Which interests have been present in all month_year dates in our dataset?

		WITH cte_interest_months AS (
		SELECT
			interest_id,
			COUNT(DISTINCT month_year) AS total_months
		FROM interest_metrics
		WHERE interest_id IS NOT NULL
		GROUP BY interest_id
		)

		SELECT
		total_months,
		COUNT(DISTINCT interest_id) AS interest_count
		FROM cte_interest_months
		GROUP BY total_months
		ORDER BY total_months DESC;

	| total_months | interest_count |
	|--------------|----------------|
	| 14           | 480            |
	| 13           | 82             |
	| 12           | 65             |
	| 11           | 94             |
	| 10           | 86             |
	| 9            | 95             |
	| 8            | 67             |
	| 7            | 90             |
	| 6            | 33             |
	| 5            | 38             |
	| 4            | 32             |
	| 3            | 15             |
	| 2            | 12             |
	| 1            | 13             |

2. Using this same total_months measure - calculate the cumulative percentage of all records starting at 14 months - which total_months value passes the 90% cumulative percentage value?

	SOLUTION 1:

		WITH total_months AS (
		SELECT
			interest_id,
			interest_name,
			COUNT(DISTINCT month_year) AS no_of_months
		FROM interest_metrics mtx 
		JOIN interest_map map ON mtx.interest_id::int=map.id
		GROUP BY 1,2
		ORDER BY 3 DESC
		)

		, pct_months AS (
		SELECT
			DISTINCT no_of_months,
			COUNT(*) AS records_by_month_count,
			ROUND(1.0*100*COUNT(*) /(SELECT COUNT(no_of_months)
								 FROM total_months),2) AS pct_of_records
		FROM total_months
		GROUP BY 1
		ORDER BY 1 DESC
		)

		SELECT
		no_of_months,
		records_by_month_count,
		pct_of_records,
		SUM(pct_of_records) OVER (ORDER BY no_of_months DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS records_cumsum
		FROM pct_months
		ORDER BY 1 DESC

	| no_of_months | records_by_month_count | pct_of_records | records_cumsum |
	|--------------|------------------------|----------------|----------------|
	| 14           | 480                    | 39.93          | 39.93          |
	| 13           | 82                     | 6.82           | 46.75          |
	| 12           | 65                     | 5.41           | 52.16          |
	| 11           | 94                     | 7.82           | 59.98          |
	| 10           | 86                     | 7.15           | 67.13          |
	| 9            | 95                     | 7.90           | 75.03          |
	| 8            | 67                     | 5.57           | 80.60          |
	| 7            | 90                     | 7.49           | 88.09          |
	| 6            | 33                     | 2.75           | 90.84          |
	| 5            | 38                     | 3.16           | 94.00          |
	| 4            | 32                     | 2.66           | 96.66          |
	| 3            | 15                     | 1.25           | 97.91          |
	| 2            | 12                     | 1.00           | 98.91          |
	| 1            | 13                     | 1.08           | 99.99          |

	SOLUTION 2:

		WITH cte_interest_months AS (
		SELECT
			interest_id,
			COUNT(DISTINCT month_year) AS total_months
		FROM interest_metrics
		WHERE interest_id IS NOT NULL
		GROUP BY interest_id
		)

		, cte_interest_counts AS (
		SELECT
		    total_months,
		    COUNT(DISTINCT interest_id) AS interest_count
		FROM cte_interest_months
		GROUP BY total_months
		)

		SELECT
		total_months,
		interest_count,
		ROUND(
		  100 * SUM(interest_count) OVER (ORDER BY total_months DESC) /
		    (SUM(interest_count) OVER ()),
		  2
		) AS cumulative_percentage
		FROM cte_interest_counts
		ORDER BY total_months DESC;

	| total_months | interest_count | cumulative_percentage |
	|--------------|----------------|-----------------------|
	| 14           | 480            | 39.93                 |
	| 13           | 82             | 46.76                 |
	| 12           | 65             | 52.16                 |
	| 11           | 94             | 59.98                 |
	| 10           | 86             | 67.14                 |
	| 9            | 95             | 75.04                 |
	| 8            | 67             | 80.62                 |
	| 7            | 90             | 88.10                 |
	| 6            | 33             | 90.85                 |
	| 5            | 38             | 94.01                 |
	| 4            | 32             | 96.67                 |
	| 3            | 15             | 97.92                 |
	| 2            | 12             | 98.92                 |
	| 1            | 13             | 100.00                |

3. If we were to remove all interest_id values which are lower than the total_months value we found in the previous question - how many total data points would we be removing?

		WITH cte_removed_interests AS (
		SELECT
			interest_id,
			COUNT(DISTINCT month_year)
		FROM interest_metrics
		WHERE interest_id IS NOT NULL
		GROUP BY interest_id
		HAVING COUNT(DISTINCT month_year) < 6
		)

		SELECT
		COUNT(*) AS removed_rows
		FROM interest_metrics 
		WHERE EXISTS (
		  SELECT 1
		  FROM cte_removed_interests
		  WHERE interest_metrics.interest_id = cte_removed_interests.interest_id
		);

	| removed_rows |
	|--------------|
	| 400          |

4. Does this decision make sense to remove these data points from a business perspective? Use an example where there are all 14 months present to a removed interest example for your arguments - think about what it means to have less months present from a segment perspective.

	**Answer**: It would make sense to remove these data points since for one, they represent less than 10% of all our records (roughly 110 out of 1200) and two, by only analysing the interest_id's that appear for more than 6 months, we can draw sturdier conclusions about our data. That being said, it might be a good idea to perform some additional analysis on these “rare” records just in case they provide some vauable insights into the introduction of new interests.

5. After removing these interests - how many unique interests are there for each month?

		WITH interest_selection AS (
		SELECT
			interest_id,
			interest_name,
			COUNT(DISTINCT month_year) AS no_of_months
		FROM interest_metrics mtx 
		JOIN interest_map map ON mtx.interest_id::int=map.id
		GROUP BY 1,2
		HAVING COUNT(DISTINCT month_year)<6 -- because 6 is the value that passes the 90% cumulative percentage value
		ORDER BY 3 DESC
		)

		, new_interest_metrics AS(
		SELECT
		*
		FROM interest_metrics
		WHERE interest_id NOT IN (SELECT interest_id
								 FROM interest_selection)
		)

		SELECT
		month_year,
		COUNT(DISTINCT interest_id)
		FROM new_interest_metrics
		GROUP BY 1

	| month_year | count |
	|------------|-------|
	| 2018-07-01 | 709   |
	| 2018-08-01 | 752   |
	| 2018-09-01 | 774   |
	| 2018-10-01 | 853   |
	| 2018-11-01 | 925   |
	| 2018-12-01 | 986   |
	| 2019-01-01 | 966   |
	| 2019-02-01 | 1072  |
	| 2019-03-01 | 1078  |
	| 2019-04-01 | 1035  |
	| 2019-05-01 | 827   |
	| 2019-06-01 | 804   |
	| 2019-07-01 | 836   |
	| 2019-08-01 | 1062  |
	| NULL       | 1     |

	If we include all of our interests regardless of their counts - how many unique interests are there for each month?

		WITH cte_ranked_interest AS (
		SELECT
			interest_metrics.month_year,
			interest_map.interest_name,
			interest_metrics.composition,
			RANK() OVER (
		  				PARTITION BY interest_map.interest_name
		  				ORDER BY composition DESC
			) AS interest_rank
		FROM interest_metrics
		INNER JOIN interest_map
		  ON interest_metrics.interest_id::int = interest_map.id
		WHERE interest_metrics.month_year IS NOT NULL
		)

		, cte_top_10 AS (
		SELECT
			month_year,
			interest_name,
			composition
		FROM cte_ranked_interest
		WHERE interest_rank = 1
		ORDER BY composition DESC
		LIMIT 10
		)

		, cte_bottom_10 AS (
		SELECT
			month_year,
			interest_name,
			composition
		FROM cte_ranked_interest
		WHERE interest_rank = 1
		ORDER BY composition
		LIMIT 10
		)

		, final_output AS (
		SELECT * FROM cte_top_10
		UNION
		SELECT * FROM cte_bottom_10
		)
		SELECT * FROM final_output
		ORDER BY composition DESC;

	| month_year | interest_name                        | composition |
	|------------|--------------------------------------|-------------|
	| 2018-12-01 | Work Comes First Travelers           | 21.2        |
	| 2018-07-01 | Gym Equipment Owners                 | 18.82       |
	| 2018-07-01 | Furniture Shoppers                   | 17.44       |
	| 2018-07-01 | Luxury Retail Shoppers               | 17.19       |
	| 2018-10-01 | Luxury Boutique Hotel Researchers    | 15.15       |
	| 2018-12-01 | Luxury Bedding Shoppers              | 15.05       |
	| 2018-07-01 | Shoe Shoppers                        | 14.91       |
	| 2018-07-01 | Cosmetics and Beauty Shoppers        | 14.23       |
	| 2018-07-01 | Luxury Hotel Guests                  | 14.1        |
	| 2018-07-01 | Luxury Retail Researchers            | 13.97       |
	| 2018-07-01 | Readers of Jamaican Content          | 1.86        |
	| 2019-02-01 | Automotive News Readers              | 1.84        |
	| 2018-07-01 | Comedy Fans                          | 1.83        |
	| 2019-08-01 | World of Warcraft Enthusiasts        | 1.82        |
	| 2018-08-01 | Miami Heat Fans                      | 1.81        |
	| 2018-07-01 | Online Role Playing Game Enthusiasts | 1.73        |
	| 2019-08-01 | Hearthstone Video Game Fans          | 1.66        |
	| 2018-09-01 | Scifi Movie and TV Enthusiasts       | 1.61        |
	| 2018-09-01 | Action Movie and TV Enthusiasts      | 1.59        |
	| 2019-03-01 | The Sims Video Game Fans             | 1.57        |

## C. SEGMENT ANALYSIS

1. Using our filtered dataset by removing the interests with less than 6 months worth of data, which are the top 10 and bottom 10 interests which have the largest composition values in any month_year? Only use the maximum composition value for each interest but you must keep the corresponding month_year

		DROP TABLE IF EXISTS filtered_metrics

		WITH interest_selection AS (
		SELECT
			interest_id,
			interest_name,
			COUNT(DISTINCT month_year) AS no_of_months
		FROM interest_metrics mtx 
		JOIN interest_map map ON mtx.interest_id::int=map.id
		GROUP BY 1,2
		HAVING COUNT(DISTINCT month_year)<6 -- because 6 is the value that passes the 90% cumulative percentage value
		ORDER BY 3 DESC
		)

		SELECT
		*
		INTO filtered_metrics  --creating a new table for our filtered dataset
		FROM interest_metrics
		WHERE interest_id NOT IN (SELECT interest_id
								 FROM interest_selection)


		WITH cte_ranked_interest AS (
		SELECT
			filtered_metrics.month_year,
			interest_map.interest_name,
			filtered_metrics.composition,
			RANK() OVER (
		    			PARTITION BY interest_map.interest_name
		    			ORDER BY composition DESC
			) AS interest_rank
		FROM filtered_metrics
		INNER JOIN interest_map ON filtered_metrics.interest_id::int = interest_map.id
		WHERE filtered_metrics.month_year IS NOT NULL
		)

		, cte_top_10 AS (
		SELECT
			month_year,
			interest_name,
			composition
		FROM cte_ranked_interest
		WHERE interest_rank = 1
		ORDER BY composition DESC
		LIMIT 10
		)

		, cte_bottom_10 AS (
		SELECT
			month_year,
			interest_name,
			composition
		FROM cte_ranked_interest
		WHERE interest_rank = 1
		ORDER BY composition
		LIMIT 10
		)

		, final_output AS (
		SELECT * FROM cte_top_10
		UNION
		SELECT * FROM cte_bottom_10
		)
		SELECT * FROM final_output
		ORDER BY composition DESC;

	| month_year | interest_name                     | composition |
	|------------|-----------------------------------|-------------|
	| 2018-12-01 | Work Comes First Travelers        | 21.2        |
	| 2018-07-01 | Gym Equipment Owners              | 18.82       |
	| 2018-07-01 | Furniture Shoppers                | 17.44       |
	| 2018-07-01 | Luxury Retail Shoppers            | 17.19       |
	| 2018-10-01 | Luxury Boutique Hotel Researchers | 15.15       |
	| 2018-12-01 | Luxury Bedding Shoppers           | 15.05       |
	| 2018-07-01 | Shoe Shoppers                     | 14.91       |
	| 2018-07-01 | Cosmetics and Beauty Shoppers     | 14.23       |
	| 2018-07-01 | Luxury Hotel Guests               | 14.1        |
	| 2018-07-01 | Luxury Retail Researchers         | 13.97       |
	| 2018-07-01 | Budget Wireless Shoppers          | 2.18        |
	| 2019-08-01 | Oakland Raiders Fans              | 2.14        |
	| 2018-07-01 | Super Mario Bros Fans             | 2.12        |
	| 2019-01-01 | League of Legends Video Game Fans | 2.09        |
	| 2019-08-01 | Budget Mobile Phone Researchers   | 2.09        |
	| 2018-10-01 | Camaro Enthusiasts                | 2.08        |
	| 2018-07-01 | Xbox Enthusiasts                  | 2.05        |
	| 2019-03-01 | Dodge Vehicle Shoppers            | 1.97        |
	| 2018-10-01 | Medieval History Enthusiasts      | 1.94        |
	| 2018-08-01 | Astrology Enthusiasts             | 1.88        |

2. Which 5 interests had the lowest average ranking value?

	SOLUTION 1 (for filtered dataset):

		SELECT
		interest_map.interest_name,
		ROUND(AVG(filtered_metrics.ranking),1) AS average_ranking,
		COUNT(*) AS record_count
		FROm filtered_metrics 
		JOIN interest_map ON filtered_metrics.interest_id::int=interest_map.id
		GROUP BY 1
		ORDER BY 2 
		LIMIT 5

	| interest_name                  | average_ranking | record_count |
	|--------------------------------|-----------------|--------------|
	| Winter Apparel Shoppers        | 1.0             | 9            |
	| Fitness Activity Tracker Users | 4.1             | 9            |
	| Mens Shoe Shoppers             | 5.9             | 14           |
	| Shoe Shoppers                  | 9.4             | 14           |
	| Preppy Clothing Shoppers       | 11.9            | 14           |

	SOLUTION 2 (for full, unfiltered dataset):

		SELECT
		interest_map.interest_name,
		ROUND(AVG(interest_metrics.ranking), 1) AS average_ranking,
		COUNT(*) AS record_count 
		FROM interest_metrics
		INNER JOIN interest_map ON interest_metrics.interest_id::int = interest_map.id
		WHERE interest_metrics.month_year IS NOT NULL
		GROUP BY
		interest_map.interest_name
		ORDER BY average_ranking
		LIMIT 5;

	| interest_name                  | average_ranking | record_count |
	|--------------------------------|-----------------|--------------|
	| Winter Apparel Shoppers        | 1.0             | 9            |
	| Fitness Activity Tracker Users | 4.1             | 9            |
	| Mens Shoe Shoppers             | 5.9             | 14           |
	| Elite Cycling Gear Shoppers    | 7.8             | 5            |
	| Shoe Shoppers                  | 9.4             | 14           |

3. Which 5 interests had the largest standard deviation in their percentile_ranking value?

	**Answer**: Included the max and min percentile ranking values (to get a feel for how drastic the changes were in the ranking for these interests) and the record counts (to understand how many data points for each interest we are dealing with)

	SOLUTION 1 (filtered dataset):

		SELECT
		interest_id,
		interest_name,
		ROUND(STDDEV(percentile_ranking)::numeric,2) AS stddev_pc_ranking,
		MAX(percentile_ranking) AS max_pc_ranking,
		MIN(percentile_ranking) AS min_pc_ranking,
		COUNT(*) AS record_count
		FROM filtered_metrics fmtx
		JOIN interest_map map ON fmtx.interest_id::int=map.id
		GROUP BY 1,2
		ORDER BY 3 DESC
		LIMIT 5

	| interest_id | interest_name                          | stddev_pc_ranking | max_pc_ranking | min_pc_ranking | record_count |
	|-------------|----------------------------------------|-------------------|----------------|----------------|--------------|
	| 23          | Techies                                | 30.18             | 86.69          | 7.92           | 6            |
	| 20764       | Entertainment Industry Decision Makers | 28.97             | 86.15          | 11.23          | 6            |
	| 38992       | Oregon Trip Planners                   | 28.32             | 82.44          | 2.2            | 10           |
	| 43546       | Personalized Gift Shoppers             | 26.24             | 73.15          | 5.7            | 8            |
	| 10839       | Tampa and St Petersburg Trip Planners  | 25.61             | 75.03          | 4.84           | 6            |

	SOLUTION 2 (unfiltered dataset):

		SELECT
		interest_id,
		interest_name,
		ROUND(STDDEV(percentile_ranking)::numeric,1) AS stddev_pc_ranking,
		MAX(percentile_ranking) AS max_pc_ranking,
		MIN(percentile_ranking) AS min_pc_ranking,
		COUNT(*) AS record_count
		FROM interest_metrics mtx
		JOIN interest_map map ON mtx.interest_id::int=map.id
		WHERE mtx.month_year IS NOT NULL
		GROUP BY 1,2
		HAVING ROUND(STDDEV(percentile_ranking)::numeric,2) IS NOT NULL  -- otherwise it would show us NULL values
		ORDER BY 3 DESC
		LIMIT 5

	| interest_id | interest_name                          | stddev_pc_ranking | max_pc_ranking | min_pc_ranking | record_count |
	|-------------|----------------------------------------|-------------------|----------------|----------------|--------------|
	| 6260        | Blockbuster Movie Fans                 | 41.3              | 60.63          | 2.26           | 2            |
	| 131         | Android Fans                           | 30.7              | 75.03          | 4.84           | 5            |
	| 150         | TV Junkies                             | 30.4              | 93.28          | 10.01          | 5            |
	| 23          | Techies                                | 30.2              | 86.69          | 7.92           | 6            |
	| 20764       | Entertainment Industry Decision Makers | 29.0              | 86.15          | 11.23          | 6            |

4. For the 5 interests found in the previous question - what was minimum and maximum percentile_ranking values for each interest and its corresponding year_month value? Can you describe what is happening for these 5 interests?

	SOLUTION 1 (filtered dataset):

		SELECT
		interest_map.interest_name,
		interest_metrics.month_year,
		interest_metrics.ranking,
		interest_metrics.percentile_ranking,
		interest_metrics.composition
		FROM interest_metrics
		INNER JOIN interest_map ON interest_metrics.interest_id::int = interest_map.id
		WHERE interest_metrics.month_year IS NOT NULL
		  AND interest_metrics.interest_id::int IN (23, 20764, 38992, 43546, 10839)
		ORDER BY
		ARRAY_POSITION(ARRAY[23, 20764, 38992, 43546, 10839]::INTEGER[], interest_metrics.interest_id::int),  
		-- used to specifically set the order of the outputs based off the order from the previous question's outputs 
		interest_metrics.month_year
		LIMIT 10;

	| interest_name                          | month_year | ranking | percentile_ranking | composition |
	|----------------------------------------|------------|---------|--------------------|-------------|
	| Techies                                | 2018-07-01 | 97      | 86.69              | 5.41        |
	| Techies                                | 2018-08-01 | 530     | 30.9               | 1.9         |
	| Techies                                | 2018-09-01 | 594     | 23.85              | 1.6         |
	| Techies                                | 2019-02-01 | 1015    | 9.46               | 1.89        |
	| Techies                                | 2019-03-01 | 1026    | 9.68               | 1.91        |
	| Techies                                | 2019-08-01 | 1058    | 7.92               | 1.9         |
	| Entertainment Industry Decision Makers | 2018-07-01 | 101     | 86.15              | 5.85        |
	| Entertainment Industry Decision Makers | 2018-08-01 | 644     | 16.04              | 1.78        |
	| Entertainment Industry Decision Makers | 2018-10-01 | 697     | 18.67              | 2.01        |
	| Entertainment Industry Decision Makers | 2019-02-01 | 873     | 22.12              | 2.11        |

	SOLUTION 2 (unfiltered dataset):

		SELECT
		interest_map.interest_name,
		interest_metrics.month_year,
		interest_metrics.ranking,
		interest_metrics.percentile_ranking,
		interest_metrics.composition
		FROM interest_metrics
		INNER JOIN interest_map ON interest_metrics.interest_id::int = interest_map.id
		WHERE interest_metrics.month_year IS NOT NULL
		  AND interest_metrics.interest_id::int IN (6260, 131, 150, 23,20764)
		ORDER BY
		ARRAY_POSITION(ARRAY[6260, 131, 150, 23,20764]::INTEGER[], interest_metrics.interest_id::int),  
		-- used to specifically set the order of the outputs based off the order from the previous question's outputs 
		interest_metrics.month_year
		LIMIT 10;
  
	  | interest_name          | month_year | ranking | percentile_ranking | composition |
	|------------------------|------------|---------|--------------------|-------------|
	| Blockbuster Movie Fans | 2018-07-01 | 287     | 60.63              | 5.27        |
	| Blockbuster Movie Fans | 2019-08-01 | 1123    | 2.26               | 1.83        |
	| Android Fans           | 2018-07-01 | 182     | 75.03              | 5.09        |
	| Android Fans           | 2018-08-01 | 684     | 10.82              | 1.77        |
	| Android Fans           | 2019-02-01 | 1058    | 5.62               | 1.85        |
	| Android Fans           | 2019-03-01 | 1081    | 4.84               | 1.72        |
	| Android Fans           | 2019-08-01 | 1092    | 4.96               | 1.91        |
	| TV Junkies             | 2018-07-01 | 49      | 93.28              | 5.3         |
	| TV Junkies             | 2018-08-01 | 481     | 37.29              | 1.7         |
	| TV Junkies             | 2018-10-01 | 430     | 49.82              | 2.34        |

5. How would you describe our customers in this segment based off their composition and ranking values? What sort of products or services should we show to these customers and what should we avoid?

	**Answer**:  By comparing the min and max composition values for our dataset, we can conclude that the customers are mostly interested in travel services, sports (gym equipment), furniture and deluxe shopping. At the other end of the spectrum, and somewhat predictably, they are less interested in niche subjects. 	
			
## D. INDEX ANALYSIS

The index_value is a measure which can be used to reverse calculate the average composition for Fresh Segments’ clients.

Average composition can be calculated by dividing the composition column by the index_value column rounded to 2 decimal places.

1. What are the top 10 interests by the average composition for each month?

		WITH avg_composition_cte AS (
		SELECT
			month_year,
			interest_id,
			interest_name,
			ROUND(composition::numeric/index_value::numeric,2) AS avg_composition,
			ROW_NUMBER() OVER (PARTITION BY month_year ORDER BY ROUND(composition::numeric/index_value::numeric,2) DESC )
		FROM filtered_metrics fmtx
		JOIN interest_map map ON fmtx.interest_id::int=map.id
		ORDER BY 1
		)

		SELECT 
		month_year,
		interest_id,
		interest_name,
		row_number
		FROM avg_composition_cte
		WHERE row_number<=10
		LIMIT 10;

	| month_year | interest_id | interest_name                 | row_number |
	|------------|-------------|-------------------------------|------------|
	| 2018-07-01 | 6324        | Las Vegas Trip Planners       | 1          |
	| 2018-07-01 | 6284        | Gym Equipment Owners          | 2          |
	| 2018-07-01 | 4898        | Cosmetics and Beauty Shoppers | 3          |
	| 2018-07-01 | 77          | Luxury Retail Shoppers        | 4          |
	| 2018-07-01 | 39          | Furniture Shoppers            | 5          |
	| 2018-07-01 | 18619       | Asian Food Enthusiasts        | 6          |
	| 2018-07-01 | 6208        | Recently Retired Individuals  | 7          |
	| 2018-07-01 | 21060       | Family Adventures Travelers   | 8          |
	| 2018-07-01 | 21057       | Work Comes First Travelers    | 9          |
	| 2018-07-01 | 82          | HDTV Researchers              | 10         |

2. For all of these top 10 interests - which interest appears the most often?

		WITH avg_composition_cte AS (
		SELECT
			month_year,
			interest_id,
			interest_name,
			ROUND(composition::numeric/index_value::numeric,2) AS avg_composition,
			ROW_NUMBER() OVER (PARTITION BY month_year ORDER BY ROUND(composition::numeric/index_value::numeric,2) DESC )
		FROM filtered_metrics fmtx
		JOIN interest_map map ON fmtx.interest_id::int=map.id
		ORDER BY 1
		)

		SELECT
		interest_id,
		interest_name,
		COUNT(*)
		FROM avg_composition_cte
		WHERE row_number<=10
		Group BY 1,2
		ORDER BY 3 DESC
		LIMIT 10;

	| interest_id | interest_name                                        | count |
	|-------------|------------------------------------------------------|-------|
	| 5969        | Luxury Bedding Shoppers                              | 10    |
	| 7541        | Alabama Trip Planners                                | 10    |
	| 6065        | Solar Energy Researchers                             | 10    |
	| 18783       | Nursing and Physicians Assistant Journal Researchers | 9     |
	| 21245       | Readers of Honduran Content                          | 9     |
	| 10981       | New Years Eve Party Ticket Purchasers                | 9     |
	| 21057       | Work Comes First Travelers                           | 8     |
	| 34          | Teen Girl Clothing Shoppers                          | 8     |
	| 10977       | Christmas Celebration Researchers                    | 6     |
	| 6284        | Gym Equipment Owners                                 | 5     |

3. What is the average of the average composition for the top 10 interests for each month?

		WITH avg_composition_cte AS (
		SELECT
			month_year,
			interest_id,
			interest_name,
			ROUND(composition::numeric/index_value::numeric,2) AS avg_composition,
			ROW_NUMBER() OVER (PARTITION BY month_year ORDER BY ROUND(composition::numeric/index_value::numeric,2) DESC )
		FROM filtered_metrics fmtx
		JOIN interest_map map ON fmtx.interest_id::int=map.id
		ORDER BY 1
		)

		SELECT 
		month_year,
		ROUND(AVG(avg_composition),2)   -- in this particular case, averages of averages can be used but we should generally avoid them
		FROM avg_composition_cte
		WHERE row_number<=10
		GROUP BY 1
		ORDER BY 1

	| month_year | round |
	|------------|-------|
	| 2018-07-01 | 6.04  |
	| 2018-08-01 | 5.95  |
	| 2018-09-01 | 6.90  |
	| 2018-10-01 | 7.07  |
	| 2018-11-01 | 6.62  |
	| 2018-12-01 | 6.65  |
	| 2019-01-01 | 6.40  |
	| 2019-02-01 | 6.58  |
	| 2019-03-01 | 6.17  |
	| 2019-04-01 | 5.75  |
	| 2019-05-01 | 3.54  |
	| 2019-06-01 | 2.43  |
	| 2019-07-01 | 2.77  |
	| 2019-08-01 | 2.63  |
	| NULL       | 2.37  |

4. What is the 3 month rolling average of the max average composition value from September 2018 to August 2019 and include the previous top ranking interests in the same output shown below.

	SOLUTION 1:

		WITH avg_composition_cte AS (
		SELECT
			month_year,
			interest_id,
			interest_name,
			ROUND(composition::numeric/index_value::numeric,2) AS avg_composition,
			ROW_NUMBER() OVER (PARTITION BY month_year ORDER BY ROUND(composition::numeric/index_value::numeric,2) DESC )
		FROM filtered_metrics fmtx
		JOIN interest_map map ON fmtx.interest_id::int=map.id
		ORDER BY 1
		)

		, max_avg_composition_cte AS (
		SELECT
			DISTINCT month_year,
			interest_name,
			avg_composition AS max_index_composition
		FROM avg_composition_cte
		WHERE row_number=1 AND month_year IS NOT NULL
		ORDER BY 1 
		)

		,moving_average_cte AS (
		SELECT
			month_year,
			interest_name,
			max_index_composition,
			ROUND(AVG(max_index_composition) OVER (ORDER BY month_year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS three_month_moving_average,
			LAG(interest_name,1) OVER (ORDER BY month_year)||': '||LAG(max_index_composition,1) OVER (ORDER BY month_year) AS one_month_ago,
			LAG(interest_name,2) OVER (ORDER BY month_year)||': '||LAG(max_index_composition,2) OVER (ORDER BY month_year) AS two_months_ago
		FROM max_avg_composition_cte
		)

		SELECT
		month_year,
		interest_name,
		max_index_composition,
		three_month_moving_average,
		one_month_ago,
		two_months_ago
		FROM moving_average_cte
		WHERE month_year BETWEEN '2018-09-01'::DATE AND '2019-08-01'::DATE

	SOLUTION 2:

		WITH cte_index_composition AS (
		SELECT
		    interest_metrics.month_year,
		    interest_map.interest_name,
		    ROUND(
		      (interest_metrics.composition / interest_metrics.index_value)::NUMERIC,
		      2
		    ) AS index_composition,
		    RANK() OVER (
		      PARTITION BY interest_metrics.month_year
		      ORDER BY interest_metrics.composition / interest_metrics.index_value DESC
		    ) AS index_rank
		FROM interest_metrics
		INNER JOIN interest_map ON interest_metrics.interest_id::int = interest_map.id
		WHERE interest_metrics.month_year IS NOT NULL
		)

		, final_output AS (
		SELECT
		  	month_year,
		  	interest_name,
		  	index_composition AS max_index_composition,
		  	ROUND(
		    	AVG(index_composition) OVER (
		      	ORDER BY month_year
		      	RANGE BETWEEN '2 MONTHS' PRECEDING AND CURRENT ROW), 2) AS "3_month_moving_avg",
		  	LAG(interest_name || ': ' || index_composition,1) OVER (ORDER BY month_year) AS "1_month_ago",
		  	LAG(interest_name || ': ' || index_composition, 2) OVER (ORDER BY month_year) AS "2_months_ago"
		FROM cte_index_composition
		WHERE index_rank = 1
		)

		SELECT * FROM final_output
		WHERE "2_months_ago" IS NOT NULL
		ORDER BY month_year;

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




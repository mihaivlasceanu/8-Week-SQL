
-- A. DATA EXPLORATION AND CLEANING

-- 1. Update the interest_metrics table by modifying the month_year column to be a date data type with the start of the month

-- SOLUTION 1:

ALTER TABLE interest_metrics
ALTER month_year TYPE DATE USING (TO_DATE(month_year,'MM-YYYY'))
								 

SELECT 
*
FROM interest_metrics
LIMIT 10;

-- 2. What is count of records in the interest_metrics for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?

SELECT
month_year,
COUNT(*)
FROM interest_metrics
GROUP BY 1
ORDER BY 1 NULLS FIRST

-- 3. What do you think we should do with these null values in the interest_metrics

SELECT
month_year,
COUNT(*),
ROUND(1.0*100*COUNT(*)/(SELECT COUNT(*)
						FROM interest_metrics),2) AS pct_of_total
FROM interest_metrics
WHERE month_year IS NULL
GROUP BY 1

-- Answer: We notice how records that have NULLs for month_year also have NULLs for interest_id and therefore are useless to us. What is more, seeing as the number of NULL values is below 10%, we might decide to simply remove them but it would be best to talk it out with our stakeholders beforehand.

-- 4. How many interest_id values exist in the interest_metrics table but not in the interest_map table? What about the other way around?

SELECT
COUNT(interest_id)
FROM interest_metrics
WHERE interest_id::int NOT IN (SELECT id FROM interest_map)

-- 0 values in interest_metrics and not in interest_map

SELECT
COUNT(id)
FROM interest_map
WHERE id NOT IN (SELECT interest_id::int FROM interest_metrics WHERE interest_id IS NOT NULL)

-- 7 values in interest_map and not in interest_metrics

-- SOLUTION 2:

SELECT
COUNT(DISTINCT interest_metrics.interest_id) AS all_interest_metric,
COUNT(DISTINCT interest_map.id) AS all_interest_map,
COUNT(CASE WHEN interest_map.id IS NULL THEN interest_metrics.interest_id ELSE NULL END) AS not_in_map,
COUNT(CASE WHEN interest_metrics.interest_id IS NULL THEN interest_map.id ELSE NULL END)  AS not_in_metrics
FROM interest_metrics
FULL OUTER JOIN interest_map
ON interest_metrics.interest_id::INT = interest_map.id;

-- 5. Summarise the id values in the interest_map by its total record count in this table

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

-- 6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where interest_id = 21246 in your joined output and include all columns from interest_metrics and all columns from interest_map except from the id column.

-- Answer: It depends on our approach. If we want to keep the NULL values previously identified, we will use a LEFT join, otherwise an INNER JOIN might be more advisable.

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

-- 7. Are there any records in your joined table where the month_year value is before the created_at value from the interest_map table? Do you think these values are valid and why?

-- SOLUTION 1:

SELECT
COUNT(*)
FROM interest_metrics mtx
JOIN interest_map map ON mtx.interest_id::int=map.id
WHERE month_year < created_at::date

-- SOLUTION 2:

SELECT   						 -- making sure there are no multiple entries per id value (static snapshot rather than a Slow Changing Dimension table)
id,
COUNT(*)
FROM interest_map
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


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

-- Answer: We have 188 such records but we must keep in mind that our month_year column was modified to show only the first day of each month. So the values are valid.
-- To check this:

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


-- B. INTEREST ANALYSIS

-- 1. Which interests have been present in all month_year dates in our dataset?

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

-- 2. Using this same total_months measure - calculate the cumulative percentage of all records starting at 14 months - which total_months value passes the 90% cumulative percentage value?

-- SOLUTION 1:

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

-- SOLUTION 2:

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

-- 3. If we were to remove all interest_id values which are lower than the total_months value we found in the previous question - how many total data points would we be removing?

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

-- 4. Does this decision make sense to remove these data points from a business perspective? Use an example where there are all 14 months present to a removed interest example for your arguments - think about what it means to have less months present from a segment perspective.

/* Answer: It would make sense to remove these data points since for one, 
   they represent less than 10% of all our records (roughly 110 out of 1200) and two, 
   by only analysing the interest_id's that appear for more than 6 months, 
   we can draw sturdier conclusions about our data. That being said, it might be a
   good idea to perform some additional analysis on these “rare” records just in case they provide 
   some vauable insights into the introduction of new interests.
*/

-- 5.A. After removing these interests - how many unique interests are there for each month?

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

-- 5.B. If we include all of our interests regardless of their counts - how many unique interests are there for each month?

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


-- C. SEGMENT ANALYSIS

-- 1. Using our filtered dataset by removing the interests with less than 6 months worth of data, which are the top 10 and bottom 10 interests which have the largest composition values in any month_year? Only use the maximum composition value for each interest but you must keep the corresponding month_year

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

-- 2. Which 5 interests had the lowest average ranking value?

-- SOLUTION 1 (for filtered dataset):

SELECT
interest_map.interest_name,
ROUND(AVG(filtered_metrics.ranking),1) AS average_ranking,
COUNT(*) AS record_count
FROm filtered_metrics 
JOIN interest_map ON filtered_metrics.interest_id::int=interest_map.id
GROUP BY 1
ORDER BY 2 
LIMIT 5

-- SOLUTION 2 (for full, unfiltered dataset):

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

-- 3. Which 5 interests had the largest standard deviation in their percentile_ranking value?

/* Included the max and min percentile ranking values (to get a feel for how drastic the changes 
   were in the ranking for these interests) and the record counts (to understand 
   how many data points for each interest we are dealing with)
*/

-- SOLUTION 1 (filtered dataset):

SELECT
interest_id,
interest_name,
ROUND(STDDEV(percentile_ranking)::numeric,2) AS stddev_pc_ranking,
MAX(percentile_ranking) AS max_pc_ranking,
MIN(percentile_ranking) AS min_pc_ranking,
COUNT(*) AS record_count
FROm filtered_metrics fmtx
JOIN interest_map map ON fmtx.interest_id::int=map.id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5

-- SOLUTION 2 (unfiltered dataset):

SELECT
interest_id,
interest_name,
ROUND(STDDEV(percentile_ranking)::numeric,1) AS stddev_pc_ranking,
MAX(percentile_ranking) AS max_pc_ranking,
MIN(percentile_ranking) AS min_pc_ranking,
COUNT(*) AS record_count
FROm interest_metrics mtx
JOIN interest_map map ON mtx.interest_id::int=map.id
WHERE mtx.month_year IS NOT NULL
GROUP BY 1,2
HAVING ROUND(STDDEV(percentile_ranking)::numeric,2) IS NOT NULL  -- otherwise it would show us NULL values
ORDER BY 3 DESC
LIMIT 5

-- 4. For the 5 interests found in the previous question - what was minimum and maximum percentile_ranking values for each interest and its corresponding year_month value? Can you describe what is happening for these 5 interests?

-- SOLUTION 1 (filtered dataset):

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

-- SOLUTION 2 (unfiltered dataset):

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

-- 5. How would you describe our customers in this segment based off their composition and ranking values? What sort of products or services should we show to these customers and what should we avoid?

/* Answer:  By comparing the min and max composition values for our dataset, 
			we can conclude that the customers are mostly interested in travel services, 
			sports (gym equipment), furniture and deluxe shopping. 
			At the other end of the spectrum, and somewhat predictably, they are 
			less interested in niche subjects. 
*/			
			

-- D. INDEX ANALYSIS
/*
The index_value is a measure which can be used to reverse calculate the average composition for Fresh Segments’ clients.

Average composition can be calculated by dividing the composition column by the index_value column rounded to 2 decimal places.
*/

-- 1. What are the top 10 interests by the average composition for each month?

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

-- 2. For all of these top 10 interests - which interest appears the most often?

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

-- 3. What is the average of the average composition for the top 10 interests for each month?

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

-- 4. What is the 3 month rolling average of the max average composition value from September 2018 to August 2019 and include the previous top ranking interests in the same output shown below.

-- SOLUTION 1:

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

-- SOLUTION 2:

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

DROP TABLE IF EXISTS Retail_sales;
CREATE TABLE RETAIL_SALES (
	TRANSACTIONS_ID INT PRIMARY KEY,
	SALE_DATE DATE,
	SALE_TIME TIME,
	CUSTOMER_ID INT,
	GENDER VARCHAR(15),
	AGE INT,
	CATEGORY VARCHAR(15),
	QUANTIY INT,
	PRICE_PER_UNIT FLOAT,
	COGS FLOAT,
	TOTAL_SALE FLOAT
);
alter table Retail_sales rename column QUANTIY to QUANTITY;

select * from Retail_sales;

SELECT
	COUNT(*)
FROM RETAIL_SALES

----------DATA CLEANING---------

SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

Delete  FROM Retail_sales
WHERE 
    transactionS_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

------Data Eploration------
--Q How many sales we have?

select count(*) as T_sale from retail_sales;

--Q How many uniuque customers we have ?
select count(distinct category) as Unique from retail_sales;

-------Data Nalysis & Business Key Problem-------

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT
	*
FROM
	RETAIL_SALES
WHERE
	SALE_DATE = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT
	*
FROM
	RETAIL_SALES
WHERE
	CATEGORY = 'Clothing'
	AND TO_CHAR(SALE_DATE, 'YYYY-MM') = '2022-11'
	AND QUANTITY >= 4

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
	CATEGORY,
	SUM(TOTAL_SALE) AS TS
FROM
	RETAIL_SALES
GROUP BY
	CATEGORY;
	
--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
	AVG(AGE) AS AVERAGE_AGE
FROM
	RETAIL_SALES
WHERE
	CATEGORY = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT
	*
FROM
	RETAIL_SALES
WHERE
	TOTAL_SALE > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
	CATEGORY,
	GENDER,
	COUNT(*) AS TOTAL_TRANS
FROM
	RETAIL_SALES
GROUP BY
	CATEGORY,
	GENDER
ORDER BY
	CATEGORY;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT
	YEAR,
	MONTH,
	AVGS
FROM
(
SELECT
	EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
	EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
	AVG(TOTAL_SALE) AS AVGS,
	RANK() OVER (PARTITION BY EXTRACT(YEAR FROM SALE_DATE)
	ORDER BY AVG(TOTAL_SALE) DESC) AS RNK
	FROM RETAIL_SALES
	GROUP BY 1,2
	) AS T1
WHERE
	RNK = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT
	CUSTOMER_ID,
	SUM(TOTAL_SALE) AS TS
FROM
	RETAIL_SALES
GROUP BY
	1
ORDER BY
	TS DESC
LIMIT
	5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
	COUNT(DISTINCT CUSTOMER_ID) AS UCUSTOMER,
	CATEGORY
FROM
	RETAIL_SALES
GROUP BY
	CATEGORY

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH
	HOURLY_SALE AS (
		SELECT
			*,
			CASE
				WHEN EXTRACT(
					HOUR
					FROM
						SALE_TIME
				) < 12 THEN 'MORNING'
				WHEN EXTRACT(
					HOUR
					FROM
						SALE_TIME
				) BETWEEN 12 AND 17  THEN 'AFTERNOON'
				ELSE 'EVENING'
			END AS SHIFT
		FROM
			RETAIL_SALES
	)
SELECT
	SHIFT,
	COUNT(*) AS ORDER_NOS
FROM
	HOURLY_SALE
GROUP BY
	SHIFT

-----End Project-----

	
























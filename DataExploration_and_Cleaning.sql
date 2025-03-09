-- Finding if there is any null values in the table 

SELECT * FROM retailsales -- Age, Quanity, Cogs, total_sales, price_per_unit columns has NULL values 
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Deleting all the NULL values from the TABLE 
DELETE FROM retailsales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Re-checking for NULL values - "NO NULL VALUES"
SELECT * FROM retailsales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Checking total number of records in the table 
SELECT COUNT(*) FROM retailsales -- 1987 records available.

-- 1. How many sales we have - 1987
SELECT COUNT(*) AS Total_sales FROM retailsales

-- 2. How many UNIQUE cusomers we have  - 155
SELECT COUNT(DISTINCT customer_id) AS Total_customers FROM retailsales

-- 3. How many UNIQUE categories we have - 3
SELECT DISTINCT category FROM retailsales

-- Data Analysis/Business problems solution
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retailsales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT *  FROM retailsales
WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantiy >= 3;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) netsale, COUNT(total_sale) totalOrder FROM retailsales    
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category, ROUND(AVG(AGE), 2) avg_age FROM retailsales
WHERE category = 'Beauty'
GROUP BY category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retailsales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(transactions_id) FROM retailsales
GROUP BY category, gender
ORDER BY category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * FROM (
	SELECT 
		EXTRACT(year FROM sale_date) AS year, 
		EXTRACT(month FROM sale_date) AS month, 
		AVG(total_sale) AS avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(year FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retailsales
	GROUP BY 1, 2
) AS t1
WHERE rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, SUM(total_sale) AS total_sale FROM retailsales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) uniquecustomer  FROM retailsales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales AS(
	SELECT *,
		CASE
			WHEN EXTRACT(Hour FROM sale_time) < 12  THEN 'Morning'
			WHEN EXTRACT(Hour FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
	FROM retailsales
) 
SELECT shift, COUNT(*) AS total_orders FROM hourly_Sales
GROUP BY shift;



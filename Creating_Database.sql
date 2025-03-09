-- Creating database and table for the project in pgadmin4(PostgresSQL)

CREATE DATABASE RetailSalesAnalysis;

-- Creating table 
DROP TABLE IF EXISTS RetailSales;
CREATE TABLE RetailSales(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(20),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT, -- cost
	total_sale FLOAT
);

-- Checking table is created or not
SELECT * FROM RetailSales; 

-- Importing dataset to the table 
-- GO TO default workspace and select the database you are working on and right click on the table just created and selct Import/Export data and import the data.
-----------------------------------------------------------------------------------------------------------------

-- Checking the table has all the data
SELECT * FROM RetailSales;

-- Total number records available in the dataset - "2000 records"
SELECT count(*) FROM retailsales;

-- Viewing the 10 records from the table
SELECT * FROM retailsales
LIMIT 10;

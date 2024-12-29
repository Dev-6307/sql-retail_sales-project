Create database  if not exists project;
use project;
select * from retail_sales_analysis;
select count(*) from retail_sales_analysis;
--
select * from retail_sales_analysis
where
ï»¿transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or 
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or 
cogs is null
or
total_sale is null;
-- Data Exploration
-- How many sales we have?
Select count(total_sale) from retail_sales_analysis;
-- How many unique customers we have?
select count(distinct(customer_id)) as unique_customers from retail_sales_analysis;
-- Data Analysis and Buisness problem
-- Write a SQL query to retrieve all columns for sales made on 2022-11-05
Select * from 
retail_sales_analysis
where sale_date = '2022-11-05';
-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select *
from retail_sales_analysis
where category = 'clothing'
and
sale_date BETWEEN '2022-11-01' AND '2022-11-30'
and 
quantity<=4; 
-- Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as net_sale,count(*) as total_orders
from retail_sales_analysis
group by category; 
-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select round(avg(age),0) as avg_age
from retail_sales_analysis
where category = 'Beauty';
-- Write a SQL query to find all transactions where the total_sale is greater than 1000
select * from retail_sales_analysis
where total_sale>1000;
-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
select gender,category, count(*) as total_transaction
from retail_sales_analysis
group by
category , gender
order by category;
-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from(
select
year(sale_date),
month(sale_date),
avg(total_sale),
rank()over(partition by year(sale_date) order by avg(total_sale) desc) as r_rank
from retail_sales_analysis
group by 1, 2
) as t1;
-- Write a SQL query to find the top 5 customers based on the highest total sales
select 
customer_id,
total_sale
from retail_sales_analysis
order by total_sale desc;
-- Write a SQL query to find the number of unique customers who purchased items from each category.
select 
count(distinct(customer_id)) as uni_cs,
category
from retail_sales_analysis
group by category;
-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales_analysis
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift















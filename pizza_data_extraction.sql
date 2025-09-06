-- Display Table

select *
from pizza_sales;

-- KPI
-- 1. Total Revenue

select round(SUM(total_price), 0) as total_revenue
from pizza_sales;

-- 2. Average Order Value

select round((SUM(total_price) / count(distinct order_id)), 2) as avg_order_value
from pizza_sales;

-- 3. Total Pizzas Sold

select SUM(quantity) as total_pizzas_sold 
from pizza_sales;

-- 4. Total Orders

select COUNT(distinct order_id) as total_orders
from pizza_sales;

-- 5. Average Pizzas Per Order

select cast(cast(SUM(quantity) as decimal(10,2)) / cast(COUNT(distinct order_id) as decimal(10,2)) as decimal(10,2)) as avg_pizzas_per_order
from pizza_sales;

-- Daily Trends

select DATENAME(DW, order_date) as order_day, COUNT(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(DW, order_date)
order by total_orders desc;

-- Hourly Trends
select DATEPART(HOUR, order_time) as order_hours, COUNT(distinct order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by total_orders desc

-- Monthly Trends

select DATENAME(MONTH, order_date) as order_month, COUNT(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(MONTH, order_date)
order by total_orders desc

-- % of Sales by Pizza Category

select pizza_category, SUM(total_price) as total_revenue, 
cast((SUM(total_price) * 100) / (select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT_category
from pizza_sales
group by pizza_category
order by PCT_category desc;

-- % of Sales by Pizza Size

select pizza_size, SUM(total_price) as total_revenue, 
cast((SUM(total_price) * 100) / (select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT_size
from pizza_sales
group by pizza_size
order by PCT_size desc;

-- Total Pizzas Sold by Pizza Category

select pizza_category, sum(quantity) as total_quantity_sold
from pizza_sales
group by pizza_category
order by total_quantity_sold desc;

-- Top 5 Pizzas by Revenue

select top 5 pizza_name, round(sum(total_price), 2) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc;

-- Bottom 5 Pizzas by Revenue

select top 5 pizza_name, round(sum(total_price), 2) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc;

-- Top 5 Pizzas by Quantity

select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_name
order by total_pizzas_sold desc;

-- Bottom 5 Pizzas by Quantity

select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_name
order by total_pizzas_sold asc;

-- Top 5 Pizzas by Total Orders

select top 5 pizza_name, COUNT(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc;

-- Bottom 5 Pizzas by Total Orders

select top 5 pizza_name, COUNT(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders asc;
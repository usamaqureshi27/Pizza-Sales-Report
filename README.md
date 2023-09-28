# Sales Data Analysis for Pizzeria
## Goal of the project
The goal is to analyze key indicators for a pizza sales data to gain insights into the business performance. The dataset contains information about name, orders, types etc. In the end, this analysis will help us find:
- Daily and Monthly trends.
- Percentage of Pizzas Sales by Pizza Size, Category.
- Best and Worst Pizzas by Revenue, Orders and Quantity.

A Dashboard from pizzeria data is developed using Power BI and the data analysis is done using SQL to answer above business objectives, while Excel will serve as first repository for data.

## Power BI Dashboard
The interactive Dashboards based upon Monthly/Daily sales and Best/Worst performance aspects from Jan 2015 to Dec 2015 of collected data is shown in image below while subsequent link is also attached below:
![Dashboard1](Media/pizza%20dashboard-1.jpg)
Click [here](pizza dashboard.pbix) for interactive Power BI dashboard.
![Dashboard2](Media/pizza%20dashboard-2.jpg)
Click [here](pizza dashboard.pbix) for interactive Power BI dashboard.

## Data Processing
Data has been processed and cleaned with the help of Excel and DAX in Power BQ by observing:

Check for missing data with the help of conditional formating
Remove duplicate rows
Correctly format columns for easy SQL analysis

## Analysis Approach
The following set of KPIs and consequent results will be stringed out from data.
Let’s load data into MS SQL server and check the first 5 rows to make sure it imported well.

```SQL
SELECT TOP 5 * 
FROM pizza_sales
```

### 1. KPI's Requirement
Following metrics have been calculated to gain sales information.

> To find the total revenue
```SQL
SELECT SUM (total_price) AS total_revenue
FROM pizza_sales
```

> To find the average order value
```SQL
SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) AS avg_order_values
FROM pizza_sales
```

> To find the total pizzas sold
```SQL
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
```

> To find the total orders
```SQL
SELECT COUNT(DISTINCT (order_id)) AS total_orders
FROM pizza_sales
```

> To find the average pizzas per orders
```SQL
SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
FROM pizza_sales
```
### 1. Graphs/Charts Requirement

> To find the daily trend for total orders
```SQL
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date) 
ORDER BY total_orders DESC
```

> To find the monthly trend for total orders
```SQL
SELECT DATENAME(Month, order_date) as month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(Month, order_date)
ORDER BY total_orders DESC
```

> To find the percentage of sales by pizza category
```SQL
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS pct
FROM pizza_sales
GROUP BY pizza_category
ORDER BY pct DESC
```

*for a specific month of a year*
```SQL
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE month(order_date) = 1) AS DECIMAL(10,2)) AS pct
FROM pizza_sales
WHERE month(order_date) = 1
GROUP BY pizza_category
ORDER BY pct DESC
```

> To find the percentage of sales by pizza size
```SQL
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2)) AS pct
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pct DESC
```
*for a specific quarter of a year*
```SQL
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS total_sales, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL (10,2)) AS pct
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY pct DESC
```

> To find the pizza solds by each pizza category
```SQL
SELECT pizza_category, SUM(quantity) AS total_pizzas
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizzas DESC
```

> To find top 5 best seller by revenue, quantity, and orders
```SQL
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL (10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
```

> To find bottom 5 best seller by revenue, quantity, and orders
```SQL
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL (10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders 
```

## Datasets Used
The datasets used:
+ Comes with 48,621 rows with 48,620 being pure data and the other one row being the column headers.
+ This Pizzeria sales data recorded for 1 whole year of 2015.
+ It contains the sales data of 21,350 orders.
+ Courtesy to **Data Tutorials** this data is publicly available [here](https://drive.google.com/drive/folders/17U0ah6Q4MJM_wIn_Xl4fHc-1fO6Q4s6z)

## Built with
+ SQL Server Management Studio
+ Power BI

## Authors
+ Usama Qureshi - [Github Profile](https://github.com/usamaqureshi27)
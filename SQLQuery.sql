SELECT * 
FROM pizza_sales

---
--1.
SELECT SUM (total_price) AS total_revenue
FROM pizza_sales

---
--2.
SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) AS avg_order_values
FROM pizza_sales

---
--3.
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales

---
--4.
SELECT COUNT(DISTINCT (order_id)) AS total_orders
FROM pizza_sales

---
--5.
SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
FROM pizza_sales

---
--6.
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date) 

---
--6.
SELECT DATENAME(Month, order_date) as month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(Month, order_date)
ORDER BY total_orders DESC

---
--7.
SELECT pizza_category, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE month(order_date) = 1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE month(order_date) = 1
GROUP BY pizza_category

---
--8.
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL (10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

---
--9.
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL (10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
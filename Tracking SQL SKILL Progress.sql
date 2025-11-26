-- Northwind Basic SQL Challenges

-- 1: List all customers
SELECT * FROM CUSTOMERS;

-- 2: List product names and prices -- Retrieve the ProductName and UnitPrice from the Products table.
SELECT productname, unitprice FROM products;

-- 3: Show CustomerID, CompanyName, and Country for customers whose country is Germany.
SELECT customerid, companyname, country
FROM customers
WHERE country = 'Germany';

-- 4: List all products ordered from most expensive to cheapest.
SELECT productname, unitprice AS price 
FROM products
ORDER BY unitprice DESC;

-- 5: Find all products that have UnitsInStock less than 10.
SELECT productname
FROM products
WHERE unitsinstock < 10;

-- 6: Show FirstName, LastName, and HireDate for employees hired after January 1, 1994.
SELECT firstname, lastname, hiredate
FROM employees
WHERE hiredate > '1994-01-01';

-- 7: List OrderID, OrderDate, and CompanyName for all orders, joining the Orders and Customers tables.
SELECT o.orderid, o.orderdate, c.companyname
FROM orders o
JOIN customers c 
ON o.customerid = c.customerid;

-- 8: Find the total number of products in the Products table.
SELECT COUNT(*) FROM products;

-- 9: For each order, calculate the total amount as (UnitPrice * Quantity) using the OrderDetails table.
SELECT productid, unitprice, quantity, ROUND(unitprice * quantity) AS TotalAmount
FROM order_details
ORDER BY productid;

-- 10:Find the product with the highest UnitPrice in the Products table.
SELECT productname, MAX(unitprice)
FROM products
GROUP BY productname 
LIMIT 1;

-- 11: Show all columns from the Suppliers table.
SELECT * FROM suppliers;

-- 12: Retrieve ProductName and UnitPrice for products in the “Beverages” category.
SELECT ProductName, UnitPrice
FROM products p
JOIN categories c 
ON p.categoryid = c.categoryid 
WHERE c.categoryname LIKE '%Beverage%';

-- 23: List OrderID, CustomerID, and ShippedDate for orders shipped by Speedy Express.
SELECT orderid, customerid, shippeddate
FROM ORDERs
WHERE shipname LIKE '%Speedy Express%';

-- 24: List CompanyName and Country for customers in either USA, UK, or Germany.
SELECT companyname, country
FROM customers 
WHERE country IN ('Germany', 'UK', 'Germany');

-- 25: Find all orders with OrderDate between 1996-07-01 and 1996-07-31.
SELECT * FROM orders 
WHERE orderdate >= '1996-07-01' AND orderdate <= '1996-07-31';

-- 26: Show ProductName and UnitsInStock for products with more than 50 units in stock ordered by unitsinstock in ascending order.
SELECT productname, unitsinstock 
FROM products
WHERE unitsinstock > 50 
ORDER BY unitsinstock ASC;

-- 27: For each category, count the number of products in that category.
SELECT c.categoryname, COUNT(p.ProductID) AS ProductCount 
FROM categories c
JOIN products p 
ON C.categoryid = P.categoryid
GROUP BY c.categoryname;

-- 28: For each product category, calculate the total sales amount (sum of UnitPrice * Quantity).
SELECT c.categoryname, SUM(od.unitprice * od.quantity) AS TotalSales
FROM categories c 
JOIN products p 
ON c.categoryid = p.categoryid 
JOIN order_details od
ON od.productid = p.productid
GROUP BY c.categoryname 
ORDER BY totalsales DESC;

-- ###Northwind SQL Joins Mastery: 10 Realistic Challenges with Conditions--

-- 29: Show OrderID, OrderDate, CustomerName, and EmployeeFullName for all orders placed after January 1, 1997, sorted by OrderDate descending.

SELECT o.orderid, o.orderdate, c.companyname AS customername, e.firstname || ' '  || e.lastname AS EmployeeFullName
FROM orders o
JOIN customers c 
ON c.customerid = o.customerid
JOIN employees e 
ON e.employeeid = o.employeeid
WHERE o.orderdate > '1997-01-01'
ORDER BY o.orderdate DESC;

-- 30: Show ProductName, CompanyName AS supplier, and Country for products where the supplier is located in the USA, ordered by ProductName.

SELECT p.productname, s.companyname AS Supplier, s.country
FROM products p 
JOIN suppliers s 
ON p.supplierid = s.supplierid 
WHERE s.country = 'USA'
ORDER BY p.productname;

-- 31: List OrderID, CustomerName, and ShipperName for all orders shipped by “United Package” for customers in Germany.

SELECT o.orderid, c.companyname AS customername, o.shipname AS ShipperName
FROM orders o
JOIN customers c 
ON c.customerid = o.customerid
WHERE o.shipname = 'United Package'
AND c.country = 'Germany';

-- 32: Show CustomerName and OrderCount for customers who placed at least 1 order in 1997, including customers with zero orders (use outer join), ordered by OrderCount descending.

SELECT c.companyname AS CustomerName, COUNT(o.orderid) AS Ordercount 
FROM customers c 
LEFT JOIN orders o 
ON c.customerid = o.customerid
AND EXTRACT(YEAR FROM o.orderdate) = 1997
GROUP BY c.companyname 
HAVING COUNT(o.orderid)>=0
ORDER BY COUNT(o.orderid) DESC;

-- 33: Join Products, OrderDetails, and Orders to list the top 5 products by total revenue (UnitPrice * Quantity) for orders in the last 12 months of data, ordered from highest to lowest.

SELECT p.productname, SUM(od.unitprice * od.quantity) AS total_reveneu 
FROM products p 
JOIN order_details od 
ON od.productid = p.productid
JOIN orders o 
ON od.orderid = o.orderid 
WHERE o.orderdate >= ( 
						SELECT MAX(orderdate) - INTERVAL '12 months'
						FROM orders)
GROUP BY p.productname 
ORDER BY total_reveneu DESC
LIMIT 5;

-- 34: Show OrderID, CustomerName, ShipperName, RequiredDate, and ShippedDate for orders shipped after the required date and where Freight > 50.

SELECT o.orderid, c.companyname AS customername, o.shipname AS ShipperName, o.requireddate, o.shippeddate
FROM orders o
JOIN customers c 
ON o.customerid = c.customerid
WHERE o.shippeddate > o.requireddate AND
o.freight >50;

-- 35: For each CategoryName, list the total number of orders and total revenue from orders placed after July 1, 1996. Only include categories with more than 10 orders (HAVING clause).

SELECT c.categoryname, COUNT(DISTINCT o.orderid) AS Total_Orders, SUM(od.unitprice * od.quantity) AS Total_Revenue
FROM categories c 
JOIN products p 
ON c.categoryid = p.categoryid 
JOIN order_details od 
ON p.productid = od.productid 
JOIN orders o 
ON o.orderid = od.orderid 
WHERE o.orderdate > DATE '1996-07-01'
GROUP BY c.categoryname 
HAVING COUNT(DISTINCT o.orderid) > 10
ORDER BY total_revenue DESC;

-- 36: List each employee’s FullName and the total number of orders they handled in 1997 for customers located in the USA, sorted by order count descending.

SELECT e.firstname || ' '|| e.lastname AS FullName, count(DISTINCT o.orderid) AS total_orders
FROM employees e 
JOIN orders o 
ON e.employeeid = o.employeeid 
WHERE shipcountry = 'USA' 
AND EXTRACT(YEAR FROM o.orderdate)=1997
GROUP BY fullname 
ORDER BY total_orders DESC;

-- 37: List all CustomerNames that start with the letter 'A'.
SELECT companyname AS customername
FROM customers
WHERE companyname ~'^A';

-- 38: Show ProductName, UnitPrice, and a new column PriceCategory: “Cheap” if UnitPrice < 20, “Moderate” if UnitPrice between 20 and 50, “Expensive” if UnitPrice > 50. Order by pricecategory.
SELECT productname, unitprice, 
		CASE 
			WHEN unitprice <= 20 THEN 'Cheap'
			WHEN unitprice > 20 AND unitprice <= 50 THEN 'Moderate'
			ELSE 'Expensive'
		END AS price_category
FROM products
ORDER BY price_category;

/*-- 39: Amber’s conglomerate acquired several companies, each with a hierarchical structure. Query each company_code with its founder and
 the total count of lead managers, senior managers, managers, and employees, sorted by company_code in ascending lexicographical order.*/

 SELECT c.company_code, c.founder, count(DISTINCT lm.lead_manager_code), count(DISTINCT sm.senior_manager_code), count(DISTINCT m.manager_code), count(DISTINCT e.employee_code)
FROM company AS c
JOIN lead_manager AS lm
ON c.company_code=lm.company_code
JOIN senior_manager sm
ON lm.company_code=sm.company_code
JOIN manager as m
oN sm.company_code=m.company_code
JOIN employee AS e
ON m.company_code=e.company_code
GROUP BY c.COMPANY_CODE, c.FOUNDER 
ORDER BY company_code ASC;


/* -- 40:Generate a report with Name, Grade, and Mark by joining the Students and Grade tables. Show student
 names for grades 8–10 ordered by descending grade and alphabetically for ties, and use 
 NULL as the name for grades below 8, ordering those rows by descending grade and ascending marks for ties.*/

SELECT 
    CASE 
        WHEN Grade >= 8 THEN s.Name
        ELSE NULL
    END AS Name,
    g.Grade,
    s.Marks
FROM Students s 
JOIN Grades g
ON s.marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY 
    g.Grade DESC,
    CASE 
        WHEN Grade >= 8 THEN Name
        ELSE Marks
    END ASC;


/* -- 41: Data Lemur Challenge: Write a query to rank the artists within each genre based on their revenue per member and extract the top revenue-generating artist 
 * from each genre. Display the output of the artist name, genre, concert revenue, number of members, and revenue per band member, sorted by 
 * the highest revenue per member within each genre.*/

WITH ranked_concerts_cte AS (
  SELECT 
    artist_name,
    genre, 
    concert_revenue,
    number_of_members, 
    (concert_revenue/number_of_members) as revenue_per_member,
    RANK() OVER (PARTITION BY genre
    ORDER BY (concert_revenue/number_of_members) DESC) AS ranked_concerts
  FROM concerts)
  
SELECT 
  artist_name,
  concert_revenue,
  genre,
  number_of_members,
  revenue_per_member
FROM ranked_concerts_cte
WHERE ranked_concerts = 1
ORDER BY revenue_per_member DESC;

                                      -- Northwind SQL Intermediate/Advanced Challenges --
-- Filtering & Conditions Challenges

-- 42: Orders in a specific range. Find all orders placed between January 1, 1997 and March 31, 1997, including OrderID, CustomerName, and OrderDate.

SELECT o.orderid, c.companyname AS CustomerName, o.orderdate
FROM orders o 
JOIN customers c 
ON o.customerid = c.customerid
WHERE o.orderdate BETWEEN '1997-01-01' AND '1997-03-31';

-- 42: Customers by pattern (regex. List customers whose names contain the word “Shop”. 
SELECT companyname AS customername
FROM customers
WHERE companyname ~* 'shop';

-- 43: Products in multiple conditions. Find products where UnitPrice > 30 AND UnitsInStock < 20.

SELECT productname
FROM products 
WHERE unitprice > 30 AND unitsinstock < 20;

-- 44: Suppliers from selected countries. Show suppliers from USA, UK, Germany, or France.

SELECT companyname, country
FROM suppliers
WHERE country IN ('USA', 'UK', 'Germany', 'FRANCE');

-- CASE Statements Challenges
-- 45: Classify employees by hire year. List employees with a column HirePeriod that shows: “Early” if hired before 1993, “Mid” if hired between 1993 and 1996, “Recent” if hired after 1996.
SELECT 
	firstname || ' ' || lastname AS Full_Name,
	CASE 
		WHEN EXTRACT(YEAR FROM hiredate) < 1993 THEN 'Early'
		WHEN EXTRACT(YEAR FROM hiredate) = 1993 THEN 'Mid'
		ELSE 'Recent'
	END AS HirePeriod 
FROM employees e;

-- 46: Product pricing tiers Show products with a column PriceTier: “Budget” (< 20), “Standard” (20–50), and “Premium” (> 50).
SELECT 
	productname,
	unitprice,
	CASE 
		WHEN unitprice < 20 THEN 'Budget'
		WHEN unitprice BETWEEN 20 AND 50 THEN 'Standard'
		ELSE 'Premium'
	END AS PriceTier
FROM products
ORDER BY pricetier;

-- Aggregations

-- 46: Sow each category’s average product price, floored with FLOOR(AVG(UnitPrice)). Only include categories where average price > 25.

SELECT c.categoryname, floor((AVG(p.unitprice))) AS avg_price
FROM categories c 
JOIN products p 
ON p.categoryid = c.categoryid 
GROUP BY c.categoryname 
HAVING AVG(p.unitprice ) > 25
ORDER BY avg_price DESC;

-- 47: For each shipper, calculate the average freight cost of orders, sorted descending.

SELECT shipname AS shipper, ROUND(AVG(freight)) AS avg_frieght_cost
FROM orders 
GROUP BY shipname 
ORDER BY AVG(freight) DESC;

-- Subqueries

-- 48: Find customers whose average order value is greater than the overall average order value.

SELECT 
	c.customerid,
	c.companyname AS customername,
	ROUND(AVG(od.unitprice * od.quantity)) AS Avg_order_value
FROM customers c
JOIN orders o
ON c.customerid = o.customerid
JOIN order_details od 
ON o.orderid = od.orderid
GROUP BY c.customerid , c.companyname 
HAVING AVG(od.unitprice * od.quantity ) > (
	SELECT AVG(cutomer_avg)
	FROM (
		SELECT AVG(od.unitprice * od.quantity) AS cutomer_avg
		FROM orders o 
		JOIN order_details od 
		ON o.orderid = od.orderid 
		GROUP BY o.customerid 
		) sub
) 
ORDER BY avg_order_value ;
	
-- 49: For each category, show the product with the highest UnitPrice.

SELECT 
	p.productid,
	p.productname,
	p.categoryid,
	c.categoryname,
	p.unitprice
FROM products p 
JOIN categories c 
	ON p.categoryid = c.categoryid
WHERE p.unitprice = (
	SELECT MAX(p2.unitprice)
	FROM products p2 
	WHERE p2.categoryid = p.categoryid)
ORDER BY c.categoryname;

-- We can also solve this challenge with CTE and Window function;
WITH RankedProducts AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        p.CategoryID,
        c.CategoryName,
        p.UnitPrice,
        RANK() OVER (PARTITION BY p.CategoryID ORDER BY p.UnitPrice DESC) AS PriceRank
    FROM Products p
    JOIN Categories c 
      ON p.CategoryID = c.CategoryID
)
SELECT 
    ProductID,
    ProductName,
    CategoryID,
    CategoryName,
    UnitPrice
FROM RankedProducts
WHERE PriceRank = 1
ORDER BY CategoryName;

-- 50: List employees who handled more orders than the average employee.
SELECT * FROM employees;
SELECT * FROM orders o ;

SELECT 
	e.employeeid,
	e.firstname || ' ' || e.lastname AS Fullname,
	COUNT(o.orderid) AS number_of_orders
FROM employees e 
JOIN orders o 
	ON e.employeeid = o.employeeid
GROUP BY e.employeeid
HAVING COUNT(o.orderid) > (
						SELECT AVG(order_per_employee.COUNT) 
						FROM (
							SELECT COUNT(orderid) AS count 
							FROM orders 
							GROUP BY employeeid
							) AS order_per_employee)
ORDER BY e.employeeid;

-- solving the challenge using CTE:
WITH employee_order_counts AS (
    SELECT
        e.employeeid,
        e.firstname || ' ' || e.lastname AS fullname,
        COUNT(o.orderid) AS number_of_orders
    FROM employees e 
    JOIN orders o 
        ON e.employeeid = o.employeeid
    GROUP BY e.employeeid, e.firstname, e.lastname
),
average_orders AS (
    SELECT 
        AVG(number_of_orders) AS avg_number_of_orders
    FROM employee_order_counts
)
SELECT 
    e.employeeid, 
    e.fullname,
    e.number_of_orders
FROM employee_order_counts e
CROSS JOIN average_orders a
WHERE e.number_of_orders > a.avg_number_of_orders
ORDER BY e.number_of_orders DESC;

-- 51: calculate cumulative revenue per month.

WITH monthly_sales AS (
	SELECT 
		EXTRACT(YEAR FROM o.orderdate) AS order_year,
		EXTRACT(MONTH FROM o.orderdate) AS order_month,
		ROUND(SUM(od.unitprice * od.quantity)) AS monthly_revenue
	FROM orders o 
	JOIN order_details od 
	ON o.orderid = od.orderid
	GROUP BY EXTRACT(YEAR FROM o.orderdate), EXTRACT(MONTH FROM o.orderdate)
)
SELECT 	
	order_year, 
	order_month,
	monthly_revenue,
	SUM(monthly_revenue) OVER (
		ORDER BY order_year, order_month) AS comulative_revenue
FROM monthly_sales
ORDER BY order_year, order_month;

-- 52: rank customers by total revenue and return the top 5.

SELECT 
	c.customerid, 
	c.companyname,
	ROUND(SUM(od.unitprice * od.quantity)) AS total_revenue
FROM customers c 
JOIN orders o 
	ON c.customerid = o.customerid
JOIN order_details od 
	ON o.orderid = od.orderid
GROUP BY c.customerid
ORDER BY SUM(od.unitprice * od.quantity) DESC 
LIMIT 5;

-- Using CTE with window function to get the same result
WITH top_customers AS (
	SELECT 
		customerid,
		companyname
	FROM customers
)
SELECT 
	tc.customerid,
	tc.companyname,
	RANK() OVER (ORDER BY SUM(od.unitprice * od.quantity) DESC) AS revenue_rank
FROM top_customers tc
JOIN orders o 
	ON o.customerid = tc.customerid 
JOIN order_details od 
	ON o.orderid = od.orderid
GROUP BY tc.customerid, tc.companyname 
LIMIT 5;
	
/* 53: Orders with revenue buckets
Use a CTE + CASE to classify orders into:

“Small” (< 1000)

“Medium” (1000–5000)

“Large” (> 5000)*/

WITH order_revenue AS (
	SELECT 
		o.orderid,
		c.customerid,
		c.companyname,
		ROUND(SUM(od.unitprice * quantity)) AS revenue
	FROM customers c
	JOIN orders o 
		ON o.customerid = c.customerid
	JOIN order_details od 
		ON o.orderid = od.orderid
	GROUP BY o.orderid, c.customerid, c.companyname 
	ORDER BY SUM(od.unitprice * quantity) DESC
)
SELECT 
	orderid,
	customerid,
	companyname,
	CASE 
		WHEN revenue < 1000 THEN 'Small'
		WHEN revenue >= 1000 AND revenue <= 5000 THEN 'Medium'
		ELSE 'Large'
	END AS reveneu_categories
FROM order_revenue;
	
/* 54: Late orders by category
Show categories where at least one order was shipped after the required date,
including CategoryName, TotalLateOrders.*/


SELECT 
	ca.categoryname, 
	COUNT(DISTINCT o.orderid) AS total_late_orders
FROM categories ca 
JOIN products p 
	ON ca.categoryid = p.categoryid
JOIN order_details od 
	ON p.productid = od.productid 
JOIN orders o 
	ON od.orderid = o.orderid
WHERE o.shippeddate > o.requireddate 
GROUP BY ca.categoryname
HAVING COUNT(DISTINCT o.orderid)>0
ORDER BY total_late_orders DESC;

/* 55: Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per 
 * user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.*/
	
SELECT 
  tweet_count AS tweet_bucket,
  COUNT(*) AS users_num
FROM (
  SELECT 
    user_id,
    COUNT(*) AS tweet_count
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
) AS user_tweet_counts
GROUP BY tweet_count
ORDER BY tweet_bucket;

/* 56: Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query
  to find the number of days between each user’s first post of the year and last post of the year 
 in the year 2021. Output the user and number of the days between each user's first and last post.*/
WITH date_col AS (
  SELECT
    user_id,
    post_date::DATE AS dates,
    post_id
  FROM posts
)

SELECT 
  user_id,
  MAX(dates) - MIN(dates) AS days_between
FROM date_col
WHERE EXTRACT(YEAR FROM dates) = 2021
GROUP BY user_id
HAVING COUNT(post_id)>1;

/* 57: Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft 
 * Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent.
 *  Output the results in descending order based on the count of the messages.*/

SELECT 
  sender_id,
  count(sender_id) as message_count
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = 08
  AND EXTRACT(YEAR FROM sent_date) = 2022
GROUP BY sender_id
ORDER BY COUNT(sender_id) DESC
LIMIT 2;

/* 58: Given a table containing information about bank deposits and withdrawals made using Paypal, write 
 * a query to retrieve the final account balance for each account, taking into account all the 
 * transactions recorded in the table with the assumption that there are no missing transactions.*/
WITH deposits AS (
  SELECT account_id, sum(amount) as amount FROM transactions
  WHERE transaction_type = 'Deposit'
  GROUP BY account_id),

withdrawals AS (
  SELECT account_id, sum(amount) as amount FROM transactions
  WHERE transaction_type = 'Withdrawal'
  GROUP BY account_id)
  
SELECT 
  d.account_id,
  (d.amount) - (w.amount) AS final_balance
FROM deposits as d
JOIN withdrawals as w
ON d.account_id = w.account_id
GROUP BY d.account_id, d.amount, w.amount
;

/* 59: Assume you have an events table on Facebook app analytics. Write a query to calculate the click-through rate (CTR) 
 * for the app in 2022 and round the results to 2 decimal places.

Definition and note:

Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
To avoid integer division, multiply the CTR by 100.0, not 100.*/

SELECT
  app_id,
  ROUND(100.0 *
    SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2)  AS ctr_rate
FROM events
WHERE timestamp >= '2022-01-01' 
  AND timestamp < '2023-01-01'
GROUP BY app_id;

/* 60: Assume you're given tables with information about TikTok user sign-ups and confirmations through 
 * email and text. New users on TikTok sign up using their email addresses, and upon sign-up, each user 
 * receives a text message confirmation to activate their account.

Write a query to display the user IDs of those who did not confirm their sign-up on the first day, 
but confirmed on the second day.*/

SELECT 
  user_id
FROM emails e 
INNER JOIN texts t 
ON e.email_id = t.email_id
WHERE t.signup_action = 'Confirmed'
AND t.action_date =  e.signup_date + INTERVAL '1 day';

/* 61:IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees. 
 * The objective is to generate data to populate a histogram that shows the number of unique queries run by employees 
 * during the third quarter of 2023 (July to September). Additionally, it should count the number of employees who did not 
 * run any queries during this period.

Display the number of unique queries as histogram categories, along with the count of employees who executed that 
number of unique queries.*/

WITH employee_queries AS (
  SELECT 
    e.employee_id,
    COALESCE(COUNT(DISTINCT q.query_id), 0) AS unique_queries
  FROM employees AS e
  LEFT JOIN queries AS q
    ON e.employee_id = q.employee_id
      AND q.query_starttime >= '2023-07-01T00:00:00Z'
      AND q.query_starttime < '2023-10-01T00:00:00Z'
  GROUP BY e.employee_id
)

SELECT
  unique_queries,
  COUNT(employee_id) AS employee_count
FROM employee_queries
GROUP BY unique_queries
ORDER BY unique_queries;

/* 62: Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, 
 * you're analyzing how many credit cards were issued each month.

Write a query that outputs the name of each credit card and the difference in the number of issued cards 
between the month with the highest issuance cards and the lowest issuance. Arrange the results based on the largest disparity. */

WITH flex AS (
  SELECT 
    card_name,
    MAX(issued_amount) - MIN(issued_amount) AS difference
  FROM monthly_cards_issued
  WHERE card_name = 'Chase Freedom Flex'
  GROUP BY card_name
), 

reserve AS (
  SELECT 
    card_name,
    MAX(issued_amount) - MIN(issued_amount) AS difference
  FROM monthly_cards_issued
  WHERE card_name = 'Chase Sapphire Reserve'
  GROUP BY card_name
)

SELECT 
  card_name, 
  difference
FROM reserve
UNION ALL 
SELECT 
  card_name,
  difference
FROM flex;

/* 63: You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using 
 * tables which includes information on the count of items in each order (item_count table) and the 
 * corresponding number of orders for each item count (order_occurrences table).*/

WITH orders AS (
  SELECT 
    SUM(item_count * order_occurrences) as total_items,
    SUM(order_occurrences) total_orders
  FROM items_per_order
) 

SELECT 
  ROUND(CAST(total_items AS DECIMAL)/total_orders, 1) AS mean
FROM orders;

/* 64: CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. 
 * Each drug is exclusively manufactured by a single manufacturer.

Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and 
calculate the total amount of losses incurred.

Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value.
 Display the results sorted in descending order with the highest losses displayed at the top.*/

SELECT 
  manufacturer,
  COUNT(drug) as drug_count,
  ABS(SUM(total_sales - cogs)) AS total_loss
FROM pharmacy_sales
WHERE total_sales - cogs <= 0
GROUP BY manufacturer
ORDER BY total_loss DESC;

/* 65: CVS Health wants to gain a clearer understanding of its pharmacy sales and the performance of various products.

Write a query to calculate the total drug sales for each manufacturer. Round the answer to the nearest million and
 report your results 
in descending order of total sales. In case of any duplicates, sort them alphabetically by the manufacturer name.

Since this data will be displayed on a dashboard viewed by business stakeholders, please format your results as 
follows: "$36 million".*/

SELECT 
  manufacturer,
  concat('$' , round(SUM(total_sales/1000000)) , ' million') AS sales
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;

-- 66: Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.
WITH user_transaction AS (
  SELECT 
    user_id, 
    spend,
    transaction_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rn 
  FROM transactions
)

SELECT 
  user_id,
  spend,
  transaction_date
FROM user_transaction
WHERE 
  rn = 3;

/* 67: Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding
 *  the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.*/

SELECT DISTINCT salary AS second_highest_salary
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

/* 68: Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

Notes:

A rolling average, also known as a moving average or running mean is a time-series technique that examines trends in data over a specified period of time.
In this case, we want to determine how the tweet count for each user changes over a 3-day period.*/

select 
  user_id, 
  tweet_date,
  ROUND(AVG(tweet_count) OVER (
    PARTITION BY user_id 
    ORDER BY tweet_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) as rolling_avg_2d
FROM tweets;

/*69: Assume you're given a table containing data on Amazon customers and their spending on products in different 
 * category, write a query to identify the top two highest-grossing products within each category in the year 2022.
 *  The output should include the category, product, and total spend. */


WITH ranked_spending AS (
  SELECT 
    category,
    product,
    SUM(spend) AS total_spend,
    RANK() OVER (
    PARTITION BY category
    ORDER BY SUM(spend) DESC) AS ranking
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)

SELECT 
  category,
  product,
  total_spend
FROM ranked_spending
WHERE ranking <=2
ORDER BY category, ranking

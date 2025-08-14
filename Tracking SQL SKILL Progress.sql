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

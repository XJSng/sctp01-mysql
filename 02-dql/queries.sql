-- Works for the `classicmodels` database

-- Show all employees
SELECT * FROM employees
-- Use the `*` for all columns

-- Select just the firstName, lastName and email from all employees?
SELECT firstName, lastName, email FROM employees;

-- Select and rename the columns (for view sake)
SELECT firstName AS "First Name", lastName AS "Last Name", email AS "Email" FROM employees;

-- Get all employees from officeCode 1
SELECT * FROM employees WHERE officeCode=1;
-- This will match only officeCode 1 and nothing else

-- Get all customers from USA and show their contact firstName, contactLastName, and name
SELECT contactFirstName, contactLastName, customerName, country FROM customers WHERE country = "USA"
-- Note that "usa" is not case sensetive

-- Select all employees where jobTitle is "<anything>sales"
SELECT * FROM employees WHERE jobTitle LIKE "%sales"
-- `LIKE` Is a special keyword that allows user to use wildcard symbols like `%`
-- The Wildcard `%` allows users to search any jobTitle with the sales keyword before

-- Select all employees where jobTitle is "sales<anything>"
SELECT * FROM employees WHERE jobTitle LIKE "sales%"

-- Select all employees where jobTitle is "<anything>sales<anything>"
SELECT * FROM employees WHERE jobTitle Like "%sales%"

-- ADD IT ALL TOGETHER
-- Find all orders which mentions the word "shipping" in the comments
-- and display their orderNumber, status and comments
SELECT orderNumber, status, comments FROM orders WHERE comments LIKE "%shipping%"

-- Get employees from officeCode 1 or from officeCode 2
SELECT firstName, lastName, officeCode FROM employees WHERE officeCode = 1 OR officeCode = 2;
SELECT firstName, lastName, officeCode FROM employees WHERE officeCode IN (1, 2);
-- The IN keyword is similar to the include method in JavaScript which looks in a column and finds the value

-- Get ONLY Sales reps from officeCode 1 or from officeCode 2
SELECT firstName, lastName, officeCode, jobTitle FROM employees WHERE jobTitle LIKE "Sales Rep" AND (officeCode IN (1,2));

-- Get customers from NV in USA who have more than 5000 credit limit
SELECT * FROM customers WHERE state="NV" AND country ="usa" AND creditLimit > 5000;

-- All customers from either Singapore or USA,
-- and at the same time have less than 10K credit limit
SELECT * FROM customers WHERE (country IN ("Singapore", "USA")) AND creditLimit < 10000
-- OR 
SELECT * FROM customers WHERE (country="USA" OR country="Singapore") AND creditLimit < 10000;

-- Show the first name, last name of each employee, and their office address
SELECT firstName, lastName, addressLine1, addressLine2, employees.officeCode
FROM employees JOIN offices
ON employees.officeCode = offices.officeCode;
-- Because both employees and offices have an officeCode,
-- It is important to select which officeCode you would like to view

-- THE THREE KINDS OF JOIN
-- INNER JOIN - standard: only included in the result if there is a matching row on the other TABLE
-- Find customers and their first name, last name and email of their sales reps
SELECT firstName, lastName, email, employees.employeeNumber FROM customers JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber;

-- See the above but only for customers from USA
SELECT firstName, lastName, email, employees.employeeNumbe, country
FROM customers JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE country = "USA";

-- LEFT OUTER JOIN - ALL ROWS ON THE LEFT HAND SIDE WILL BE INCLUDED
-- All customers will be included regardless of whether they have a sales rep or not
SELECT  customerName, firstName AS "Sales Rep First Name", lastName AS "Sales Rep Last Name"
FROM customers LEFT JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber;
-- NOTE that some customers will not have any sales rep and null values

-- RIGHT OUTER JOIN - ALL ROWS ON THE RIGHT HAND SIDE WILL BE INCLUDED
-- All sales reps will be included regardless of whether they have customers or not
SELECT  customerName, firstName AS "Sales Rep First Name", lastName AS "Sales Rep Last Name"
FROM customers RIGHT JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber;
-- It rarely makes sense to use this method as it is a reverse of the left join method

-- GET the current date
SELECT CURDATE();
-- Will return today's day in the  ISO STANDARD FORMAT YYYY-MM-DD

-- Get all payments after 30th June 2003
SELECT * FROM payments WHERE paymentDate > "2003-06-30";

-- Get all payments in the year off 2003 
SELECT * FROM payments WHERE paymentDate >= "2003-01-01" AND paymentDate <= "2003-12-31";

-- Get all payments in a specific month (June 2003)
SELECT * FROM payments WHERE YEAR(paymentDate) = "2003" AND MONTH(paymentDate) = "6";

-- Get all payments in a specific year (2004)
SELECT * FROM payments WHERE YEAR(paymentDate) = "2004";

-- Get all payments in a specific month (May)
SELECT * FROM payments WHERE MONTH(paymentDate) = "5";

-- AGGREGATION
-- AGGREGATION functions allow us to summarise the entire table
-- SUM(), MIN(), MAX(), AVG(), COUNT()
SELECT COUNT(*) FROM employees; -- 23
SELECT AVG(amount) FROM payments; -- 32431.645531

-- DISTINCT
-- Show unique values with distinct
SELECT DISTINCT(officeCode) FROM employees;

-- SORTING 
SELECT customerName, creditLimit FROM customers ORDER BY creditLimit; -- orders from lowest to highest
-- To reverse the order use DESC (stands for descending)
SELECT customerName, creditLimit FROM customers ORDER BY creditLimit DESC; -- orders from highest to lowest

-- GROUP BY
-- The GROUP BY function is often used with an AGGREGATE function
-- It groups together a column and executes the chosen aggregate function on that group
-- QUESTION: For each office, show their state and country,
-- And how many employees there are
SELECT employees.officeCode, state, country, count(*) AS "Total Employees"  -- ORDER 4
FROM employees -- ORDER 1
JOIN offices  -- ORDER 2
ON employees.officeCode = offices.officeCode -- ORDER 2
GROUP BY officeCode -- ORDER 3

-- How to go about solving SQL problems
-- QUESTION: Show the average credit limit of each country
-- 1. which table(s) will give us the info we want (if > 1 table, need to JOIN)
-- 2  what do we want to group by?
-- 3. SELECT ???? FROM <table name> GROUP BY <criteria to group by>
-- 4. What do I want from each group: MIN, MAX, AVG, SUM, COUNT
-- 5. Whatever you group by, you also must select (vice visera) excpet the aggregation
SELECT AVG(creditLimit), country FROM customers
GROUP BY country
-- Question 1
SELECT country as "Country",
    city as "City",
    phone as "Phone"
FROM offices;

-- Question 2  Find all rows in the orders table that mentions "FedEx" in the comments.
SELECT *
FROM orders
WHERE comments LIKE "%fedex%";

-- Question 3 - Show the contact first name and contact last name of all customers in descending order by the customer's name
SELECT customerName AS "Customer Name",
    contactFirstName AS "First Name",
    contactLastName AS "Last Name"
FROM customers
ORDER BY customerName desc;

-- Question 4 - Find all sales rep who are in office code 1, 2 or 3 and their first name or last name contains the substring 'son'
SELECT *
FROM employees
WHERE officeCode IN (1, 2, 3)
    AND (
        (firstName LIKE '%son%')
        OR (lastName LIKE '%son%')
    )
    AND (jobTitle = 'Sales Rep');

-- 5 - Display all the orders bought by the customer with the customer number 124, along with the customer name, the contact's first name and contact's last name.
SELECT customerName AS "Customer Name",
    contactFirstName AS "First Name",
    contactLastName AS "Last Name",
    orders
FROM customers
    join orders on customer.customerNumber = order.customerNumber
WHERE customer.customerNumber = 124 

-- 6 - Show the name of the product, together with the order details, for each order line from the order details table
SELECT orderLineNumber, productCode, productName, quantityOrdered, priceEach
FROM products
    JOIN orderdetails ON products.productCode = orderdetails.productCode

 -- 7 - Display sum of all the payments made by each company from the USA. 
SELECT sum(amount),
    country
FROM payments
    JOIN customers ON payments.customerNumber = customers.customerNumber
WHERE country = "usa"
GROUP BY customers.country;

-- 8 - Display all orders made by customers from the USA and UK
SELECT orderNumber, country , orderDate, requiredDate, shippedDate, status, comments, orders.customerNumber FROM customers JOIN orders
ON customers.customerNumber = orders.customerNumber
GROUP BY orderNumber
HAVING country IN ("USA", "UK")


-- 9 - Show how many employees are there for each state in the USA		
SELECT country, state, count(employeeNumber) AS "Employee Count" FROM employees JOIN offices
ON employees.officeCode = offices.officeCode
WHERE country = "USA"
GROUP BY state

-- 10 - Display the number of orders made, per month, between Jan 2003 and Dec 2003
SELECT monthname(orderDate) as "Month", year(orderDate) AS "YEAR", count(orderNumber) FROM orders 
WHERE year(orderDate) = "2003"
GROUP BY month(orderDate)

-- 11 - From the payments table, display the average amount spent by each customer. Display the name of the customer as well.
SELECT payments.customerNumber, customerName, SUM(amount)FROM payments JOIN customers
ON payments.customerNumber = customers.customerNumber
GROUP BY payments.customerNumber

-- 12  - How many products are there in each product line?
SELECT productLine, COUNT(productLine) FROM products
GROUP BY productLine;

-- 13 - From the payments table, display the average amount spent by each customer but only if
-- The customer has spent a minimum of average 10,000 dollars.
SELECT payments.customerNumber, customerName, AVG(amount) FROM payments JOIN customers
ON payments.customerNumber = customers.customerNumber
GROUP BY customerNumber
HAVING AVG(amount) > 10000;

-- 14  - For each product, display how many times it was ordered, and display the results with the most orders first and only show the top ten.
SELECT productName, SUM(quantityOrdered)  FROM products JOIN orderdetails
ON products.productCode = orderdetails.productCode
GROUP BY productName
ORDER BY SUM(quantityOrdered) DESC
LIMIT 10;
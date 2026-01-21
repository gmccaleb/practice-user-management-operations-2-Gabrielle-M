START TRANSACTION;

DROP table if exists orders, customers;

CREATE table customers (
id int primary key auto_increment,
first_name varchar(50),
last_name varchar(50)
);
CREATE table orders (
id int primary key,
customer_id int null,
order_date date,
total_amount decimal(10,2),
foreign key (customer_id) references customers(id)
);
INSERT into customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');
INSERT into orders (id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

SELECT * from orders;
SELECT * from customers;

-- Task 1: use GROUP BY to find the total amount spent by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- Task 2: use GROUP BY to find the total amount spent by each customer and include order date
SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, order_date;

-- Task 3: use GROUP BY to find the total amount spent by each customer, using WHERE to only include orders over $200
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount > 200
GROUP BY customer_id;

-- Task 4: use GROUP BY to find the total amount spent by each customer, using HAVING to include orders over $200
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;

-- Task 5: use INNER JOIN to join the orders table with the customers table on the customer_id column in the orders table 
-- & the id column in the customers table
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

-- Task 6: use LEFT JOIN to join the orders table with the customers table on the customer_id column in the orders table 
-- & the id column in the customers table
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

-- Task 6: return all orders where the total_amount is greater than or equal to the average total_amount of all orders
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (SELECT AVG(total_amount) FROM orders); 

-- Task 7: return all orders where the customer_id is in the list of id values of customers with the last name 'Smith' using IN
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');

-- Task 8: use FROM to return all the order_date values from the orders table
SELECT order_date
FROM (SELECT id, order_date, total_amount FROM orders) AS order_summary;

COMMIT;

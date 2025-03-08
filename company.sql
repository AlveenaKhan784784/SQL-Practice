CREATE DATABASE company;
USE company;

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
name VARCHAR(50),
total_spent DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    );
    
INSERT INTO Customers (customer_id, name, total_spent) VALUES
(1, 'Alice', 500),
(2, 'Bob', 1200),
(3, 'Charlie', 800),
(4, 'David', 1500),
(5, 'Eve', 300);

SELECT * FROM customers;

INSERT INTO Orders (order_id, customer_id, amount, order_date) VALUES
(101, 1, 100, '2024-03-01'),
(102, 2, 500, '2024-03-02'),
(103, 3, 200, '2024-03-03'),
(104, 4, 1000, '2024-03-04'),
(105, 5, 150, '2024-03-05'),
(106, 2, 700, '2024-03-06'),
(107, 3, 600, '2024-03-07');

SELECT * FROM Orders;

SELECT customer_id, name, total_spent
FROM customers WHERE 
total_spent > (SELECT AVG(total_spent) FROM customers);

SELECT customer_id, name
FROM customers 
WHERE customer_id IN(
SELECT customer_id 
FROM Orders 
GROUP BY customer_id 
HAVING COUNT(order_id)>1
);

WITH CustomerSpending AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM Orders
    GROUP BY customer_id
)
SELECT * FROM CustomerSpending
ORDER BY total_spent
LIMIT 3;

WITH TotalOrders AS (
SELECT customer_id, COUNT(order_id) AS total_order
FROM Orders
GROUP BY customer_id
)
SELECT C.name, O.total_order
FROM customers C
JOIN TotalOrders O ON C.customer_id = O.customer_id;

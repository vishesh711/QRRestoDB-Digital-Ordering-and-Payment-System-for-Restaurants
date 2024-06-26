--1. List of all the restaurants that are currently open, along with their opening and closing times.

SELECT restaurants.name AS restaurant_name, restaurants.opening_time, restaurants.closing_time
FROM restaurants
WHERE restaurants.status = 'open';


--2. Which food items have been ordered the most, and how many times have they been ordered?

SELECT food_items.name AS food_item_name, COUNT(order_items.id) AS order_count
FROM order_items
JOIN food_items ON order_items.food_item_id = food_items.id
GROUP BY food_items.name
ORDER BY order_count DESC;


--3. List the names of users who have given feedback with a star rating of 5 for any restaurant.

SELECT DISTINCT users.name
FROM feedbacks
JOIN users ON feedbacks.user_id = users.id
WHERE feedbacks.star_rating = 5;


--4. Find the average star rating for each restaurant.

SELECT restaurants.name AS restaurant_name, AVG(feedbacks.star_rating) AS average_rating
FROM feedbacks
JOIN restaurants ON feedbacks.restaurant_id = restaurants.id
GROUP BY restaurants.name;


--5. Retrieve all the orders along with their associated user name, restaurant name, and total amount, filtered by a specific date range.

SELECT orders.id AS order_id, users.name AS user_name, restaurants.name AS restaurant_name, orders.total_amount
FROM orders
JOIN users ON orders.user_id = users.id
JOIN restaurants ON orders.restaurant_id = restaurants.id
WHERE orders.created_at BETWEEN '2024-01-01' AND '2024-12-31';


--6. Get the total sales amount for each restaurant by summing the total_amount from orders.

SELECT restaurants.name AS restaurant_name, SUM(orders.total_amount::numeric) AS total_sales
FROM orders
JOIN restaurants ON orders.restaurant_id = restaurants.id
GROUP by restaurants.name;


--7. Which 'tables' in which 'Restaurants' are currently occupied?

SELECT restaurants.name AS restaurant_name, tables.name AS table_name, tables.table_no
FROM tables
JOIN restaurants ON tables.restaurant_id = restaurants.id
WHERE tables.status = 'occupied';


--8. Find the total amount spent by each user across all their orders.

SELECT users.name AS user_name, SUM(CAST(orders.total_amount AS NUMERIC)) AS total_spent
FROM orders
JOIN users ON orders.user_id = users.id
GROUP BY users.name
ORDER BY total_spent DESC;


--9. List the names of the top 5 most expensive food items available.

SELECT food_items.name AS food_item_name, CAST(food_items.price AS NUMERIC) AS item_price
FROM food_items
ORDER BY item_price DESC
LIMIT 5;


--10. Show the restaurant and user details for orders that have not been paid.

SELECT orders.id AS order_id, restaurants.name AS restaurant_name, users.name AS user_name, orders.total_amount
FROM orders
JOIN restaurants ON orders.restaurant_id = restaurants.id
JOIN users ON orders.user_id = users.id
WHERE orders.is_paid = FALSE;

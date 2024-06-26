# RestoDB-Digital-Ordering-and-Payment-System-for-Restaurants

This repository contains the SQL scripts and documentation for the Restaurant Management Database. The database is designed to manage information related to restaurants, menus, food items, orders, users, and more.

## Table of Contents

1. [Introduction](#introduction)
2. [Database Schema](#database-schema)
3. [Entities and Relationships](#entities-and-relationships)
4. [SQL Scripts](#sql-scripts)
5. [Usage](#usage)
6. [Contributing](#contributing)
7. [License](#license)

## Introduction

The Restaurant Management Database is designed to handle various operations and data for restaurants, including user management, order processing, menu management, and feedback collection. This database schema supports complex queries and operations needed to manage a restaurant efficiently.

## Database Schema

### users
- **id** (UUID): Unique identifier for each user.
- **name** (VARCHAR): Name of the user.
- **phone_number** (VARCHAR): Phone number of the user.
- **email** (VARCHAR): Email of the user, must be unique.
- **otp** (VARCHAR): One-time password for verification.
- **is_verified** (BOOLEAN): Verification status of the user.
- **created_at** (TIMESTAMP): Timestamp when the user was created.
- **updated_at** (TIMESTAMP): Timestamp when the user details were last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the user was deleted (soft delete).

### restaurants
- **id** (UUID): Unique identifier for each restaurant.
- **name** (VARCHAR): Name of the restaurant, cannot be null.
- **logo_url** (VARCHAR): URL of the restaurant's logo.
- **opening_time** (TIMESTAMP): Opening time of the restaurant.
- **closing_time** (TIMESTAMP): Closing time of the restaurant.
- **status** (TEXT): Status of the restaurant, must be 'open' or 'closed'.
- **operating_days** (JSONB): JSONB field to store operating days.
- **phone_number** (VARCHAR): Phone number of the restaurant.
- **email** (VARCHAR): Email of the restaurant, must be unique.
- **encrypted_password** (TEXT): Encrypted password of the restaurant's account.
- **password_hash** (TEXT): Hash of the restaurant's password.
- **created_at** (TIMESTAMP): Timestamp when the restaurant was created.
- **updated_at** (TIMESTAMP): Timestamp when the restaurant details were last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the restaurant was deleted (soft delete).

### menu
- **id** (UUID): Unique identifier for each menu.
- **name** (VARCHAR): Name of the menu.
- **restaurant_id** (UUID): Identifier of the restaurant the menu belongs to.
- **created_at** (TIMESTAMP): Timestamp when the menu was created.
- **updated_at** (TIMESTAMP): Timestamp when the menu was last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the menu was deleted (soft delete).

### courses
- **id** (UUID): Unique identifier for each course.
- **name** (VARCHAR): Name of the course.
- **restaurant_id** (UUID): Identifier of the restaurant the course belongs to.
- **created_at** (TIMESTAMP): Timestamp when the course was created.
- **updated_at** (TIMESTAMP): Timestamp when the course was last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the course was deleted (soft delete).

### food_items
- **id** (UUID): Unique identifier for each food item.
- **custom_id** (VARCHAR): Custom identifier for the food item.
- **name** (VARCHAR): Name of the food item.
- **menu_id** (UUID): Identifier of the menu the food item belongs to.
- **restaurant_id** (UUID): Identifier of the restaurant the food item belongs to.
- **description** (TEXT): Description of the food item.
- **price** (VARCHAR): Price of the food item.
- **food_img_url** (VARCHAR): URL of the food item's image.
- **dietary_restriction** (TEXT): Dietary restriction of the food item (must be 'veg', 'non_veg', or 'egg').
- **is_featured** (BOOLEAN): Indicates if the food item is featured.
- **spicy_rating** (INT): Spicy rating of the food item.
- **status** (TEXT): Stock status of the food item (must be 'in_stock' or 'out_of_stock').
- **created_at** (TIMESTAMP): Timestamp when the food item was created.
- **updated_at** (TIMESTAMP): Timestamp when the food item was last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the food item was deleted (soft delete).

### food_item_courses
- **id** (UUID): Unique identifier for each record.
- **name** (VARCHAR): Name of the food item course relationship.
- **course_id** (UUID): Identifier of the course.
- **food_item_id** (UUID): Identifier of the food item.
- **created_at** (TIMESTAMP): Timestamp when the record was created.
- **updated_at** (TIMESTAMP): Timestamp when the record was last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the record was deleted (soft delete).

### orders
- **id** (UUID): Unique identifier for each order.
- **custom_order_id** (VARCHAR): Custom identifier for the order.
- **restaurant_id** (UUID): Identifier of the restaurant the order was placed at.
- **user_id** (UUID): Identifier of the user who placed the order.
- **total_amount** (VARCHAR): Total amount of the order.
- **table_id** (UUID): Identifier of the table the order was placed at.
- **invoice_url** (VARCHAR): URL of the order invoice.
- **is_paid** (BOOLEAN): Indicates if the order has been paid.
- **status** (TEXT): Status of the order (must be 'order_placed', 'confirmed', 'in_process', 'completed', or 'deleted').
- **created_at** (TIMESTAMP): Timestamp when the order was created.
- **updated_at** (TIMESTAMP): Timestamp when the order was last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the order was deleted (soft delete).

### order_items
- **id** (UUID): Unique identifier for each order item.
- **order_id** (UUID): Identifier of the order the item belongs to.
- **food_item_id** (UUID): Identifier of the food item.
- **amount** (VARCHAR): Amount of the order item.
- **quantity** (INT): Quantity of the order item.
- **status** (TEXT): Status of the order item (must be 'order_placed', 'confirmed', 'in_process', 'completed', or 'deleted').
- **created_at** (TIMESTAMP): Timestamp when the order item was created.
- **updated_at** (TIMESTAMP): Timestamp when the order item was last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the order item was deleted (soft delete).

### tables
- **id** (UUID): Unique identifier for each table.
- **name** (VARCHAR): Name of the table.
- **table_no** (VARCHAR): Table number.
- **restaurant_id** (UUID): Identifier of the restaurant the table belongs to.
- **status** (TEXT): Status of the table (must be 'occupied', 'available', or 'reserved').
- **created_at** (TIMESTAMP): Timestamp when the table was created.
- **updated_at** (TIMESTAMP): Timestamp when the table was last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the table was deleted (soft delete).

### feedbacks
- **id** (UUID): Unique identifier for each feedback.
- **text** (TEXT): Feedback text.
- **restaurant_id** (UUID): Identifier of the restaurant the feedback is for.
- **star_rating** (FLOAT): Star rating given in the feedback.
- **user_id** (UUID): Identifier of the user who gave the feedback.
- **order_id** (UUID): Identifier of the order the feedback is for.
- **created_at** (TIMESTAMP): Timestamp when the feedback was created.
- **updated_at** (TIMESTAMP): Timestamp when the feedback was last updated.
- **deleted_at** (TIMESTAMP): Timestamp when the feedback was deleted (soft delete).

### sessions
- **id** (UUID): Unique identifier for each session.
- **session_id** (UUID): Identifier of the session.
- **restaurant_id** (UUID): Identifier of the restaurant the session is for.
- **table_id** (UUID): Identifier of the table the session is for.
- **additional_note** (TEXT): Additional note for the session.
- **user_id** (UUID): Identifier of the user the session is for.
- **created_at** (TIMESTAMP): Timestamp when the session was created.
- **updated_at** (TIMESTAMP): Timestamp when the session was last updated.

### carts
- **id** (UUID): Unique identifier for each cart.
- **session_id** (UUID): Identifier of the session the cart is for.
- **restaurant_id** (UUID): Identifier of the restaurant the cart is for.
- **table_id** (UUID): Identifier of the table the cart is for.
- **additional_note** (TEXT): Additional note for the cart.
- **user_id** (UUID): Identifier of the user the cart is for.
- **created_at** (TIMESTAMP): Timestamp when the cart was created.
- **

updated_at** (TIMESTAMP): Timestamp when the cart was last updated.

### cart_items
- **id** (UUID): Unique identifier for each cart item.
- **cart_id** (UUID): Identifier of the cart the item belongs to.
- **food_item_id** (UUID): Identifier of the food item.
- **instruction_note** (TEXT): Instruction note for the cart item.
- **quantity** (INT): Quantity of the cart item.
- **created_at** (TIMESTAMP): Timestamp when the cart item was created.
- **updated_at** (TIMESTAMP): Timestamp when the cart item was last updated.

## Entities and Relationships

The entities in this database include users, restaurants, menu, courses, food_items, food_item_courses, orders, order_items, tables, feedbacks, sessions, carts, and cart_items. The relationships between these entities are defined using foreign keys.

- **users**: Connected to orders, feedbacks, sessions, and carts.
- **restaurants**: Connected to menu, courses, food_items, orders, feedbacks, sessions, carts, and tables.
- **menu**: Connected to food_items.
- **courses**: Connected to food_item_courses.
- **food_items**: Connected to order_items and food_item_courses.
- **orders**: Connected to order_items and feedbacks.
- **tables**: Connected to orders and sessions.
- **feedbacks**: Connected to restaurants, users, and orders.
- **sessions**: Connected to restaurants, tables, and users.
- **carts**: Connected to cart_items.
- **cart_items**: Connected to carts and food_items.

## SQL Scripts

The SQL scripts for creating the database tables are provided in the [scripts](scripts) folder. To set up the database, run the scripts in the following order:

1. [users.sql](scripts/users.sql)
2. [restaurants.sql](scripts/restaurants.sql)
3. [menu.sql](scripts/menu.sql)
4. [courses.sql](scripts/courses.sql)
5. [food_items.sql](scripts/food_items.sql)
6. [food_item_courses.sql](scripts/food_item_courses.sql)
7. [orders.sql](scripts/orders.sql)
8. [order_items.sql](scripts/order_items.sql)
9. [tables.sql](scripts/tables.sql)
10. [feedbacks.sql](scripts/feedbacks.sql)
11. [sessions.sql](scripts/sessions.sql)
12. [carts.sql](scripts/carts.sql)
13. [cart_items.sql](scripts/cart_items.sql)

## Usage

To use this database, you can interact with it using SQL queries. Below are some example queries to get you started:

### 1. List all the restaurants that are currently open, along with their opening and closing times.
```sql
SELECT restaurants.name AS restaurant_name, restaurants.opening_time, restaurants.closing_time
FROM restaurants
WHERE restaurants.status = 'open';
```

### 2. Which food items have been ordered the most, and how many times have they been ordered?
```sql
SELECT food_items.name AS food_item_name, COUNT(order_items.id) AS order_count
FROM order_items
JOIN food_items ON order_items.food_item_id = food_items.id
GROUP BY food_items.name
ORDER BY order_count DESC;
```

### 3. List the names of users who have given feedback with a star rating of 5 for any restaurant.
```sql
SELECT DISTINCT users.name
FROM feedbacks
JOIN users ON feedbacks.user_id = users.id
WHERE feedbacks.star_rating = 5;
```

### 4. Find the average star rating for each restaurant.
```sql
SELECT restaurants.name AS restaurant_name, AVG(feedbacks.star_rating) AS average_rating
FROM feedbacks
JOIN restaurants ON feedbacks.restaurant_id = restaurants.id
GROUP BY restaurants.name;
```

### 5. Retrieve all the orders along with their associated user name, restaurant name, and total amount, filtered by a specific date range.
```sql
SELECT orders.id AS order_id, users.name AS user_name, restaurants.name AS restaurant_name, orders.total_amount
FROM orders
JOIN users ON orders.user_id = users.id
JOIN restaurants ON orders.restaurant_id = restaurants.id
WHERE orders.created_at BETWEEN '2024-01-01' AND '2024-12-31';
```

### 6. Get the total sales amount for each restaurant by summing the total_amount from orders.
```sql
SELECT restaurants.name AS restaurant_name, SUM(orders.total_amount::numeric) AS total_sales
FROM orders
JOIN restaurants ON orders.restaurant_id = restaurants.id
GROUP BY restaurants.name;
```

### 7. Which tables in which restaurants are currently occupied?
```sql
SELECT restaurants.name AS restaurant_name, tables.name AS table_name, tables.table_no
FROM tables
JOIN restaurants ON tables.restaurant_id = restaurants.id
WHERE tables.status = 'occupied';
```

### 8. Find the total amount spent by each user across all their orders.
```sql
SELECT users.name AS user_name, SUM(CAST(orders.total_amount AS NUMERIC)) AS total_spent
FROM orders
JOIN users ON orders.user_id = users.id
GROUP BY users.name
ORDER BY total_spent DESC;
```

### 9. List the names of the top 5 most expensive food items available.
```sql
SELECT food_items.name AS food_item_name, CAST(food_items.price AS NUMERIC) AS item_price
FROM food_items
ORDER BY item_price DESC
LIMIT 5;
```

### 10. Show the restaurant and user details for orders that have not been paid.
```sql
SELECT orders.id AS order_id, restaurants.name AS restaurant_name, users.name AS user_name, orders.total_amount
FROM orders
JOIN restaurants ON orders.restaurant_id = restaurants.id
JOIN users ON orders.user_id = users.id
WHERE orders.is_paid = FALSE;
```

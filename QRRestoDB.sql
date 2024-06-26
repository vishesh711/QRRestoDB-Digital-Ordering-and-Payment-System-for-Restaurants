-- Create Table: users
-- This table stores information about users.
CREATE TABLE users (
    id UUID PRIMARY KEY,                        -- Unique identifier for each user
    name VARCHAR(255),                          -- Name of the user
    phone_number VARCHAR(15),                   -- Phone number of the user
    email VARCHAR(255) UNIQUE,                  -- Email of the user, must be unique
    otp VARCHAR(10),                            -- One-time password for verification
    is_verified BOOLEAN,                        -- Verification status of the user
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the user was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the user details were last updated
    deleted_at TIMESTAMP                        -- Timestamp when the user was deleted (soft delete)
);

-- Create Table: restaurants
-- This table stores information about restaurants.
CREATE TABLE restaurants (
    id UUID PRIMARY KEY,                        -- Unique identifier for each restaurant
    name VARCHAR(255) NOT NULL,                 -- Name of the restaurant, cannot be null
    logo_url VARCHAR(255),                      -- URL of the restaurant's logo
    opening_time TIMESTAMP,                     -- Opening time of the restaurant
    closing_time TIMESTAMP,                     -- Closing time of the restaurant
    status TEXT CHECK (status IN ('open', 'closed')), -- Status of the restaurant, must be 'open' or 'closed'
    operating_days JSONB,                       -- JSONB field to store operating days
    phone_number VARCHAR(15),                   -- Phone number of the restaurant
    email VARCHAR(255) UNIQUE,                  -- Email of the restaurant, must be unique
    encrypted_password TEXT NOT NULL,           -- Encrypted password of the restaurant's account
    password_hash TEXT NOT NULL,                -- Hash of the restaurant's password
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the restaurant was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the restaurant details were last updated
    deleted_at TIMESTAMP                        -- Timestamp when the restaurant was deleted (soft delete)
);

-- Create Table: menu
-- This table stores information about menus of restaurants.
CREATE TABLE menu (
    id UUID PRIMARY KEY,                        -- Unique identifier for each menu
    name VARCHAR(255),                          -- Name of the menu
    restaurant_id UUID,                         -- Identifier of the restaurant the menu belongs to
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the menu was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the menu was last updated
    deleted_at TIMESTAMP,                       -- Timestamp when the menu was deleted (soft delete)
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) -- Foreign key constraint referencing restaurants table
);

-- Create Table: courses
-- This table stores information about courses (meal courses) in restaurants.
CREATE TABLE courses (
    id UUID PRIMARY KEY,                        -- Unique identifier for each course
    name VARCHAR(255),                          -- Name of the course
    restaurant_id UUID,                         -- Identifier of the restaurant the course belongs to
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the course was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the course was last updated
    deleted_at TIMESTAMP,                       -- Timestamp when the course was deleted (soft delete)
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) -- Foreign key constraint referencing restaurants table
);

-- Create Table: food_items
-- This table stores information about food items in the menu.
CREATE TABLE food_items (
    id UUID PRIMARY KEY,                        -- Unique identifier for each food item
    custom_id VARCHAR(50),                      -- Custom identifier for the food item
    name VARCHAR(255),                          -- Name of the food item
    menu_id UUID,                               -- Identifier of the menu the food item belongs to
    restaurant_id UUID,                         -- Identifier of the restaurant the food item belongs to
    description TEXT,                           -- Description of the food item
    price VARCHAR(50),                          -- Price of the food item
    food_img_url VARCHAR(255),                  -- URL of the food item's image
    dietary_restriction TEXT CHECK (dietary_restriction IN ('veg', 'non_veg', 'egg')), -- Dietary restriction of the food item
    is_featured BOOLEAN,                        -- Indicates if the food item is featured
    spicy_rating INT,                           -- Spicy rating of the food item
    status TEXT CHECK (status IN ('in_stock', 'out_of_stock')), -- Stock status of the food item
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the food item was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the food item was last updated
    deleted_at TIMESTAMP,                       -- Timestamp when the food item was deleted (soft delete)
    FOREIGN KEY (menu_id) REFERENCES menu(id),  -- Foreign key constraint referencing menu table
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) -- Foreign key constraint referencing restaurants table
);

-- Create Table: food_item_courses
-- This table stores the relationship between food items and courses.
CREATE TABLE food_item_courses (
    id UUID PRIMARY KEY,                        -- Unique identifier for each record
    name VARCHAR(255),                          -- Name of the food item course relationship
    course_id UUID,                             -- Identifier of the course
    food_item_id UUID,                          -- Identifier of the food item
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the record was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the record was last updated
    deleted_at TIMESTAMP,                       -- Timestamp when the record was deleted (soft delete)
    FOREIGN KEY (course_id) REFERENCES courses(id), -- Foreign key constraint referencing courses table
    FOREIGN KEY (food_item_id) REFERENCES food_items(id) -- Foreign key constraint referencing food_items table
);

-- Create Table: orders
-- This table stores information about orders placed by users.
CREATE TABLE orders (
    id UUID PRIMARY KEY,                        -- Unique identifier for each order
    custom_order_id VARCHAR(12),                -- Custom identifier for the order
    restaurant_id UUID,                         -- Identifier of the restaurant the order was placed at
    user_id UUID,                               -- Identifier of the user who placed the order
    total_amount VARCHAR(50),                   -- Total amount of the order
    table_id UUID,                              -- Identifier of the table the order was placed at
    invoice_url VARCHAR(255),                   -- URL of the order invoice
    is_paid BOOLEAN,                            -- Indicates if the order has been paid
    status TEXT CHECK (status IN ('order_placed', 'confirmed', 'in_process', 'completed', 'deleted')), -- Status of the order
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the order was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the order was last updated
    deleted_at TIMESTAMP,                       -- Timestamp when the order was deleted (soft delete)
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id), -- Foreign key constraint referencing restaurants table
    FOREIGN KEY (user_id) REFERENCES users(id) -- Foreign key constraint referencing users table
);

-- Create Table: order_items
-- This table stores information about individual items in an order.
CREATE TABLE order_items (
    id UUID PRIMARY KEY,                        -- Unique identifier for each order item
    order_id UUID,                              -- Identifier of the order the item belongs to
    food_item_id UUID,                          -- Identifier of the food item
    amount VARCHAR(50),                         -- Amount of the order item
    quantity INT,                               -- Quantity of the order item
    status TEXT CHECK (status IN ('order_placed', 'confirmed', 'in_process', 'completed', 'deleted')), -- Status of the order item
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the order item was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the order item was last updated
    deleted_at TIMESTAMP,                       -- Timestamp when the order item was deleted (soft delete)
    FOREIGN KEY (order_id) REFERENCES orders(id), -- Foreign key constraint referencing orders table
    FOREIGN KEY (food_item_id) REFERENCES food_items(id) -- Foreign key constraint referencing food_items table
);

-- Create Table: tables
-- This table stores information about tables in restaurants.
CREATE TABLE tables (
    id UUID PRIMARY KEY,                        -- Unique identifier for each table
    name VARCHAR(255),                          -- Name of the table
    table_no VARCHAR(50),                       -- Table number
    restaurant_id UUID,                         -- Identifier of the restaurant the table belongs to
    status TEXT CHECK (status IN ('occupied', 'available', 'reserved')), -- Status of the table
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the table was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the table was last updated
    deleted_at TIMESTAMP,                       -- Timestamp when the table was deleted (soft delete)
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) -- Foreign key constraint referencing restaurants table
);

-- Create Table: feedbacks
-- This table stores feedback given by users for orders.
CREATE TABLE feedbacks (
    id UUID PRIMARY KEY,                        -- Unique identifier for each feedback
    text TEXT,                                  -- Feedback text
    restaurant_id UUID,                         -- Identifier of the restaurant the feedback is for
    star_rating FLOAT,                          -- Star rating given in the feedback
    user_id UUID,                               -- Identifier of the user who gave the feedback
    order_id UUID,                              -- Identifier of the order the feedback is for
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the feedback was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the feedback was last updated
    deleted_at TIMESTAMP,                       -- Timestamp when the feedback was deleted (soft delete)
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id), -- Foreign key constraint referencing restaurants table
    FOREIGN KEY (user_id) REFERENCES users(id), -- Foreign key constraint referencing users table
    FOREIGN KEY (order_id) REFERENCES orders(id) -- Foreign key constraint referencing orders table
);

-- Create Table: sessions
-- This table stores information about sessions in restaurants.
CREATE TABLE sessions (
    id UUID PRIMARY KEY,                        -- Unique identifier for each session
    session_id UUID,                            -- Identifier of the session
    restaurant_id UUID,                         -- Identifier of the restaurant the session is for
    table_id UUID,                              -- Identifier of the table the session is for
    additional_note TEXT,                       -- Additional note for the session
    user_id UUID,                               -- Identifier of the user the session is for
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the session was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the session was last updated
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id), -- Foreign key constraint referencing restaurants table
    FOREIGN KEY (table_id) REFERENCES tables(id), -- Foreign key constraint referencing tables table
    FOREIGN KEY (user_id) REFERENCES users(id) -- Foreign key constraint referencing users table
);

-- Create Table: carts
-- This table stores information about carts.
CREATE TABLE carts (
    id UUID PRIMARY KEY,                        -- Unique identifier for each cart
    session_id UUID,                            -- Identifier of the session the cart is for
    restaurant_id UUID,                         -- Identifier of the restaurant the cart is for
    table_id UUID,                              -- Identifier of the table the cart is for
    additional_note TEXT,                       -- Additional note for the cart
    user_id UUID,                               -- Identifier of the user the cart is for
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the cart was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the cart was last updated
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id), -- Foreign key constraint referencing restaurants table
    FOREIGN KEY (table_id) REFERENCES tables(id), -- Foreign key constraint referencing tables table
    FOREIGN KEY (user_id) REFERENCES users(id) -- Foreign key constraint referencing users table
);

-- Create Table: cart_items
-- This table stores information about individual items in a cart.
CREATE TABLE cart_items (
    id UUID PRIMARY KEY,                        -- Unique identifier for each cart item
    cart_id UUID,                               -- Identifier of the cart the item belongs to
    food_item_id UUID,                          -- Identifier of the food item
    instruction_note TEXT,                      -- Instruction note for the cart item
    quantity INT,                               -- Quantity of the cart item
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the cart item was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the cart item was last updated
    FOREIGN KEY (cart_id) REFERENCES carts(id), -- Foreign key constraint referencing carts table
    FOREIGN KEY (food_item_id) REFERENCES food_items(id) -- Foreign key constraint referencing food_items table
);

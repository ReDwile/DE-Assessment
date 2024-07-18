-- Create Locations Table
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    country_name VARCHAR(50) NOT NULL
);

-- Create Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    birth_date DATE,
    address_line_1 VARCHAR(100),
    address_line_2 VARCHAR(100),
    postal_code VARCHAR(20),
    location_id INT NOT NULL REFERENCES locations(location_id)
);

-- Index on customer_name for faster search by name
CREATE INDEX idx_customers_name ON customers(customer_name);

-- Index on preferred_delivery_time for faster filtering by delivery time
CREATE INDEX idx_customers_delivery_time ON customers(preferred_delivery_time);

-- Create Products Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(50),
    is_perishable BOOLEAN NOT NULL,
    expiration_date DATE
);

-- Index on product_name for faster search by name
CREATE INDEX idx_products_name ON products(product_name);

-- Index on category for faster filtering by category
CREATE INDEX idx_products_category ON products(category);

-- Index on expiration_date for managing perishable products
CREATE INDEX idx_products_expiration_date ON products(expiration_date);

-- Create Sales Transactions Table
CREATE TABLE sales_transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    purchase_date DATE NOT NULL,
    quantity INT NOT NULL
);

-- Index on customer_id for faster joins with customers
CREATE INDEX idx_sales_transactions_customer_id ON sales_transactions(customer_id);

-- Index on product_id for faster joins with products
CREATE INDEX idx_sales_transactions_product_id ON sales_transactions(product_id);

-- Index on purchase_date for faster date range queries
CREATE INDEX idx_sales_transactions_purchase_date ON sales_transactions(purchase_date);

-- Index on delivery_time for faster filtering by delivery time
CREATE INDEX idx_sales_transactions_delivery_time ON sales_transactions(delivery_time);

-- Create Shipping Details Table
CREATE TABLE shipping_details (
    transaction_id INT NOT NULL REFERENCES sales_transactions(transaction_id),
    shipping_date DATE NOT NULL,
    shipping_time TIME NOT NULL,
    shipping_address VARCHAR(200),
    location_id INT NOT NULL REFERENCES locations(location_id),
    PRIMARY KEY (transaction_id, shipping_date)
);

-- Index on shipping_date for faster date range queries
CREATE INDEX idx_shipping_details_shipping_date ON shipping_details(shipping_date);

-- Index on location_id for faster filtering by location
CREATE INDEX idx_shipping_details_location_id ON shipping_details(location_id);

Explanation
•   Locations Table: Stores both city and country information with a unique location ID.
•   Customers Table:
    •   Adds phone_number to store the customer’s contact number.
    •   Adds birth_date to store the customer’s birthdate.
    •   Adds address_line_1 and address_line_2 to store detailed address information.
    •   Adds postal_code to store the postal code.
    •   Foreign key location_id references the locations table.
•   Products Table:
    •   Adds is_perishable to indicate whether the product is perishable.
    •   Adds expiration_date to manage perishable products.
•   Sales Transactions Table:
    •   Adds delivery_time to store the specific time of delivery.
    •   Foreign key references customers and products tables.
•   Shipping Details Table:
    •   Foreign key location_id references the locations table.

Indexes are added to optimize performance for searches and joins. 
This structure is tailored to the needs of a company specializing in food sales and fast delivery, with comprehensive personal data storage for customers.
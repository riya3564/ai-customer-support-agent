-- AI CUSTOMER SUPPORT AGENT
-- DATABASE SETUP & VERIFICATION SCRIPT
-- PostgreSQL


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    brand VARCHAR(100),
    model_number VARCHAR(100),
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE warranties (
    warranty_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE'
);

CREATE TABLE service_tickets (
    ticket_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    issue_description TEXT NOT NULL,
    priority VARCHAR(20) DEFAULT 'MEDIUM',
    status VARCHAR(20) DEFAULT 'OPEN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;






-- CUSTOMERS
INSERT INTO customers (name, email, phone, address) VALUES
('Riya Sharma', 'riya.sharma@gmail.com', '9876543210', 'Delhi'),
('Aman Verma', 'aman.verma@gmail.com', '9876543211', 'Noida'),
('Neha Singh', 'neha.singh@gmail.com', '9876543212', 'Gurugram'),
('Rahul Kumar', 'rahul.kumar@gmail.com', '9876543213', 'Haldwani'),
('Priya Gupta', 'priya.gupta@gmail.com', '9876543214', 'Lucknow'),
('Arjun Mehta', 'arjun.mehta@gmail.com', '9876543215', 'Dehradun'),
('Sneha Joshi', 'sneha.joshi@gmail.com', '9876543216', 'Jaipur'),
('Vikas Yadav', 'vikas.yadav@gmail.com', '9876543217', 'Ghaziabad'),
('Anjali Rawat', 'anjali.rawat@gmail.com', '9876543218', 'Nainital'),
('Karan Malhotra', 'karan.malhotra@gmail.com', '9876543219', 'Delhi');


-- PRODUCTS
INSERT INTO products (product_name, brand, model_number, price) VALUES
('LED TV 43 Inch', 'Philips', '43PFT6919', 32999.00),
('LED TV 55 Inch', 'Philips', '55PFT6919', 49999.00),
('Refrigerator 340L', 'Philips', 'REF340X', 42999.00),
('Washing Machine 7KG', 'Philips', 'WM7000X', 28999.00),
('Air Purifier', 'Philips', 'AC1711', 14999.00),
('Microwave Oven', 'Philips', 'MW500X', 11999.00),
('Soundbar', 'Philips', 'TAB5309', 17999.00),
('Air Fryer', 'Philips', 'HD9252', 8999.00);


-- WARRANTIES
INSERT INTO warranties
(customer_id, product_id, start_date, end_date, status)
VALUES
(1, 1, '2025-01-15', '2027-01-14', 'ACTIVE'),
(2, 2, '2024-08-10', '2026-08-09', 'EXPIRED'),
(3, 3, '2025-03-20', '2027-03-19', 'ACTIVE'),
(4, 4, '2024-11-05', '2026-11-04', 'ACTIVE'),
(5, 5, '2025-06-12', '2027-06-11', 'ACTIVE'),
(6, 6, '2024-05-18', '2026-05-17', 'EXPIRED'),
(7, 7, '2025-02-01', '2027-01-31', 'ACTIVE'),
(8, 8, '2024-09-25', '2026-09-24', 'ACTIVE');


-- SERVICE TICKETS
INSERT INTO service_tickets
(customer_id, product_id, issue_description, priority, status)
VALUES
(1, 1, 'TV screen is flickering continuously', 'HIGH', 'OPEN'),
(2, 2, 'TV remote is not responding', 'MEDIUM', 'CLOSED'),
(3, 3, 'Refrigerator is not cooling properly', 'HIGH', 'OPEN'),
(4, 4, 'Washing machine making unusual noise', 'MEDIUM', 'OPEN'),
(5, 5, 'Air purifier is showing an error', 'LOW', 'OPEN'),
(6, 6, 'Microwave is not heating food', 'HIGH', 'CLOSED'),
(7, 7, 'Soundbar has no audio output', 'MEDIUM', 'OPEN'),
(8, 8, 'Air fryer is not turning on', 'HIGH', 'OPEN'),
(9, 1, 'TV has no picture', 'HIGH', 'OPEN'),
(10, 2, 'TV audio is distorted', 'MEDIUM', 'OPEN');





SELECT
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

SELECT
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;





SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
LEFT JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
LEFT JOIN information_schema.constraint_column_usage AS ccu
    ON tc.constraint_name = ccu.constraint_name
    AND tc.table_schema = ccu.table_schema
WHERE tc.table_schema = 'public'
ORDER BY tc.table_name, tc.constraint_type; 


SELECT 'customers' AS table_name, COUNT(*) AS rows FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'warranties', COUNT(*) FROM warranties
UNION ALL
SELECT 'service_tickets', COUNT(*) FROM service_tickets;             



SELECT customer_id, name, email, phone
FROM customers
ORDER BY customer_id
LIMIT 5;



SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
LEFT JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
LEFT JOIN information_schema.constraint_column_usage AS ccu
    ON tc.constraint_name = ccu.constraint_name
    AND tc.table_schema = ccu.table_schema
WHERE tc.table_schema = 'public'
ORDER BY tc.table_name, tc.constraint_type;




-- 1. Users table create karo
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'COMMON_USER',
    customer_id INTEGER UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT users_role_check
        CHECK (role IN ('ADMIN', 'COMMON_USER')),

    CONSTRAINT users_customer_fk
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- 2. Users table verify karo
SELECT
    user_id,
    name,
    email,
    role,
    customer_id,
    created_at
FROM users;


-- 3. Existing tables verify karo
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


-- 4. Existing data counts
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'warranties', COUNT(*) FROM warranties
UNION ALL
SELECT 'service_tickets', COUNT(*) FROM service_tickets
UNION ALL
SELECT 'users', COUNT(*) FROM users;



SELECT
    user_id,
    name,
    email,
    role,
    customer_id
FROM users
ORDER BY user_id;




UPDATE users
SET role = 'ADMIN'
WHERE email = 'testuser@gmail.com';

SELECT user_id, name, email, role
FROM users;



SELECT user_id, name, email, role, customer_id
FROM users
ORDER BY user_id;


UPDATE users
SET customer_id = 1
WHERE email = 'commonuser@gmail.com';

SELECT
    user_id,
    name,
    email,
    role,
    customer_id
FROM users;




CREATE TABLE IF NOT EXISTS refresh_tokens (
    token_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    token_hash TEXT UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    revoked BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT refresh_tokens_user_fk
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);


SELECT * FROM refresh_tokens;


CREATE TABLE IF NOT EXISTS password_reset_tokens (
    reset_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    token_hash TEXT UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    used BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT password_reset_user_fk
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

SELECT * FROM password_reset_tokens;  








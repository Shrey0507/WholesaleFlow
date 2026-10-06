-- ============================================================
-- WHOLESALE MANAGEMENT SYSTEM
-- Database Schema
-- MySQL 8.0
-- ============================================================

CREATE DATABASE IF NOT EXISTS wholesale_management;

USE wholesale_management;


-- ============================================================
-- 1. STOCK
-- ============================================================

CREATE TABLE STOCK (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_name VARCHAR(100) NOT NULL UNIQUE,
    quantity INT NOT NULL DEFAULT 0,
    cost_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    selling_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    reorder_level INT NOT NULL DEFAULT 10,

    CONSTRAINT chk_stock_quantity
        CHECK (quantity >= 0),

    CONSTRAINT chk_stock_cost_price
        CHECK (cost_price >= 0),

    CONSTRAINT chk_stock_selling_price
        CHECK (selling_price >= 0),

    CONSTRAINT chk_stock_reorder_level
        CHECK (reorder_level >= 0)
);


-- ============================================================
-- 2. SUPPLIER
-- ============================================================

CREATE TABLE SUPPLIER (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20) NOT NULL UNIQUE
);


-- ============================================================
-- 3. CUSTOMER
-- ============================================================

CREATE TABLE CUSTOMER (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20) NOT NULL UNIQUE
);


-- ============================================================
-- 4. ORDERS
-- ============================================================

CREATE TABLE ORDERS (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    delivery_date DATE NULL,
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    order_status ENUM('PLACED', 'DELIVERED', 'CANCELLED')
        NOT NULL DEFAULT 'PLACED',

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES CUSTOMER(customer_id),

    CONSTRAINT chk_orders_total
        CHECK (total_amount >= 0)
);


-- ============================================================
-- 5. ORDER_ITEM
-- ============================================================

CREATE TABLE ORDER_ITEM (
    order_id INT NOT NULL,
    stock_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    cost_price DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (order_id, stock_id),

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES ORDERS(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_item_stock
        FOREIGN KEY (stock_id)
        REFERENCES STOCK(stock_id),

    CONSTRAINT chk_order_item_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_order_item_unit_price
        CHECK (unit_price >= 0),

    CONSTRAINT chk_order_item_cost_price
        CHECK (cost_price >= 0)
);


-- ============================================================
-- 6. PAYMENT
-- ============================================================

CREATE TABLE PAYMENT (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    due_date DATE NOT NULL,
    paid_date DATE NULL,
    pay_mode ENUM('Cash', 'UPI', 'Cheque', 'Bank') NULL,
    pay_status ENUM('PAID', 'PENDING')
        NOT NULL DEFAULT 'PENDING',

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES ORDERS(order_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_payment_amount
        CHECK (amount > 0)
);


-- ============================================================
-- 7. PURCHASE
-- ============================================================

CREATE TABLE PURCHASE (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    stock_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_cost DECIMAL(10,2) NOT NULL,
    purchase_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    expected_delivery_date DATE NULL,
    purchase_status ENUM('ORDERED', 'RECEIVED')
        NOT NULL DEFAULT 'ORDERED',

    CONSTRAINT fk_purchase_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES SUPPLIER(supplier_id),

    CONSTRAINT fk_purchase_stock
        FOREIGN KEY (stock_id)
        REFERENCES STOCK(stock_id),

    CONSTRAINT chk_purchase_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_purchase_cost
        CHECK (purchase_cost >= 0)
);


-- ============================================================
-- 8. MANAGER
-- ============================================================

CREATE TABLE MANAGER (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL
);


-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX idx_orders_customer
    ON ORDERS(customer_id);

CREATE INDEX idx_orders_date
    ON ORDERS(order_date);

CREATE INDEX idx_order_item_stock
    ON ORDER_ITEM(stock_id);

CREATE INDEX idx_payment_order
    ON PAYMENT(order_id);

CREATE INDEX idx_payment_status
    ON PAYMENT(pay_status);

CREATE INDEX idx_purchase_supplier
    ON PURCHASE(supplier_id);

CREATE INDEX idx_purchase_stock
    ON PURCHASE(stock_id);

CREATE INDEX idx_purchase_status
    ON PURCHASE(purchase_status);
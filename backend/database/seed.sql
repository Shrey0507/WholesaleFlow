USE wholesale_management;

-- ============================================================
-- WHOLESALE MANAGEMENT SYSTEM
-- SAMPLE / TEST DATA
-- ============================================================


-- ============================================================
-- 1. SUPPLIERS
-- ============================================================

INSERT INTO SUPPLIER
    (supplier_name, address, phone)
VALUES
    ('ABC Wholesale Suppliers',
     'Peenya Industrial Area, Bengaluru',
     '9876543210'),

    ('Metro Distributors',
     'Yeshwanthpur, Bengaluru',
     '9876543211'),

    ('Sri Lakshmi Traders',
     'Rajajinagar, Bengaluru',
     '9876543212');


-- ============================================================
-- 2. CUSTOMERS
-- ============================================================

INSERT INTO CUSTOMER
    (customer_name, address, phone)
VALUES
    ('Fresh Mart',
     'RR Nagar, Bengaluru',
     '9000000001'),

    ('Daily Needs Store',
     'Kengeri, Bengaluru',
     '9000000002'),

    ('City Supermarket',
     'Vijayanagar, Bengaluru',
     '9000000003'),

    ('Green Basket',
     'Nagarbhavi, Bengaluru',
     '9000000004'),

    ('Family Needs',
     'Uttarahalli, Bengaluru',
     '9000000005');


-- ============================================================
-- 3. STOCK
-- ============================================================

INSERT INTO STOCK
    (stock_name, quantity, cost_price, selling_price, reorder_level)
VALUES
    ('Rice 25kg',
     100,
     1100.00,
     1250.00,
     20),

    ('Wheat Flour 10kg',
     75,
     420.00,
     500.00,
     15),

    ('Sugar 25kg',
     50,
     950.00,
     1080.00,
     15),

    ('Toor Dal 10kg',
     12,
     900.00,
     1020.00,
     15),

    ('Cooking Oil 15L',
     8,
     1800.00,
     1980.00,
     10);


-- ============================================================
-- 4. PURCHASES
-- ============================================================

INSERT INTO PURCHASE
    (supplier_id, stock_id, quantity, purchase_cost,
     purchase_date, expected_delivery_date, purchase_status)
VALUES
    (1, 1, 50, 1100.00,
     '2026-10-01', '2026-10-03', 'RECEIVED'),

    (1, 2, 40, 420.00,
     '2026-10-01', '2026-10-04', 'RECEIVED'),

    (2, 3, 30, 950.00,
     '2026-10-02', '2026-10-05', 'RECEIVED'),

    (3, 4, 25, 900.00,
     '2026-10-03', '2026-10-08', 'ORDERED'),

    (2, 5, 20, 1800.00,
     '2026-10-03', '2026-10-09', 'ORDERED');


-- ============================================================
-- 5. ORDERS
-- ============================================================

INSERT INTO ORDERS
    (customer_id, order_date, delivery_date,
     total_amount, order_status)
VALUES
    (1, '2026-10-01', '2026-10-02',
     3750.00, 'DELIVERED'),

    (2, '2026-10-02', '2026-10-03',
     2160.00, 'DELIVERED'),

    (3, '2026-10-04', NULL,
     3000.00, 'PLACED'),

    (4, '2026-10-05', NULL,
     3960.00, 'PLACED');


-- ============================================================
-- 6. ORDER ITEMS
-- ============================================================

-- Order 1 = 2 Rice + 1 Wheat
INSERT INTO ORDER_ITEM
    (order_id, stock_id, quantity, unit_price, cost_price)
VALUES
    (1, 1, 2, 1250.00, 1100.00),
    (1, 2, 2, 500.00, 420.00);


-- Order 2 = 2 Sugar
INSERT INTO ORDER_ITEM
    (order_id, stock_id, quantity, unit_price, cost_price)
VALUES
    (2, 3, 2, 1080.00, 950.00);


-- Order 3 = 2 Rice + 1 Sugar
INSERT INTO ORDER_ITEM
    (order_id, stock_id, quantity, unit_price, cost_price)
VALUES
    (3, 1, 2, 1250.00, 1100.00),
    (3, 3, 1, 500.00, 950.00);


-- Order 4 = 2 Cooking Oil
INSERT INTO ORDER_ITEM
    (order_id, stock_id, quantity, unit_price, cost_price)
VALUES
    (4, 5, 2, 1980.00, 1800.00);


-- ============================================================
-- 7. PAYMENTS
-- ============================================================

INSERT INTO PAYMENT
    (order_id, amount, due_date, paid_date,
     pay_mode, pay_status)
VALUES
    (1, 3500.00, '2026-10-05', '2026-10-02',
     'UPI', 'PAID'),

    (2, 2160.00, '2026-10-06', '2026-10-03',
     'Cash', 'PAID'),

    (3, 3000.00, '2026-10-10', NULL,
     NULL, 'PENDING'),

    (4, 3960.00, '2026-10-12', NULL,
     NULL, 'PENDING');
USE wholesale_management;

-- ============================================================
-- VIEW 1: LOW STOCK
-- Shows products whose quantity is at or below reorder level
-- ============================================================

CREATE OR REPLACE VIEW v_low_stock AS
SELECT
    stock_id,
    stock_name,
    quantity,
    reorder_level,
    cost_price,
    selling_price
FROM STOCK
WHERE quantity <= reorder_level;


-- ============================================================
-- VIEW 2: DEFAULTERS
-- Shows customers whose payments are pending past due date
-- ============================================================

CREATE OR REPLACE VIEW v_defaulters AS
SELECT
    c.customer_id,
    c.customer_name,
    c.phone,
    o.order_id,
    o.order_date,
    p.amount,
    p.due_date,
    p.pay_status
FROM CUSTOMER c
JOIN ORDERS o
    ON c.customer_id = o.customer_id
JOIN PAYMENT p
    ON o.order_id = p.order_id
WHERE p.pay_status = 'PENDING'
  AND p.due_date < CURRENT_DATE;


-- ============================================================
-- VIEW 3: PAYMENT STATUS
-- Shows payment information for all orders
-- ============================================================

CREATE OR REPLACE VIEW v_payment_status AS
SELECT
    p.payment_id,
    p.order_id,
    c.customer_id,
    c.customer_name,
    p.amount,
    p.due_date,
    p.paid_date,
    p.pay_mode,
    p.pay_status
FROM PAYMENT p
JOIN ORDERS o
    ON p.order_id = o.order_id
JOIN CUSTOMER c
    ON o.customer_id = c.customer_id;
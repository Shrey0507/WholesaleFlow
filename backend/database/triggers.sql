USE wholesale_management;

CREATE TRIGGER trg_check_stock
BEFORE INSERT ON ORDER_ITEM
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;

    SELECT quantity
    INTO available_stock
    FROM STOCK
    WHERE stock_id = NEW.stock_id;

    IF available_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock item does not exist';
    ELSEIF NEW.quantity > available_stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock available';
    END IF;
END;


CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON ORDER_ITEM
FOR EACH ROW
BEGIN
    UPDATE STOCK
    SET quantity = quantity - NEW.quantity
    WHERE stock_id = NEW.stock_id;
END;


CREATE TRIGGER trg_receive_purchase
AFTER UPDATE ON PURCHASE
FOR EACH ROW
BEGIN
    IF OLD.purchase_status = 'ORDERED'
       AND NEW.purchase_status = 'RECEIVED' THEN

        UPDATE STOCK
        SET quantity = quantity + NEW.quantity
        WHERE stock_id = NEW.stock_id;

    END IF;
END;
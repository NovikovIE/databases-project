-- Функция для поиска всех отзывов о продукте с заданным product_id
CREATE OR REPLACE FUNCTION get_reviews_by_product_id(INTEGER)
    RETURNS SETOF sh.review AS
$$
BEGIN
    RETURN QUERY SELECT * FROM sh.review WHERE product_id = $1;
END;
$$ LANGUAGE plpgsql;


-- Функция для вычисления общей суммы заказа, исходя из данных в таблице order_product
CREATE OR REPLACE FUNCTION calculate_order_total(ord_id integer)
    RETURNS numeric AS
$$
DECLARE
    total numeric := 0;
BEGIN
    SELECT SUM(p.price * op.quantity)
    INTO total
    FROM sh.order_product op
             JOIN sh.product p ON op.product_id = p.product_id
    WHERE op.order_id = ord_id;

    RETURN total;
END;
$$ LANGUAGE plpgsql;
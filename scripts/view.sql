-- Скрыть звёздочками адрес, телефон и email кроме последних 4 символов
CREATE VIEW sh.user_privacy AS
SELECT user_id,
       name,
       CASE WHEN phone IS NULL THEN NULL ELSE CONCAT('****', RIGHT(phone, 4)) END AS phone,
       CONCAT('****', RIGHT(address, 4))                                          AS address,
       CONCAT('****', '@', SUBSTRING(email, POSITION('@' IN email) + 1))          AS email
FROM sh.user;


-- Убрать техническую информацию (ненужную для пользователя) из sh.product
CREATE VIEW sh.product_public AS
SELECT product_name,
       description,
       price
FROM sh.product;


-- Количество заказов по пользователям
CREATE VIEW sh.user_order_count AS
SELECT u.user_id, COUNT(o.order_id) AS order_count
FROM sh.user u
         LEFT JOIN sh.order_user ou ON u.user_id = ou.user_id
         LEFT JOIN sh.order o ON ou.order_id = o.order_id
GROUP BY u.user_id;


-- Количество продуктов в корзине по пользователям
CREATE VIEW sh.user_cart_count AS
SELECT u.user_id, u.name, SUM(c.quantity) AS cart_count
FROM sh.user u
         LEFT JOIN sh.cart c ON u.user_id = c.user_id
GROUP BY u.user_id, u.name;


-- Количество продуктов в каждой категории
CREATE VIEW sh.product_count_by_category AS
SELECT c.category_id, c.category_name, COUNT(pc.product_id) AS product_count
FROM sh.category c
         LEFT JOIN sh.product_category pc ON c.category_id = pc.category_id
GROUP BY c.category_id, c.category_name;


-- Средняя оценка продукта и количество отзывов
CREATE VIEW sh.product_reviews_summary AS
SELECT p.product_id, p.product_name, AVG(r.rating) AS avg_rating, COUNT(r.product_id) AS review_count
FROM sh.product p
         LEFT JOIN sh.review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

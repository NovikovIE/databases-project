-- Вывести товары, количество которых на складе < 10 по убыванию количества:
-- (Посмотреть какие товары заканчиваются)
SELECT product_name, warehouse_quantity
FROM sh.product
WHERE warehouse_quantity < 10
ORDER BY warehouse_quantity DESC;


-- Выбрать пользователей, у которых больше 1 товара в корзине,
-- отсортированных по убыванию количества товаров в корзине:
SELECT user_id, COUNT(product_id) as num_products
FROM sh.cart
GROUP BY user_id
HAVING COUNT(product_id) > 1
ORDER BY num_products DESC;


-- Выбрать отзывы о продуктах со средней оценкой выше или равно 3 и отсортировать их по убыванию средней оценки,
-- также получить их ранг в этом списке:
SELECT product_name, AVG(rating) AS avg_rating, RANK() OVER (ORDER BY AVG(rating) DESC) as rank
FROM sh.product
         JOIN sh.review ON sh.product.product_id = sh.review.product_id
GROUP BY product_name
HAVING AVG(rating) >= 3
ORDER BY avg_rating DESC;


-- Выбрать пользователей с наибольшей суммой заказов, которые были выполнены в статусе "заказ выполнен",
-- и отсортировать их по убыванию суммы заказов:
SELECT *
FROM (SELECT user_id, SUM(price) OVER (PARTITION BY order_user.user_id) as total_price
      FROM sh.order
               JOIN sh.order_user ON sh.order.order_id = sh.order_user.order_id
               JOIN sh.product ON sh.order_user.user_id = sh.product.product_id
      WHERE sh.order.status = 2) AS uitp
GROUP BY user_id, uitp.total_price
ORDER BY total_price DESC;


-- Рассчитать общую сумму заказов для каждого пользователя и вывести по убыванию суммы
SELECT DISTINCT u.user_id, u.name, SUM(op.quantity * p.price) OVER (PARTITION BY u.user_id) as total_order_amount
FROM sh.user u
         JOIN sh.order_user ou ON u.user_id = ou.user_id
         JOIN sh.order o ON ou.order_id = o.order_id
         JOIN sh.order_product op ON o.order_id = op.order_id
         JOIN sh.product p ON op.product_id = p.product_id
ORDER BY total_order_amount DESC;


-- В каждом заказе выбрать товары, которых больше всего в этом заказе
SELECT order_id,
       product_id,
       quantity
FROM (SELECT order_id,
             product_id,
             quantity,
             FIRST_VALUE(quantity) OVER (PARTITION BY order_id) AS first_quantity
      FROM sh.order_product
      ORDER BY order_id, product_id) as op
WHERE quantity = first_quantity

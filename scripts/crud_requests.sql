-- CRUD - Create, Read, Update, Delete


-- CREATE:
INSERT INTO sh.category (category_id, category_name)
VALUES (50, 'TV');

INSERT INTO sh.review (user_id, product_id, text, rating)
VALUES (10, 3, 'Great product, highly recommended', 5);

INSERT INTO sh.user (user_id, name, password, email, address, phone)
VALUES (11, 'John Doe', '2fcff1d017be57a7a642015b174f0ee8c72d0a2f85d3ba3e4f4df936b4c22c62', 'nowhere',
        'johndoe@example.com', '555-555-5555');


-- READ:
SELECT *
FROM sh.product
WHERE price > 1000;

SELECT product_name, price
FROM sh.product
WHERE warehouse_quantity > 50;


-- UPDATE:
UPDATE sh.product
SET price = 1099.99
WHERE product_id = 3;

UPDATE sh.user
SET email = 'newemail@example.com'
WHERE user_id = 1;

UPDATE sh.review
SET text = 'cringe'
WHERE user_id = 3;


-- DELETE:
DELETE
FROM sh.review
WHERE rating = 2;

DELETE
FROM sh.cart
WHERE product_id = 5;

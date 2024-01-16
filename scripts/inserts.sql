INSERT INTO sh.user (user_id, name, email, password, address, phone)
VALUES (1, 'John Smith', 'john@example.com', 'b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9',
        '123 Main St, Anytown, USA', '123-456-7890'),
       (2, 'Jane Doe', 'jane@example.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',
        '456 High St, Anytown, USA', '555-555-5555'),
       (3, 'Bob Johnson', 'bob@example.com', '33d67a60c78d8de7f212a1a28496eaa692eeb4139ad7c364dd4e4de7b4e10a09',
        '789 Park Ave, Anytown, USA', NULL),
       (4, 'Mary Williams', 'mary@example.com', '4f4d46ba4c9d8b16f599d55967ab35a7a3e3fb4732c3d2e579b2cfc2379b1f77',
        '10 Elm St, Anytown, USA', '555-123-4567'),
       (5, 'David Lee', 'david@example.com', 'd7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592',
        '50 Pine St, Anytown, USA', '555-987-6543'),
       (6, 'Emily Chen', 'emily@example.com', 'af91f6307c6a1215eeedc5f13ee35b7f40b55e9bc044d56e01f158af57a8b2c2',
        '100 Oak St, Anytown, USA', '555-111-2222'),
       (7, 'Michael Kim', 'michael@example.com', 'f242e6eb35c6d03d6f0855c63b1a3a5a5e93b5a74fb95692e44f69f2c755814a',
        '200 Maple St, Anytown, USA', '555-333-4444'),
       (8, 'Sara Lee', 'sara@example.com', 'ea4b764ad345f4d900e41f19c268e957b58e1d9aa700bcb534e8ebc1e44d16d7',
        '300 Cedar St, Anytown, USA', '555-777-8888'),
       (9, 'Alex Wong', 'alex@example.com', '6aef0e43b0f4818c6f3847751e7c6a3a1a1255c236e5b5ecb9a177e33be63b85',
        '400 Walnut St, Anytown, USA', '555-444-5555'),
       (10, 'Grace Lee', 'grace@example.com', '5c5d5f5ef5d5e5f5d5e5f5d5e5f5d5e5f5d5e5f5d5e5f5d5e5f5d5e5f5d5e5f',
        '500 Cherry St, Anytown, USA', '555-666-7777');


INSERT INTO sh.product (product_id, product_name, description, price, warehouse_quantity)
VALUES (1, 'iPhone 13', 'The latest iPhone model from Apple', 999.99, 100),
       (2, 'Samsung Galaxy S21', 'The latest Samsung Galaxy model', 899.99, 50),
       (3, 'iPad Pro', 'The latest iPad model from Apple', 1099.99, 75),
       (4, 'Microsoft Surface Laptop 4', 'The latest laptop from Microsoft', 1299.99, 25),
       (5, 'Sony PlayStation 5', 'The latest gaming console from Sony', 499.99, 30),
       (6, 'Xbox Series X', 'The latest gaming console from Microsoft', 499.99, 20),
       (7, 'Dell Ultrasharp 27 Monitor', '27 inch 4K monitor from Dell', 599.99, 15),
       (8, 'Bose QuietComfort 35 II', 'Wireless noise-cancelling headphones from Bose', 299.99, 40),
       (9, 'Nikon Z6 II', 'Full-frame mirrorless camera from Nikon', 1999.99, 10),
       (10, 'Canon EOS R6', 'Full-frame mirrorless camera from Canon', 2499.99, 5);


INSERT INTO sh.order (order_id, date, status)
VALUES (1, '2022-03-29 13:30:00', 1),
       (2, '2022-03-30 09:45:00', 2),
       (3, '2022-04-01 16:15:00', 3),
       (4, '2022-04-02 11:00:00', 4),
       (5, '2022-04-03 08:30:00', 1),
       (6, '2022-04-03 10:00:00', 2),
       (7, '2022-04-03 14:45:00', 3),
       (8, '2022-04-03 16:30:00', 4),
       (9, '2022-04-04 09:15:00', 1),
       (10, '2022-04-04 14:00:00', 2);


INSERT INTO sh.review (user_id, product_id, text, rating)
VALUES (1, 1, 'Great product!', 5),
       (1, 2, 'Good value for money', 4),
       (2, 3, 'Decent features', 3),
       (2, 4, 'Poor quality build', 2),
       (3, 5, 'Disappointing performance', 1),
       (4, 1, 'Love this product!', 5),
       (4, 2, 'Great price', 4),
       (5, 3, 'Good design', 4),
       (5, 4, 'Not worth the money', 2),
       (5, 5, 'Needs improvement', 3);


INSERT INTO sh.category (category_id, category_name)
VALUES (1, 'Laptops'),
       (2, 'Smartphones'),
       (3, 'Tablets'),
       (4, 'Headphones'),
       (5, 'Speakers'),
       (6, 'Cameras'),
       (7, 'Accessories'),
       (8, 'Gaming Console');


INSERT INTO sh.cart (user_id, product_id, quantity)
VALUES (1, 2, 3),
       (1, 5, 1),
       (2, 1, 2),
       (2, 4, 1),
       (3, 3, 4),
       (3, 2, 1),
       (8, 6, 2),
       (4, 1, 1),
       (5, 4, 3),
       (10, 2, 2);


INSERT INTO sh.product_category (product_id, category_id)
VALUES (1, 2),
       (2, 2),
       (3, 3),
       (4, 1),
       (8, 4),
       (9, 6),
       (10, 6),
       (5, 8),
       (6, 8);


INSERT INTO sh.order_user (order_id, user_id)
VALUES (1, 2),
       (2, 3),
       (3, 8),
       (4, 4),
       (5, 1),
       (6, 3),
       (7, 2),
       (8, 10),
       (9, 4),
       (10, 2);


INSERT INTO sh.order_product (order_id, product_id, quantity)
VALUES (1, 1, 2),
       (10, 2, 1),
       (2, 2, 4),
       (7, 4, 3),
       (3, 1, 1),
       (3, 3, 2),
       (8, 2, 5),
       (4, 3, 3),
       (5, 1, 3),
       (5, 4, 1);
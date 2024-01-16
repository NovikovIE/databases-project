create schema sh;


CREATE TABLE sh.user
(
    user_id  INTEGER PRIMARY KEY,
    name     VARCHAR(64)  NOT NULL,
    email    VARCHAR(128) NOT NULL,
    password VARCHAR(64)  NOT NULL,
    address  VARCHAR(128) NOT NULL,
    phone    VARCHAR(20)
);


CREATE TABLE sh.product
(
    product_id         INTEGER PRIMARY KEY,
    product_name       VARCHAR(64)    NOT NULL,
    description        VARCHAR(256),
    price              DECIMAL(10, 2) NOT NULL,
    warehouse_quantity INTEGER        NOT NULL
);


CREATE TABLE sh.order
(
    order_id INTEGER PRIMARY KEY,
    date     TIMESTAMP NOT NULL,
    status   SMALLINT  NOT NULL,
    CHECK (status >= 1 AND status <= 4)
);


CREATE TABLE sh.order_user
(
    order_id INTEGER NOT NULL,
    user_id  INTEGER NOT NULL,
    PRIMARY KEY (order_id, user_id),
    FOREIGN KEY (order_id) REFERENCES sh.order (order_id),
    FOREIGN KEY (user_id) REFERENCES sh.user (user_id)
);


CREATE TABLE sh.review
(
    user_id    INTEGER  NOT NULL,
    product_id INTEGER  NOT NULL,
    text       VARCHAR(1024),
    rating     SMALLINT NOT NULL,
    CHECK (rating >= 1 AND rating <= 5),
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES sh.user (user_id),
    FOREIGN KEY (product_id) REFERENCES sh.product (product_id)
);


CREATE TABLE sh.category
(
    category_id   INTEGER PRIMARY KEY,
    category_name VARCHAR(32) NOT NULL
);


CREATE TABLE sh.product_category
(
    product_id  INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (category_id) REFERENCES sh.category (category_id),
    FOREIGN KEY (product_id) REFERENCES sh.product (product_id)
);


CREATE TABLE sh.cart
(
    user_id    INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity   INTEGER NOT NULL,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES sh.user (user_id),
    FOREIGN KEY (product_id) REFERENCES sh.product (product_id)
);


CREATE TABLE sh.order_product
(
    order_id   INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity   INTEGER NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES sh.order (order_id),
    FOREIGN KEY (product_id) REFERENCES sh.product (product_id)
);
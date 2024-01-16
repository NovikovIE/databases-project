import numpy
import pandas as pd
import unittest

from tests_base import *


class TestHardQueries(unittest.TestCase):

    def __init__(self, *args, **kwargs):
        super(TestHardQueries, self).__init__(*args, **kwargs)
        self.conn = set_connection()
        self.cursor = self.conn.cursor()

    def test1(self):
        query = """
        SELECT product_name, warehouse_quantity
        FROM sh.product
        WHERE warehouse_quantity < 10
        ORDER BY warehouse_quantity DESC;
        """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 2
        for i in range(1, result.shape[0]):
            assert result.iloc[i].loc['warehouse_quantity'] <= \
                   result.iloc[i - 1].loc['warehouse_quantity']
        assert result['warehouse_quantity'].max() < 10

    def test2(self):
        query = """
                SELECT user_id, COUNT(product_id) as num_products
                FROM sh.cart
                GROUP BY user_id
                HAVING COUNT(product_id) > 1
                ORDER BY num_products DESC;
                """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 2
        for i in range(1, result.shape[0]):
            assert result.iloc[i].loc['num_products'] <= \
                   result.iloc[i - 1].loc['num_products']
        assert result['num_products'].max() > 1

    def test3(self):
        query = """
                SELECT product_name, AVG(rating) AS avg_rating, RANK() OVER (ORDER BY AVG(rating) DESC) as rank
                FROM sh.product
                         JOIN sh.review ON sh.product.product_id = sh.review.product_id
                GROUP BY product_name
                HAVING AVG(rating) >= 3
                ORDER BY avg_rating DESC;
                """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 3
        for i in range(1, result.shape[0]):
            assert result.iloc[i].loc['avg_rating'] <= \
                   result.iloc[i - 1].loc['avg_rating']
            assert result.iloc[i].loc['rank'] >= \
                   result.iloc[i - 1].loc['rank']
        assert result['avg_rating'].min() >= 3

    def test4(self):
        query = """
                SELECT *
                FROM (SELECT user_id, SUM(price) OVER (PARTITION BY order_user.user_id) as total_price
                      FROM sh.order
                               JOIN sh.order_user ON sh.order.order_id = sh.order_user.order_id
                               JOIN sh.product ON sh.order_user.user_id = sh.product.product_id
                      WHERE sh.order.status = 2) AS uitp
                GROUP BY user_id, uitp.total_price
                ORDER BY total_price DESC;
                """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 2
        for i in range(1, result.shape[0]):
            assert result.iloc[i].loc['total_price'] <= \
                   result.iloc[i - 1].loc['total_price']

    def test5(self):
        query = """
                SELECT DISTINCT u.user_id, u.name, SUM(op.quantity * p.price) OVER (PARTITION BY u.user_id) as total_order_amount
                FROM sh.user u
                         JOIN sh.order_user ou ON u.user_id = ou.user_id
                         JOIN sh.order o ON ou.order_id = o.order_id
                         JOIN sh.order_product op ON o.order_id = op.order_id
                         JOIN sh.product p ON op.product_id = p.product_id
                ORDER BY total_order_amount DESC;
                """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 3
        for i in range(1, result.shape[0]):
            assert result.iloc[i].loc['total_order_amount'] <= \
                   result.iloc[i - 1].loc['total_order_amount']
        names = set()
        for i in range(result.shape[0]):
            names.add(result.iloc[i].loc['user_id'])
        assert len(names) == result.shape[0]

    def test6(self):
        query = """
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
                """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 3
        for i in range(1, result.shape[0]):
            assert result.iloc[i].loc['order_id'] >= \
                   result.iloc[i - 1].loc['order_id']

    def end(self):
        self.cursor.close()
        self.conn.close()


class TestView(unittest.TestCase):

    def __init__(self, *args, **kwargs):
        super(TestView, self).__init__(*args, **kwargs)
        self.conn = set_connection()
        self.cursor = self.conn.cursor()

    def test1(self):
        query = """ SELECT * FROM sh.user_privacy; """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 5
        for i in range(result.shape[0]):
            assert result.iloc[i].loc['phone'] is None or result.iloc[i].loc['phone'][
                                                          :4] == '****'
            assert result.iloc[i].loc['address'][:4] == '****'
            assert result.iloc[i].loc['email'][:4] == '****'

    def test2(self):
        query = """ SELECT * FROM sh.product_public; """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 3
        assert (result.columns == ['product_name', 'description', 'price']).all()

        for i in range(result.shape[0]):
            assert len(result.iloc[i]['product_name']) <= 64
            assert len(result.iloc[i]['description']) <= 256
            assert type(result.iloc[i]['price']) is numpy.float64

    def test3(self):
        query = """ SELECT * FROM sh.user_order_count; """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 2
        assert (result.columns == ['user_id', 'order_count']).all()

        for i in range(result.shape[0]):
            assert type(result.iloc[i]['user_id']) is numpy.int64
            assert type(result.iloc[i]['order_count']) is numpy.int64

    def test4(self):
        query = """ SELECT * FROM sh.user_cart_count; """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 3
        assert (result.columns == ['user_id', 'name', 'cart_count']).all()

        for i in range(result.shape[0]):
            assert len(result.iloc[i]['name']) <= 64

    def test5(self):
        query = """ SELECT * FROM sh.product_count_by_category; """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 3
        assert (result.columns == ['category_id', 'category_name', 'product_count']).all()

        for i in range(result.shape[0]):
            assert len(result.iloc[i]['category_name']) <= 32

    def test6(self):
        query = """ SELECT * FROM sh.product_reviews_summary; """
        result = read_sql(query, self.conn)

        assert result.shape[1] == 4
        assert (result.columns == ['product_id', 'product_name', 'avg_rating',
                                   'review_count']).all()

        for i in range(result.shape[0]):
            assert len(result.iloc[i]['product_name']) <= 64
            assert type(result.iloc[i]['avg_rating']) is numpy.float64

    def end(self):
        self.cursor.close()
        self.conn.close()


if __name__ == '__main__':
    unittest.main()

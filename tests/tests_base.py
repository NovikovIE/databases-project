import os
import psycopg2 as pg
import warnings
import pandas as pd

from dataclasses import dataclass


@dataclass
class Credentials:
    dbname: str = "postgres"
    host: str = "127.0.0.1"
    port: int = 5432
    user: str = "postgres"
    password: str = "postgres"


def psycopg2_conn_string():
    return f"""
        dbname='{os.getenv("DBNAME", Credentials.dbname)}' 
        user='{os.getenv("DBUSER", Credentials.user)}' 
        host='{os.getenv("DBHOST", Credentials.host)}' 
        port='{os.getenv("DBPORT", Credentials.port)}' 
        password='{os.getenv("DBPASSWORD", Credentials.password)}'
    """


def set_connection():
    return pg.connect(psycopg2_conn_string())


def read_sql(query, conn):
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        return pd.read_sql(query, con=conn)

#!/usr/bin/env python3

import psycopg2

conn = psycopg2.connect(
    database="mydatabase",
    host="127.0.0.1",
    user="myuser",
    password="mypassword",
    port="5432",
)

cursor = conn.cursor()
query = "SELECT * FROM pg_catalog.pg_tables;"
cursor.execute(query)

conn.rollback()
tables = cursor.fetchall()

for table in tables:
    print(table)

# #!/usr/bin/env python3

# query = "SELECT * FROM pg_class.mydatabase.newtable;"
# cursor.execute(query)
# tables = cursor.fetchall()

# for table in tables:
#     print(table)

# cursor.execute(
#     "select relname from pg_class where relkind='r' and relname !~ '^(pg_|sql_)';"
# )
# print(cursor.fetchall())

# conn.commit()
# conn.rollback()


import psycopg

conn = psycopg.connect(
    "dbname=mydatabase user=myuser host=127.0.0.1 password=mypassword port=5432"
)
cursor = conn.cursor()


def create_worker_table(cursor):
    # Creating a cursor object using the cursor()
    # method

    sql = """CREATE TABLE new_schema.WORKER(
        ID BIGSERIAL NOT NULL PRIMARY KEY,
        NAME VARCHAR(100) NOT NULL,
        COUNTRY VARCHAR(50) NOT NULL,
        AGE INT,
        SALARY FLOAT
        )"""
    cursor.execute(sql)

    # Inserting values into the table
    insert_stmt = "INSERT INTO new_schema.WORKER (NAME, COUNTRY,\
        AGE, SALARY) VALUES (%s, %s, %s, %s)"
    data = [
        ("Krishna", "India", 19, 2000),
        ("Harry", "USA", 20, 7000),
        ("Malang", "Nepal", 25, 5000),
        ("Apple", "London", 26, 2000),
        ("Vishnu", "India", 29, 2000),
        ("Frank", "UAE", 21, 7000),
        ("Master", "USA", 25, 5000),
        ("Montu", "India", 26, 2000),
    ]
    cursor.executemany(insert_stmt, data)

    # Display whole table
    cursor.execute("SELECT * FROM new_schema.WORKER")
    print(cursor.fetchall())
    # Commit your changes in the database
    conn.commit()
    # Closing the connection
    conn.close()


create_worker_table(cursor)


def fetch_existing(cursor):
    cursor.execute("SELECT * FROM new_schema.newtable")
    print(cursor.fetchall())
    conn.close()


fetch_existing(cursor)

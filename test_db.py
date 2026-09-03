import psycopg2
from config.config import DATABASE_URL

try:
    connection = psycopg2.connect(DATABASE_URL)
    print("Database connected successfully!")
    connection.close()

except Exception as e:
    print("Database connection failed:")
    print(e)
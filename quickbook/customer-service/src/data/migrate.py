from client import NaiveInterface


client = NaiveInterface()

client.write("""
    CREATE SCHEMA IF NOT EXISTS bookkeeping;
""")

client.write("""
    CREATE TABLE IF NOT EXISTS bookkeeping.customers (
        id SERIAL PRIAMRY KEY NOT NULL,
        name TEXT NOT NULL
    );
""")

client.write("""
    CREATE TABLE IF NOT EXISTS bookkeeping.car_purchases (
        id SERIAL PRIMARY KEY NOT NULL,
        item_id BIGINT NOT NULL,
        item_count INTEGER NOT NULL
    );
""")

client.write("""
    CREATE TABLE IF NOT EXISTS bookkeeping.flight_purchases (
        id SERIAL PRIMARY KEY NOT NULL,
        item_id BIGINT NOT NULL,
        item_count INTEGER NOT NULL
    );
""")

client.write("""
    CREATE TABLE IF NOT EXISTS bookkeeping.room_purchases (
        id SERIAL PRIMARY KEY NOT NULL,
        item_id BIGINT NOT NULL,
        item_count INTEGER NOT NULL
    );
""")

client.write("""
    INSERT INTO bookkeeping.users (name)
    VALUES
        ('James'),
        ('Abigail')
""")

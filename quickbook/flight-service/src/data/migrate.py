from client import NaiveInterface


client = NaiveInterface()

client.write("""
    CREATE SCHEMA IF NOT EXISTS store;
""")

client.write("""
    CREATE TABLE IF NOT EXISTS store.flights (
        id SERIAL PRIAMRY KEY NOT NULL,
        airline TEXT NOT NULL,
        available INTEGER NOT NULL
    );
""")

client.write("""
    INSERT INTO store.flights (airline, available)
    VALUES
        ('WestJet', 10),
        ('AirCanada', 10)
""")

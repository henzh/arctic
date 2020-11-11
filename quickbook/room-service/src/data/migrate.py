from client import NaiveInterface


client = NaiveInterface()

client.write("""
    CREATE SCHEMA IF NOT EXISTS store;
""")

client.write("""
    CREATE TABLE IF NOT EXISTS store.rooms (
        id SERIAL PRIAMRY KEY NOT NULL,
        hotel TEXT NOT NULL,
        available INTEGER NOT NULL
    );
""")

client.write("""
    INSERT INTO store.rooms (hotel, available)
    VALUES
        ('Madison', 10),
        ('Plaza', 10)
""")

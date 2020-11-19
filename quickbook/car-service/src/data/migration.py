from data.client import NaiveInterface


def migrate():
    client = NaiveInterface()

    client.write("""
        CREATE SCHEMA IF NOT EXISTS store;
    """)

    client.write("""
        CREATE TABLE IF NOT EXISTS store.cars (
            id SERIAL PRIMARY KEY NOT NULL,
            brand TEXT NOT NULL,
            model TEXT NOT NULL,
            available INTEGER NOT NULL
        );
    """)

    client.write("""
        INSERT INTO store.cars (brand, model, available)
        VALUES
            ('Tesla', '3', 10),
            ('BMW', 'X5', 10),
            ('Audi', 'A4', 10);
    """)


if __name__ == '__main__':
    migrate()

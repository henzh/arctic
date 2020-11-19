import os
from typing import Any, List

import psycopg2


class DatabaseInterface:
    """Abstract base class for database interface using psycopg2 client"""
    def __init__(
        self,
        host: str,
        user: str,
        password: str,
        name: str,
        autocommit: bool = True
    ):
        self._conn = psycopg2.connect(host=host, user=user, password=password, dbname=name)
        self._conn.autocommit = autocommit

    def read(self, query: str) -> List[Any]:
        cursor = self._conn.cursor()

        try:
            cursor.execute(query)

            records = []
            for i, record in enumerate(cursor):
                records.append(record)
            
            return records
        finally:
            cursor.close()

    def write(self, query: str) -> None:
        cursor = self._conn.cursor()

        try:
            cursor.execute(query)
        finally:
            cursor.close()


class NaiveInterface(DatabaseInterface):
    """"Naive client reading credentials from system environment"""
    def __init__(self):
        super().__init__(os.environ.get('POSTGRES_HOST'), os.environ.get('POSTGRES_USER'),
            os.environ.get('POSTGRES_PASSWORD'), os.environ.get('POSTGRES_DBNAME'))

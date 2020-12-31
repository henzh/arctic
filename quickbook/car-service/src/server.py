from concurrent import futures
import logging

import grpc

import car_booking_pb2
import car_booking_pb2_grpc
from data.client import NaiveInterface
from data.migration import migrate


class CarBooker(car_booking_pb2_grpc.CarBookerServicer):

    def __init__(self):
        self._dinterface = NaiveInterface()

    def AddInventory(self, request, context):
        query = """
            SELECT id, brand, model, available
            FROM store.cars
            WHERE id = {}
        """.format(str(request.car_id))

        records = self._dinterface.read(query)
        count = len(records)

        if count != 1:
            raise Exception(f'Expected 1 car with id {str(request.car_id)}, but found {str(count)}')

        car_id = records[0][0]
        brand = records[0][1]
        model = records[0][2]
        available = records[0][3]

        total = request.quantity + available

        query = """
            UPDATE store.cars
            SET available = {available}
            WHERE id = {car_id}
        """.format(car_id=car_id, available=str(total))

        self._dinterface.write(query)

        return car_booking_pb2.AddInventoryReply(
            car=car_booking_pb2.Car(car_id=car_id, brand=brand, model=model, quantity=total))

    def BookCar(self, request, context):
        query = """
            SELECT id, brand, model, available
            FROM store.cars
            WHERE id = {}
        """.format(str(request.car_id))

        records = self._dinterface.read(query)
        count = len(records)

        if count != 1:
            raise Exception(f'Expected 1 car with id {str(request.car_id)}, but found {str(count)}')

        car_id = records[0][0]
        brand = records[0][1]
        model = records[0][2]
        available = records[0][3]

        remaining = max(available - request.quantity, 0)

        query = """
            UPDATE store.cars
            SET available = {remaining}
            WHERE id = {car_id}
        """.format(car_id=car_id, remaining=str(remaining))

        self._dinterface.write(query)

        return car_booking_pb2.AddInventoryReply(
            car=car_booking_pb2.Car(car_id=car_id, brand=brand, model=model, quantity=remaining))


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    car_booking_pb2_grpc.add_CarBookerServicer_to_server(CarBooker(), server)

    server.add_insecure_port('[::]:50051')
    server.start()

    server.wait_for_termination()


if __name__ == '__main__':
    logging.basicConfig()
    migrate()
    serve()

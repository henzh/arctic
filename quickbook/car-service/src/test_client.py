import logging

import grpc

import car_booking_pb2
import car_booking_pb2_grpc


def run():
    with grpc.insecure_channel('localhost:50051') as channel:
        stub = car_booking_pb2_grpc.CarBookerStub(channel)

        print('Action 1: Add Inventory')
        request = car_booking_pb2.AddInventoryRequest(car_id=1, quantity=10)
        response = stub.AddInventory(request)
        print(response)

        print('Action 2: Book Car')
        request = car_booking_pb2.BookCarRequest(car_id=2, quantity=5)
        response = stub.BookCar(request)
        print(response)

        print('Action 3: Add Inventory')
        request = car_booking_pb2.AddInventoryRequest(car_id=2, quantity=2)
        response = stub.AddInventory(request)
        print(response)


if __name__ == '__main__':
    logging.basicConfig()
    run()

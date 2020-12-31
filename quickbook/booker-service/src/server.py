from concurrent import futures

import grpc

import booker_pb2
import booker_pb2_grpc
import car_booking_pb2
import car_booking_pb2_grpc
import room_booking_pb2
import room_booking_pb2_grpc
import flight_booking_pb2
import flight_booking_pb2_grpc


class CarBooker(car_booking_pb2_grpc.CarBookerServicer):

    def Book(self, request, context):
        booked = True

        with grpc.insecure_channel('localhost:50052') as channel:
            stub = car_booking_pb2_grpc.CarBookerStub(channel)            
            car = stub.BookCarRequest(
                car_booking_pb2.BookCarRequest(
                    car_id=request.car.id,
                    quantity=request.car.quantity)) 

        with grpc.insecure_channel('localhost:50053') as channel:
            stub = room_booking_pb2_grpc.RoomBookerStub(channel)
            room = stub.BookRoomRequest(
                room_booking_pb2.BookRoomRequest(
                    room_id=request.room.id,
                    quantity=request.room.quantity))

        with grpc.insecure_channel('localhost:50054') as channel:
            stub = room_booking_pb2_grpc.RoomBookerStub(channel) 
            flight = stub.BookFlightRequest(
                flight_booking_pb2.BookFlightRequest(
                    flight_id=request.flight.id,
                    quantity=request.flight.quantity))
        
        if booked:
            return booker_pb2.grpc.BookReply(
                car=car,
                room=room,
                flight=flight,
                booked=booked)
        else:
            return booker_pb2.grpc.BookReply(
                car=None,
                room=None,
                flight=None,
                booked=booked)
            

    def List(self, request, context):
        with grpc.insecure_channel('localhost:50052') as channel:
            stub = car_booking_pb2_grpc.CarBookerStub(channel)
            cars = stub.ListCars()

        with grpc.insecure_channel('localhost:50053') as channel:
            stub = room_booking_pb2_grpc.RoomBookerStub(channel)
            rooms = stub.ListRooms()

        with grpc.insecure_channel('localhost:50054') as channel:
            stub = room_booking_pb2_grpc.FlightBookerStub(channel)
            flights = stub.ListFlights()
        
        return booker_pb2_grpc.ListReply(cars=cars, rooms=rooms, flights=flights)


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    car_booking_pb2_grpc.add_CarBookerServicer_to_server(CarBooker(), server)

    server.add_insecure_port('[::]:50051')
    server.start()

    server.wait_for_termination()
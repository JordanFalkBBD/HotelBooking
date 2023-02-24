# HotelBooking

## ERD Diagram
![ERD For Hotel Booking System](https://user-images.githubusercontent.com/122435537/221135114-3d4a2436-6b7a-4f4c-93a8-b962ba843bb8.png)

## Business Rules
  - Zero or many Customers can have 1 or more reservations
      - Zero or many Customers have one and only one CustomerReservations
      - One and only one CustomerReservations have one or many Reservations
  - One or many Reservations have one or many rooms
      - One and only Reservation has 1 or many ReservationRooms
      - One or many ReservationRoom has one and only one Room
  - Zero or many Room has one and only one RoomType
  - One and only one Reservation has zero or many Payments
  - One or many Payments has one and only one PaymentType
  - One or many Payment has one and only one PaymentMethod

## Contributors
 - [Karl Haupt](https://github.com/KarlHaupt)
 - [Jordan Falk](https://github.com/JordanFalkBBD)
 - [Thabani Nkonde](https://github.com/thabaniBBD2712)
 - [Kgotlelelo Masenamela](https://github.com/masek002)

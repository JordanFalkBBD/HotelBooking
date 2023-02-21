USE HotelReservationDB;

INSERT INTO [dbo].[Customers] (FirstName, LastName, Email, Cellphone, BirthDate) VALUES
('John', 'Doe', 'johndoe@example.com', '0825555555', '1980-01-01'),
('Jane', 'Doe', 'janedoe@example.com', '0825555555', '1982-02-02'),
('Bob', 'Smith', 'bobsmith@example.com', '0825555555', '1975-03-03'),
('Alice', 'Johnson', 'alicejohnson@example.com', '0825555555', '1990-04-04'),
('Mike', 'Brown', 'mikebrown@example.com', '0825555555', '1988-05-05'),
('Sara', 'Lee', 'saralee@example.com', '0825555555', '1979-06-06'),
('David', 'Garcia', 'davidgarcia@example.com', '0825555555', '1995-07-07'),
('Emily', 'Davis', 'emilydavis@example.com', '0825555555', '1983-08-08'),
('Tom', 'Wilson', 'tomwilson@example.com', '0825555555', '1977-09-09'),
('Kelly', 'Taylor', 'kellytaylor@example.com', '0825555555', '1986-10-10'),
('Ben', 'Brown', 'benbrown@example.com', '0825555555', '1982-11-11'),
('Rachel', 'Miller', 'rachelmiller@example.com', '0825555555', '1974-12-12'),
('Steven', 'Jones', 'stevenjones@example.com', '0825555555', '1992-01-13'),
('Laura', 'Martinez', 'lauramartinez@example.com', '0825555555', '1981-02-14'),
('Kevin', 'Davis', 'kevindavis@example.com', '0825555555', '1978-03-15'),
('Amanda', 'Garcia', 'amandagarcia@example.com', '0825555555', '1993-04-16'),
('Chris', 'Wilson', 'chriswilson@example.com', '0825555555', '1987-05-17'),
('Julia', 'Taylor', 'juliataylor@example.com', '0825555555', '1976-06-18'),
('Eric', 'Brown', 'ericbrown@example.com', '0825555555', '1984-07-19'),
('Amy', 'Lee', 'amylee@example.com', '0825555555', '1991-08-20');

INSERT INTO dbo.Reservations (FromDate, ToDate, ReservationDate, DiscountRate, TotalPrice)
VALUES
('2022-05-01 12:00:00', '2022-05-03 12:00:00', '2022-04-01 10:00:00', 20, 120),
('2022-05-05 12:00:00', '2022-05-07 12:00:00', '2022-04-02 11:00:00', 10, 180),
('2022-05-10 12:00:00', '2022-05-12 12:00:00', '2022-04-03 12:00:00', 5, 200),
('2022-05-15 12:00:00', '2022-05-17 12:00:00', '2022-04-04 13:00:00', 0, 300),
('2022-05-20 12:00:00', '2022-05-22 12:00:00', '2022-04-05 14:00:00', 15, 150),
('2022-05-25 12:00:00', '2022-05-27 12:00:00', '2022-04-06 15:00:00', 30, 90),
('2022-05-30 12:00:00', '2022-06-01 12:00:00', '2022-04-07 16:00:00', 20, 120),
('2022-06-05 12:00:00', '2022-06-07 12:00:00', '2022-04-08 17:00:00', 10, 180),
('2022-06-10 12:00:00', '2022-06-12 12:00:00', '2022-04-09 18:00:00', 5, 200),
('2022-06-15 12:00:00', '2022-06-17 12:00:00', '2022-04-10 19:00:00', 0, 300),
('2022-06-20 12:00:00', '2022-06-22 12:00:00', '2022-04-11 20:00:00', 15, 150),
('2022-06-25 12:00:00', '2022-06-27 12:00:00', '2022-04-12 21:00:00', 30, 90),
('2022-07-01 12:00:00', '2022-07-03 12:00:00', '2022-04-13 22:00:00', 20, 120),
('2022-07-05 12:00:00', '2022-07-07 12:00:00', '2022-04-14 23:00:00', 10, 180),
('2022-05-15 12:00:00', '2022-05-17 12:00:00', '2022-04-04 13:00:00', 0, 300),
('2022-05-20 12:00:00', '2022-05-22 12:00:00', '2022-04-05 14:00:00', 15, 150),
('2022-05-25 12:00:00', '2022-05-27 12:00:00', '2022-04-06 15:00:00', 30, 90),
('2022-05-30 12:00:00', '2022-06-01 12:00:00', '2022-04-07 16:00:00', 20, 120);

INSERT INTO [dbo].[PaymentMethods] (PaymentMethodDesc)
VALUES
('Cash'),
('Credit Card'),
('EFT'),
('Ozow'),
('Other');

INSERT INTO [dbo].[PaymentTypes] (PaymentTypeDesc)
VALUES
('Type1'),
('Type2'),
('Type3');

INSERT INTO [dbo].[Payments] (TotalAmount, PaymentDate, ReservationID, PaymentTypeID, PaymentMethodID)
VALUES
(100, '2022-05-01 10:00:00', 1, 1, 1),
(200, '2022-05-02 11:00:00', 1, 2, 2),
(150, '2022-05-03 12:00:00', 2, 3, 3),
(300, '2022-05-04 13:00:00', 2, 1, 1),
(120, '2022-05-05 14:00:00', 3, 2, 5),
(180, '2022-05-06 15:00:00', 4, 3, 1),
(90, '2022-05-07 16:00:00', 5, 1, 2),
(200, '2022-05-08 17:00:00', 6, 2, 3),
(150, '2022-05-09 18:00:00', 7, 3, 4),
(300, '2022-05-10 19:00:00', 8, 1, 5),
(120, '2022-05-11 20:00:00', 9, 2, 1),
(180, '2022-05-12 21:00:00', 10, 3, 2),
(90, '2022-05-13 22:00:00', 11, 1, 3),
(200, '2022-05-14 23:00:00', 12, 2, 4),
(150, '2022-05-15 00:00:00', 13, 3, 5),
(300, '2022-05-16 01:00:00', 14, 1, 1),
(120, '2022-05-17 02:00:00', 15, 2, 2),
(180, '2022-05-18 03:00:00', 16, 3, 3),
(90, '2022-05-19 04:00:00', 17, 1, 4),
(200, '2022-05-20 05:00:00', 18, 2, 5);

INSERT INTO [dbo].[RoomTypes] (RoomType, RoomDescription, RoomCapacity)
VALUES
('Standard', 'A simple room with basic amenities', 2),
('Deluxe', 'A spacious room with additional amenities', 2),
('Family', 'A larger room with additional beds', 4),
('Suite', 'A luxurious room with separate living area', 2);

INSERT INTO [dbo].[Rooms] (NoOfGuests, RoomRate, RoomTypeID)
VALUES
(2, 100, 1),
(2, 120, 2),
(3, 150, 3),
(3, 180, 4),
(4, 200, 1),
(4, 220, 2),
(2, 110, 3),
(2, 130, 4),
(3, 170, 1),
(3, 190, 2),
(4, 220, 3),
(4, 240, 4),
(2, 120, 1),
(2, 140, 2),
(3, 180, 3),
(3, 200, 4),
(4, 240, 1),
(4, 260, 2),
(2, 130, 3),
(2, 150, 4);

SELECT * FROM Customers;
SELECT * FROM Reservations;
SELECT * FROM PaymentMethods;
SELECT * FROM PaymentTypes;
SELECT * FROM Payments;
SELECT * FROM Rooms;
SELECT * FROM RoomTypes;
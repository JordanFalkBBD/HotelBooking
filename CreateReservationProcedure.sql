CREATE PROCEDURE create_reservation
@FirstName [varchar](50),
@LastName [varchar](120),
@Email [varchar](120),
@Cellphone [varchar](11),
@BirthDate date,
@FromDate date,
@ToDate date,
@ReservationDate date,
@DiscountRate int,
@TotalPrice decimal(18, 2),
@NoOfGuests int,
@RoomRate decimal(18, 2),
@RoomTypeID int
AS
	DECLARE @Customer_ID int;
	DECLARE @Reservation_ID int;

	IF (NOT EXISTS(SELECT * FROM Customers WHERE FirstName = @FirstName AND LastName = @LastName AND BirthDate = @BirthDate))
	BEGIN
		INSERT INTO Customers (FirstName, LastName,	Email, Cellphone, BirthDate)
		VALUES (@FirstName, @LastName,@Email, @Cellphone,@BirthDate);

	END
	ELSE
	BEGIN
		SELECT * FROM Customers WHERE FirstName = @FirstName AND LastName = @LastName AND BirthDate = @BirthDate;
	END

	INSERT INTO Reservations (FromDate,	ToDate,	ReservationDate, DiscountRate, TotalPrice)
	VALUES (@FromDate,@ToDate,@ReservationDate,@DiscountRate,@TotalPrice);

	SET @Customer_ID = (SELECT CustomerID FROM Customers WHERE FirstName = @FirstName AND LastName = @LastName AND BirthDate = @BirthDate);
	SET @Reservation_ID = ( SELECT ReservationID FROM Reservations WHERE FromDate = @FromDate AND ToDate = @ToDate AND ReservationDate = @ReservationDate AND DiscountRate = @DiscountRate AND TotalPrice = @TotalPrice);

	INSERT INTO CustomerReservations (CustomerID, ReservationID)
	VALUES (@Customer_ID,@Reservation_ID);

	INSERT INTO Rooms (RoomTypeID,NoOfGuests,RoomRate)
	VALUES (@RoomTypeID,@NoOfGuests,@RoomRate);
GO

EXEC create_reservation 
@FirstName = 'Kgotlelelo', 
@LastName = 'Masenamela', 
@Email = 'kg@gmail.com', 
@Cellphone = '0724287204', 
@BirthDate = '1976-07-26',
@FromDate = '2023-02-25',
@ToDate = '2023-02-28',
@ReservationDate = '2023-02-21',
@DiscountRate = 50,
@TotalPrice = 1000,
@NoOfGuests = 1,
@RoomRate = 1000,
@RoomTypeID = 1;

SELECT * FROM Customers;
SELECT * FROM Reservations;
SELECT * FROM CustomerReservations;
SELECT * FROM Rooms;
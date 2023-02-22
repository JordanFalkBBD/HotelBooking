-- View: Returns all the reservation for a certain date range including the Price, NumberOfRooms, and the Customers Full Name
CREATE VIEW [dbo].[ReservationsReport]
AS
SELECT 	r.[ReservationID],
		r.[ReservationDate],
		r.[TotalPrice],
		COUNT([Rooms].[RoomID])	AS NumberOfRooms,
		c.[LastName],
		c.[FirstName]
FROM [Reservations] r
LEFT JOIN [CustomerReservations] cr
ON r.[ReservationID] = cr.[ReservationID]
LEFT JOIN [Customers] c
ON cr.[CustomerID] = c.[CustomerID]
LEFT JOIN [ReservationRooms] rr
ON r.[ReservationID] = rr.[ReservationID]
LEFT JOIN [Rooms]
ON [Rooms].[RoomID] = rr.[RoomID]
LEFT JOIN [RoomTypes]
ON [Rooms].[RoomTypeID] = [RoomTypes].[RoomTypeID]
WHERE 	r.[ReservationDate] <= '2022-12-31'
AND 	r.[ReservationDate] >= '2022-01-01'
GROUP BY 	r.[ReservationID],
			r.[ReservationDate],
			r.[TotalPrice],
			c.[LastName],
			c.[FirstName]

GO

SELECT * FROM [dbo].[ReservationsReport];
GO

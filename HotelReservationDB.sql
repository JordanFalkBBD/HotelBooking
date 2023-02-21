USE master
IF EXISTS(select * from sys.databases where name='HotelReservationDB')
	DROP DATABASE HotelReservationDB

CREATE DATABASE HotelReservationDB;
GO

USE HotelReservationDB;

CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1)	NOT NULL,
	[FirstName] [varchar](50)			NOT NULL,
	[LastName] [varchar](120)			NOT NULL,
	[Email] [varchar](120)				NOT NULL,
	[Cellphone] [varchar](11)			NOT NULL,
	[BirthDate] date					NOT NULL,
	CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
	(
		[CustomerID] ASC
	)
);
GO

ALTER TABLE [dbo].[Customers] WITH CHECK ADD CONSTRAINT [CK_CustomerBirthDate] CHECK  (([BirthDate]<getdate()))
GO

CREATE TABLE [dbo].[Reservations](
	[ReservationID] [int]	IDENTITY(1,1)		NOT NULL,
	[FromDate]				date				NOT NULL,
	[ToDate]				date				NOT NULL,
	[ReservationDate]		date				NOT NULL,
	[DiscountRate]			[int]				NOT NULL,
	[TotalPrice]			decimal(18, 2)		NOT NULL,
	CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
	(
		[ReservationID] ASC
	)
);
GO

CREATE TABLE [dbo].[CustomerReservations](
	[CustomerReservationID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int]							NOT NULL,
	[ReservationID] [int]						NOT NULL,
	CONSTRAINT [PK_CustomerReservations] PRIMARY KEY CLUSTERED 
	(
		[CustomerReservationID] ASC
	),
	CONSTRAINT [FK_CustomerReservations_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES dbo.Customers(CustomerID),
	CONSTRAINT [FK_CustomerReservations_ReservationID] FOREIGN KEY ([ReservationID]) REFERENCES dbo.Reservations(ReservationID)
);
GO

CREATE TABLE [dbo].[RoomTypes](
	[RoomTypeID]		[int] IDENTITY(1,1)		NOT NULL,
	[RoomType]			[varchar](30)			NOT NULL,
	[RoomDescription]	[varchar](120)			NULL,
	[RoomCapacity]      [int]                   NOT NULL,
	CONSTRAINT [PK_RoomTypes] PRIMARY KEY CLUSTERED ([RoomTypeID] ASC)
);
GO

CREATE TABLE [dbo].[Rooms](
	[RoomID]			int IDENTITY(1,1)		NOT NULL,
	[RoomTypeID]		int						NOT NULL,
	[NoOfGuests]		int						NOT NULL,
	[RoomRate]			decimal(18, 2)			NOT NULL,
	CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED ([RoomID] ASC),
	CONSTRAINT [FK_Rooms_RoomTypeID] FOREIGN KEY ([RoomTypeID]) REFERENCES dbo.RoomTypes(RoomTypeID)
);
GO

CREATE TABLE [dbo].[ReservationRooms](
	[ReservationRoomID]	int IDENTITY(1,1)		NOT NULL,
	[ReservationID]		int 					NOT NULL,
	[RoomID]			int						NOT NULL,
	[NoOfRoom]			int						NOT NULL,
	CONSTRAINT [PK_ReservationRoom_ReservationRoomID] PRIMARY KEY CLUSTERED ([ReservationRoomID] ASC),
	CONSTRAINT [FK_Rooms_RoomID] FOREIGN KEY ([RoomID]) REFERENCES dbo.Rooms(RoomID),
	CONSTRAINT [FK_Reservation_ReservationID] FOREIGN KEY ([ReservationID]) REFERENCES dbo.Reservations(ReservationID),
);
GO

CREATE TABLE [dbo].[PaymentTypes](
	[PaymentTypeID]		[int] IDENTITY(1,1)		NOT NULL,
	[PaymentTypeDesc]	[varchar](30)			NOT NULL,
	CONSTRAINT [PK_PaymentTypes] PRIMARY KEY CLUSTERED ([PaymentTypeID] ASC)
);
GO

CREATE TABLE [dbo].[PaymentMethods](
	[PaymentMethodID]		[int] IDENTITY(1,1)		NOT NULL,
	[PaymentMethodDesc]		[varchar](30)			NOT NULL,
	CONSTRAINT [PK_PaymentMethods] PRIMARY KEY CLUSTERED ([PaymentMethodID] ASC)
);
GO

CREATE TABLE [dbo].[Payments](
	[PaymentID]			[INT]  IDENTITY(1,1)	NOT NULL,
	[ReservationID]		[INT]					NOT NULL,
	[PaymentTypeID]		[INT]					NOT NULL,
	[PaymentMethodID]	[INT]					NOT NULL,
	[TotalAmount]		decimal(18, 2)			NOT NULL,
	[PaymentDate]		[DATETIME]				NOT NULL,
	CONSTRAINT [FK_Payments_ReservationID] FOREIGN KEY ([ReservationID]) REFERENCES dbo.Reservations(ReservationID),
	CONSTRAINT [FK_Payments_PaymentTypeID] FOREIGN KEY ([PaymentTypeID]) REFERENCES dbo.PaymentTypes(PaymentTypeID),
	CONSTRAINT [FK_Payments_PaymentMethodID] FOREIGN KEY ([PaymentMethodID]) REFERENCES dbo.PaymentMethods(PaymentMethodID),
);
GO

CREATE VIEW [dbo].[ReservationsReport]
AS
SELECT 	r.[ReservationID],
		r.[ReservationDate],
		r.[TotalPrice],
		COUNT([Rooms].[RoomID])						AS NumberOfRooms,
		STRING_AGG([RoomTypes].[RoomType], ', ') 	AS RoomTypes,
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

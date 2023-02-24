USE master
IF EXISTS(select * from sys.databases where name='HotelReservationDB')
	DROP DATABASE HotelReservationDB

CREATE DATABASE HotelReservationDB;
GO

USE HotelReservationDB;

CREATE TABLE [dbo].[Customers](
	[CustomerID]			INT IDENTITY(1,1)	NOT NULL,
	[FirstName]				VARCHAR(50)			NOT NULL,
	[LastName]				VARCHAR(120)		NOT NULL,
	[Email]					VARCHAR(120)		NOT NULL,
	[Cellphone]				VARCHAR(11)			NOT NULL,
	[BirthDate]				DATE				NOT NULL,
	CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);
GO

ALTER TABLE [dbo].[Customers] WITH CHECK ADD CONSTRAINT [CK_CustomerBirthDate] CHECK  (([BirthDate]<getdate()))
GO

CREATE TABLE [dbo].[Reservations](
	[ReservationID]			INT	IDENTITY(1,1)	NOT NULL,
	[FromDate]				DATE				NOT NULL,
	[ToDate]				DATE				NOT NULL,
	[ReservationDate]		DATE				NOT NULL,
	[DiscountRate]			INT					NOT NULL,
	[TotalPrice]			DECIMAL(18, 2)		NOT NULL,
	CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED ([ReservationID] ASC)
);
GO

CREATE TABLE [dbo].[CustomerReservations](
	[CustomerReservationID]		INT IDENTITY(1,1)	NOT NULL,
	[CustomerID]				INT					NOT NULL,
	[ReservationID]				INT					NOT NULL,
	CONSTRAINT [PK_CustomerReservations] PRIMARY KEY CLUSTERED ([CustomerReservationID] ASC),
	CONSTRAINT [FK_CustomerReservations_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES dbo.Customers(CustomerID),
	CONSTRAINT [FK_CustomerReservations_ReservationID] FOREIGN KEY ([ReservationID]) REFERENCES dbo.Reservations(ReservationID)
);
GO

CREATE TABLE [dbo].[RoomTypes](
	[RoomTypeID]		INT IDENTITY(1,1)		NOT NULL,
	[RoomType]			VARCHAR(30)				NOT NULL,
	[RoomDescription]	VARCHAR(120)			NULL,
	[RoomCapacity]		INT						NOT NULL,
	CONSTRAINT [PK_RoomTypes] PRIMARY KEY CLUSTERED ([RoomTypeID] ASC)
);
GO

CREATE TABLE [dbo].[Rooms](
	[RoomID]			INT IDENTITY(1,1)		NOT NULL,
	[RoomTypeID]		INT						NOT NULL,
	[NoOfGuests]		INT						NOT NULL,
	[RoomRate]			DECIMAL(18, 2)			NOT NULL,
	CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED ([RoomID] ASC),
	CONSTRAINT [FK_Rooms_RoomTypeID] FOREIGN KEY ([RoomTypeID]) REFERENCES dbo.RoomTypes(RoomTypeID)
);
GO

CREATE TABLE [dbo].[ReservationRooms](
	[ReservationRoomID]	INT IDENTITY(1,1)		NOT NULL,
	[ReservationID]		INT 					NOT NULL,
	[RoomID]			INT						NOT NULL,
	CONSTRAINT [PK_ReservationRoom_ReservationRoomID] PRIMARY KEY CLUSTERED ([ReservationRoomID] ASC),
	CONSTRAINT [FK_Rooms_RoomID] FOREIGN KEY ([RoomID]) REFERENCES dbo.Rooms(RoomID),
	CONSTRAINT [FK_Reservation_ReservationID] FOREIGN KEY ([ReservationID]) REFERENCES dbo.Reservations(ReservationID),
);
GO

CREATE TABLE [dbo].[PaymentTypes](
	[PaymentTypeID]		INT IDENTITY(1,1)	NOT NULL,
	[PaymentTypeDesc]	VARCHAR(30)			NOT NULL,
	CONSTRAINT [PK_PaymentTypes] PRIMARY KEY CLUSTERED ([PaymentTypeID] ASC)
);
GO

CREATE TABLE [dbo].[PaymentMethods](
	[PaymentMethodID]		INT IDENTITY(1,1)	NOT NULL,
	[PaymentMethodDesc]		VARCHAR(30)			NOT NULL,
	CONSTRAINT [PK_PaymentMethods] PRIMARY KEY CLUSTERED ([PaymentMethodID] ASC)
);
GO

CREATE TABLE [dbo].[Payments](
	[PaymentID]			INT  IDENTITY(1,1)	NOT NULL,
	[ReservationID]		INT					NOT NULL,
	[PaymentTypeID]		INT					NOT NULL,
	[PaymentMethodID]	INT					NOT NULL,
	[TotalAmount]		DECIMAL(18, 2)		NOT NULL,
	[PaymentDate]		DATE				NOT NULL,
	[PaymentTime]		TIME				NOT NULL,
	CONSTRAINT [FK_Payments_ReservationID] FOREIGN KEY ([ReservationID]) REFERENCES dbo.Reservations(ReservationID),
	CONSTRAINT [FK_Payments_PaymentTypeID] FOREIGN KEY ([PaymentTypeID]) REFERENCES dbo.PaymentTypes(PaymentTypeID),
	CONSTRAINT [FK_Payments_PaymentMethodID] FOREIGN KEY ([PaymentMethodID]) REFERENCES dbo.PaymentMethods(PaymentMethodID),
);
GO

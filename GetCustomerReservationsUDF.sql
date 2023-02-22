-- GetCustomerReservations -> Params: customerID
-- And returns a list of all reservations made by that customer, along with the reservation date
CREATE FUNCTION [dbo].[GetCustomerReservations] (
@customerID INT
) 
RETURNS TABLE 
AS 
RETURN ( 
	SELECT c.FirstName, r.ReservationDate as ReservationDate 
	FROM Customers c JOIN CustomerReservations cr 
		ON c.CustomerID = cr.CustomerID 
		INNER JOIN Reservations r ON cr.ReservationID = r.ReservationID 
			WHERE c.CustomerID = @customerID 
	GROUP BY c.FirstName, r.ReservationDate
	)

SELECT * FROM dbo.GetCustomerReservations(21); 
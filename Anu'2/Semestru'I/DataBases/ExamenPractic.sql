use [PracticalTest]

CREATE TABLE ElectricScooter(
	SerialNumber int PRIMARY KEY,
);

CREATE TABLE DockingStation(
	DockingStationID int PRIMARY KEY IDENTITY,
	Street varchar(30),
	Number int,
	City varchar(30),
);

CREATE TABLE Cards(
	CardID int PRIMARY KEY IDENTITY,
	Bank varchar(30),
	Name varchar(30)
);

--- many to many, I introduced another field, a primary key because multiple rides can have the same pickup and dropoff, also the same scooterID and the same CardID
CREATE TABLE Ride(
	RideID int PRIMARY KEY IDENTITY,
	ScooterID int FOREIGN KEY REFERENCES ElectricScooter(SerialNumber),
	Price money,
	pickup int FOREIGN KEY REFERENCES DockingStation(DockingStationID),
	dropoff int FOREIGN KEY REFERENCES DockingStation(DockingStationID),
	startAt time,
	endAt time,
	CardID int FOREIGN KEY REFERENCES Cards(CardID)
);

--one to many, because a ride can cause multiple incidents
CREATE TABLE Incident(
	IncidentID int PRIMARY KEY IDENTITY,
	RideID int FOREIGN KEY REFERENCES Ride(RideID),
	Description varchar(100)
);


INSERT INTO ElectricScooter(SerialNumber) values(1)
INSERT INTO ElectricScooter(SerialNumber) values(2)
INSERT INTO ElectricScooter(SerialNumber) values(3)
INSERT INTO ElectricScooter(SerialNumber) values(4)
INSERT INTO ElectricScooter(SerialNumber) values(5)

INSERT INTO DockingStation(Street, Number, City) values('Bucegi', 6, 'Cluj')
INSERT INTO DockingStation(Street, Number, City) values('Mehedinti', 3, 'Cluj')
INSERT INTO DockingStation(Street, Number, City) values('Parang', 9, 'Cluj')
INSERT INTO DockingStation(Street, Number, City) values('Primaverii', 10, 'Cluj')
INSERT INTO DockingStation(Street, Number, City) values('21 Decembrie', 18, 'Cluj')

INSERT INTO Cards(Bank, Name) values('BT', 'Vasile')
INSERT INTO Cards(Bank, Name) values('BRD', 'Ion')
INSERT INTO Cards(Bank, Name) values('BT', 'George')
INSERT INTO Cards(Bank, Name) values('BCR', 'Marcel')
INSERT INTO Cards(Bank, Name) values('BRD', 'Florin')

INSERT INTO Ride(ScooterID, Price, pickup, dropoff, startAt, endAt, CardID) values(1, 8, 1, 3, '12:00:00', '12:05:00', 2)
INSERT INTO Ride(ScooterID, Price, pickup, dropoff, startAt, endAt, CardID) values(2, 7, 1, 2, '22:10:00', '22:15:00', 3)
INSERT INTO Ride(ScooterID, Price, pickup, dropoff, startAt, endAt, CardID) values(4, 8, 2, 4, '15:00:00', '15:11:00', 4)
INSERT INTO Ride(ScooterID, Price, pickup, dropoff, startAt, endAt, CardID) values(3, 5, 4, 2, '12:00:00', '12:05:00', 1)
INSERT INTO Ride(ScooterID, Price, pickup, dropoff, startAt, endAt, CardID) values(5, 7, 1, 5, '14:00:00', '14:20:00', 5)

INSERT INTO Incident(RideID, Description) values (2, 'colision')
INSERT INTO Incident(RideID, Description) values (1, 'a')
INSERT INTO Incident(RideID, Description) values (3, 'b')
INSERT INTO Incident(RideID, Description) values (4, 'a')

GO
CREATE OR ALTER PROCEDURE uspDeleteCardsAndRides @S varchar(30)
AS
BEGIN
	IF EXISTS (SELECT c.Name FROM Cards as c WHERE c.Name = @S)
	BEGIN
		DELETE FROM Ride WHERE CardID = (SELECT CardID FROM Cards WHERE Name = @S)
		DELETE FROM Cards WHERE Name = @S
	END
END

EXEC uspDeleteCardsAndRides 'Florin'

CREATE OR ALTER VIEW vDisplayDockingStations
AS
	SELECT *
	FROM DockingStation
	WHERE EXISTS
	(SELECT r.pickup
	FROM Ride as r
	GROUP BY pickup
	HAVING MAX(pickup) > 0)
GO

SELECT *
FROM vDisplayDockingStations

CREATE OR ALTER FUNCTION ufFilterRides (@T int)
RETURNS TABLE
RETURN SELECT r.ScooterID, r.pickup, r.dropoff, r.startAt, r.endAt
	   FROM Ride as r
	   WHERE r.RideID IN
	   (SELECT i.RideID
	   FROM Incident as i
	   GROUP BY RideID
	   HAVING COUNT(*) < @T)

SELECT *
FROM ufFilterRides(2)

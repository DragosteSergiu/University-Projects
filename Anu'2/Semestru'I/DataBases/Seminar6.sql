CREATE DATABASE IPracticalTest923
GO

USE [IPracticalTest923]
GO

DROP TABLE RoutesStations
DROP TABLE Stations
DROP TABLE Routes
DROP TABLE Trains
DROP TABLE TrainTypes

GO

CREATE TABLE TrainTypes(
	TrainTypeID int PRIMARY KEY,
	TTName varchar(70),
	TTDescription varchar(300)
)

CREATE TABLE Trains(
	TrainID int PRIMARY KEY,
	TName varchar(70),
	TrainTypeID int REFERENCES TrainTypes(TrainTypeID)
)

CREATE TABLE Stations(
	StationID int PRIMARY KEY,
	SName varchar(70) UNIQUE
)

CREATE TABLE Routes(
	RouteID int PRIMARY KEY,
	RName varchar(70) UNIQUE,
	TrainID int REFERENCES Trains(TrainID)
)

CREATE TABLE RoutesStations(
	RouteID int REFERENCES Routes(RouteID),
	StationID int REFERENCES Stations(StationID),
	Arrival time, 
	Departure time,
	PRIMARY KEY(RouteID, StationID)
)

GO

CREATE OR ALTER PROCEDURE uspUpdateRoute 
	(@rName varchar(70), @sName varchar(70), @arrival time, @departure time)
AS
BEGIN
	IF NOT EXISTS(SELECT * 
				  FROM Routes 
				  WHERE RName = @rName)
	BEGIN
		RAISERROR('Invalid route name.', 16, 1)
		RETURN
	END
	IF NOT EXISTS(SELECT * 
				  FROM Stations 
				  WHERE SName = @sName)
	BEGIN
		RAISERROR('Invalid station name.', 16, 1)
		RETURN
	END

	DECLARE @RID int, @SID int
	SET @RID = (SELECT(RouteID) FROM Routes WHERE RName = @rName)
	SET @SID = (SELECT(StationID) FROM Stations WHERE SName = @sName)

	IF NOT EXISTS(SELECT *
				  FROM RoutesStations
				  WHERE RouteID = @RID AND StationID = @SID)
		INSERT RoutesStations(RouteID, StationID, Arrival, Departure)
		values(@RID, @SID, @arrival, @departure)
	ELSE
		UPDATE RoutesStations
		SET Arrival = @arrival, Departure = @departure
		WHERE RouteID = @RID AND StationID = @SID
END

GO

INSERT TrainTypes VALUES(1, 'type1', 'type1description'), (2, 'type2', 'type2description')
INSERT Trains VALUES(1, 't1', 1), (2, 't2', 1), (3, 't3', 2), (4, 't4', 2)
INSERT Routes VALUES(1, 'r1', 1), (2, 'r2', 2), (3, 'r3', 3), (4, 'r4', 4)
INSERT Stations VALUES(1, 's1'), (2, 's2'), (3, 's3'), (4, 's4')

SELECT * FROM TrainTypes
SELECT * FROM Trains
SELECT * FROM Routes
SELECT * FROM Stations

EXEC uspUpdateRoute @rName = 'r1', @sName = 's1', @arrival = '7:00', @departure = '7:20'
EXEC uspUpdateRoute @rName = 'r1', @sName = 's2', @arrival = '7:40', @departure = '8:00'
EXEC uspUpdateRoute @rName = 'r1', @sName = 's3', @arrival = '8:10', @departure = '8:20'
EXEC uspUpdateRoute @rName = 'r1', @sName = 's4', @arrival = '9:00', @departure = '9:10'

EXEC uspUpdateRoute @rName = 'r2', @sName = 's1', @arrival = '10:00', @departure = '10:10'
EXEC uspUpdateRoute @rName = 'r2', @sName = 's2', @arrival = '10:40', @departure = '11:00'
EXEC uspUpdateRoute @rName = 'r2', @sName = 's3', @arrival = '11:10', @departure = '11:20'
EXEC uspUpdateRoute @rName = 'r2', @sName = 's4', @arrival = '12:00', @departure = '12:10'

EXEC uspUpdateRoute @rName = 'r3', @sName = 's1', @arrival = '11:00', @departure = '11:10'


SELECT * FROM RoutesStations
GO

--C
CREATE OR ALTER VIEW vRoutesWithAllStations
AS
	SELECT r.RName
	FROM Routes r
	WHERE NOT EXISTS
		(SELECT StationID
		FROM Stations
		EXCEPT
		SELECT StationID
		FROM RoutesStations
		WHERE RouteID = r.RouteID)


GO

SELECT *
FROM vRoutesWithAllStations

--D

SELECT * FROM RoutesStations
ORDER BY StationID

CREATE OR ALTER FUNCTION ufFilterStationsByNumberOfRoutes
	(@R int)
RETURNS TABLE 
RETURN SELECT S.SName
	FROM Stations S
	WHERE S.StationID IN
		(SELECT RS.StationID
		FROM RoutesStations RS
		GROUP BY RS.StationID
		HAVING COUNT(*) > @R)
GO

SELECT *
FROM ufFilterStationsByNumberOfRoutes(3)

SELECT *
FROM Trains

SELECT *
FROM Stations

SELECT *
FROM Routes


SELECT *
FROM Routes r
WHERE NOT EXISTS
	(SELECT StationID
	FROM Stations
	EXCEPT
	SELECT StationID
	FROM RoutesStations
	WHERE RouteID = r.RouteID)

SELECT *
FROM Routes r
WHERE r.RouteID = 
(SELECT TOP 1 rs.StationID
FROM RoutesStations rs
GROUP BY rs.StationID
ORDER BY COUNT(StationID) DESC)
		   


INSERT INTO RoutesStations(RouteID, StationID, Arrival, Departure) values(4, 3, '07:00:00', '07:25:00')
INSERT INTO RoutesStations(RouteID, StationID, Arrival, Departure) values(3, 3, '08:00:00', '09:25:00')
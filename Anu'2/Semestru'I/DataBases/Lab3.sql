USE EnglishTeamsDB

GO

-- Version0ToVersion1 -> modify the type of column [City Name] from table Cities from varchar(50) to varchar(40)
CREATE OR ALTER PROCEDURE V0TOV1
AS
BEGIN
ALTER TABLE Cities
ALTER COLUMN [City Name] varchar(40) NOT NULL
SELECT * 
FROM Cities
PRINT 'Version0ToVersion1: Modify the type of column [City Name] from varchar(50) to varchar(40)'
END


GO
-- Version1ToVersion0 -> modify the type of column [City Name] from table Cities from varchar(40) to varchar(50)
CREATE OR ALTER PROCEDURE V1TOV0
AS
BEGIN
ALTER TABLE Cities
ALTER COLUMN [City Name] varchar(50) NOT NULL
SELECT * 
FROM Cities
PRINT 'Version1ToVersion0: Modify the type of column [City Name] from varchar(40) to varchar(50)'
END

GO

-- Version1ToVersion2 -> add column City to the table Stadium
CREATE OR ALTER PROCEDURE V1TOV2
AS
BEGIN
ALTER TABLE Stadium
ADD City varchar(30)
SELECT *
FROM Stadium
PRINT 'Version1ToVersion2: Add column City to the table Stadium'
END

GO

-- Version2ToVersion1 -> remove the column City from the table Stadium
CREATE OR ALTER PROCEDURE V2TOV1
AS
BEGIN
ALTER TABLE Stadium
DROP COLUMN City
SELECT *
FROM Stadium
PRINT 'Version2ToVersion1: Remove column City from the table Stadium'
END

GO

-- Version2ToVersion3 -> add default constraint to Managers column Nationality
CREATE OR ALTER PROCEDURE V2TOV3
AS
BEGIN
ALTER TABLE Managers
ADD CONSTRAINT df_nat DEFAULT 'Empty' FOR Nationality
SELECT *
FROM Managers
PRINT 'Version2ToVersion3: Add default constraint for column Nationality from table Managers'
END

GO

-- Version3ToVersion2 -> remove default constraint from Managers column Nationality
CREATE OR ALTER PROCEDURE V3TOV2
AS
BEGIN
ALTER TABLE Managers
DROP CONSTRAINT df_nat
SELECT *
FROM Managers
PRINT 'Version3ToVersion2: Remove default constraint for column Nationality from table Managers'
END

GO

-- Version3ToVersion4 -> remove primary key from table Owners
CREATE OR ALTER PROCEDURE V3TOV4
AS
BEGIN
ALTER TABLE Owners
DROP CONSTRAINT pk_OwnerID
SELECT *
FROM Owners
PRINT 'Version3ToVersion4: Remove primary key from table Owners'
END

GO

-- Version4ToVersion3 -> add primary key for table Owners
CREATE OR ALTER PROCEDURE V4TOV3
AS
BEGIN
ALTER TABLE Owners
ADD CONSTRAINT pk_OwnerID PRIMARY KEY(OwnerID)
SELECT *
FROM Owners
PRINT 'Version4ToVersion3: Add primary key for table Owners'
END

GO

-- Version4ToVersion5 -> add candidate key for table Cities
CREATE OR ALTER PROCEDURE V4TOV5
AS
BEGIN
ALTER TABLE Cities
ADD CONSTRAINT uk_CityName UNIQUE([City Name])
SELECT *
FROM Cities
PRINT 'Version4ToVersion5: add candidate key for table Cities'
END

GO

-- Version5ToVersion4 -> remove candidate key from table Cities
CREATE OR ALTER PROCEDURE V5TOV4
AS
BEGIN
ALTER TABLE Cities
DROP CONSTRAINT uk_CityName
SELECT *
FROM Cities
PRINT 'Version5ToVersion4: remove candidate key from table Cities'
END

GO

-- Version5ToVersion6 -> add a new table having a foreign key
CREATE OR ALTER PROCEDURE V5TOV6
AS
BEGIN
CREATE TABLE KitManufacturers(
KitManufacturerID INT PRIMARY KEY IDENTITY,
[KitManufacturer Name] varchar(40),
TeamID INT CONSTRAINT fk_TeamID FOREIGN KEY(TeamID) REFERENCES Teams(TeamID))
SELECT *
FROM KitManufacturers
PRINT 'Version5ToVersion6: Add a new table KitManufacturers having a foreign key TeamID'
END


GO

-- Version6ToVersion5 -> drop the table created before
CREATE OR ALTER PROCEDURE V6TOV5
AS
BEGIN
ALTER TABLE KitManufacturers
DROP CONSTRAINT fk_TeamID
DROP TABLE KitManufacturers
PRINT 'Version6ToVersion5: Drop table KitManufacturers'
END

GO

-- Version6ToVersion7 -> create the table PlayersOfTheSeason
CREATE OR ALTER PROCEDURE V6TOV7
AS
BEGIN
CREATE TABLE PlayersOfTheSeason(
PlayerID INT PRIMARY KEY IDENTITY,
[Player Name] varchar(40),
Rating INT NOT NULL, 
TeamID INT CONSTRAINT fk_TeamIDPlayerOfTheSeason FOREIGN KEY(TeamID) REFERENCES Teams(TeamID)
)
SELECT *
FROM PlayersOfTheSeason
PRINT 'Version6ToVersion7: Create the table PlayersOfTheSeason'
END

GO

-- Version7ToVersion6 -> drop the table PlayersOfTheSeason
CREATE OR ALTER PROCEDURE V7TOV6
AS
BEGIN
ALTER TABLE PlayersOfTheSeason
DROP CONSTRAINT fk_TeamIDPlayerOfTheSeason
DROP TABLE PlayersOfTheSeason
PRINT 'Version7ToVersion6: Drop the table PlayersOfTheSeason'
END

GO

-- OneStepHigher -> update the current database to the next version and updating the result in the table Version
CREATE OR ALTER PROCEDURE OneStepHigher
@currV int
AS
BEGIN
	IF @currV=0
	BEGIN
		EXEC V0TOV1
	END

	IF @currV=1
	BEGIN
		EXEC V1TOV2
	END

	IF @currV=2
	BEGIN
		EXEC V2TOV3
	END

	IF @currV=3
	BEGIN
		EXEC V3TOV4
	END

	IF @currV=4
	BEGIN
		EXEC V4TOV5
	END

	IF @currV=5
	BEGIN
		EXEC V5TOV6
	END

	IF @currV=6
	BEGIN
		EXEC V6TOV7
	END

	UPDATE Version
	SET CurrentVS=CurrentVS+1
END

GO

-- OneStepLower -> update the current database to the previous version and updating the result in table Version
CREATE OR ALTER PROCEDURE OneStepLower
@currV int
AS
BEGIN
	IF @currV=1
	BEGIN
		EXEC V1TOV0
	END
	
	IF @currV=2
	BEGIN
		EXEC V2TOV1
	END

	IF @currV=3
	BEGIN
		EXEC V3TOV2
	END

	IF @currV=4
	BEGIN
		EXEC V4TOV3
	END

	IF @currV=5
	BEGIN
		EXEC V5TOV4
	END

	IF @currV=6
	BEGIN
		EXEC V6TOV5
	END

	IF @currV=7
	BEGIN
		EXEC V7TOV6
	END

	UPDATE Version
	SET CurrentVS=CurrentVS-1
END

GO

--main current, dest -> the main procedure, updates the database from the current version current to the version dest
CREATE OR ALTER PROCEDURE main
@current int,
@dest int
AS
BEGIN
	IF @dest<0 OR @dest>7
	BEGIN
		PRINT 'The given parameter is not valid'
	END
	ELSE
	BEGIN
		IF @dest=@current
		BEGIN
			PRINT 'The current version and the destinated version are the same'
		END
		ELSE
		BEGIN
			IF @dest > @current
			BEGIN
				WHILE @dest > @current
				BEGIN
					EXEC OneStepHigher @current
					SET @current=@current+1
				END
			END
			ELSE
			BEGIN
				WHILE @dest < @current
				BEGIN
					EXEC OneStepLower @current
					SET @current=@current-1
				END
			END
		END
	END
END

GO

--create a table Version which contains only the current version of the database
--CREATE TABLE Version(
--VID int primary key identity,
--CurrentVS int)

--initializing table Version with version 0
INSERT INTO Version VALUES (0)

SELECT * FROM Version

UPDATE Version
SET CurrentVS=0

EXEC main 0, 7
EXEC main 7, 0
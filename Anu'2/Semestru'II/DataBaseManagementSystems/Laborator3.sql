USE [EnglishTeamsDB]
GO


--chosen tables: Teams, Trophies and Honours

--validation functions
CREATE OR ALTER FUNCTION ValidateTrophyYear(@year INT) 
RETURNS INT 
AS
BEGIN
	DECLARE @valid INT
	SET @valid = 0

	DECLARE @current_year INT
	SET @current_year = (SELECT YEAR(CURRENT_TIMESTAMP))

	IF(@year < @current_year)
		SET @valid = 1
	RETURN @valid
END

GO

CREATE OR ALTER FUNCTION ValidateTeamYear(@year INT) 
RETURNS INT 
AS
BEGIN
	DECLARE @valid INT
	SET @valid = 0

	DECLARE @current_year INT
	SET @current_year = (SELECT YEAR(CURRENT_TIMESTAMP))

	IF(@year < @current_year)
		SET @valid = 1
	RETURN @valid
END

GO

CREATE OR ALTER FUNCTION ValidateCityID(@cityID INT)
RETURNS INT
AS
BEGIN
	DECLARE @valid INT
	SET @valid = 0

	IF((SELECT CityID FROM Cities WHERE CityID = @cityID) is not NULL)
		SET @valid = 1
	RETURN @valid
END

GO

CREATE OR ALTER FUNCTION ValidateNames(@name varchar(30))
RETURNS INT
AS
BEGIN
	DECLARE @valid INT
	SET @valid = 0

	IF(LEN(@name) > 2)
		SET @valid = 1
	RETURN @valid
END

GO

CREATE OR ALTER FUNCTION ValidateVarcharParameter(@param varchar(30))
RETURNS INT
AS
BEGIN
	DECLARE @valid INT
	SET @valid = 0

	IF(@param is not null)
		SET @valid = 1
	RETURN @valid
END

GO

--stored procedure for task 1

CREATE OR ALTER PROCEDURE AddHonour
@teamName VARCHAR(30),
@cityID INT,
@foundedTeam INT, 
@nickname VARCHAR(30),
@trophyName VARCHAR(30),
@foundedTrophy INT,
@numberOfTrophies INT
AS
BEGIN
	BEGIN TRANSACTION 
	BEGIN TRY
	IF (dbo.ValidateVarcharParameter(@teamName) <> 1)
	BEGIN
		RAISERROR('Team name must be a varchar', 14, 1);
	END
	ELSE
	BEGIN
		IF(dbo.ValidateNames(@teamName) <> 1)
		BEGIN
			RAISERROR('Team name must have at least 3 characters', 14, 1);
		END
	END
	IF (dbo.ValidateCityID(@cityID) <> 1)
	BEGIN
		RAISERROR('CityID must be a value in the table "Cities"', 14, 1)
	END
	IF (dbo.ValidateTeamYear(@foundedTeam) <> 1)
	BEGIN
		RAISERROR('Founding year of a team must be smaller than the current year', 14, 1);
	END
	IF (dbo.ValidateVarcharParameter(@nickname) <> 1)
	BEGIN
		RAISERROR('Nickname must be a varchar', 14, 1);
	END
	ELSE
	BEGIN
		IF(dbo.ValidateNames(@nickname) <> 1)
		BEGIN
			RAISERROR('Nickname must have at least 3 characters', 14, 1);
		END
	END
	IF (dbo.ValidateVarcharParameter(@trophyName) <> 1)
	BEGIN
		RAISERROR('Trophy name must be a varchar', 14, 1);
	END
	ELSE
	BEGIN
		IF(dbo.ValidateNames(@trophyName) <> 1)
		BEGIN
			RAISERROR('Trophy name must have at least 3 characters', 14, 1);
		END
	END
	IF (dbo.ValidateTrophyYear(@foundedTrophy) <> 1)
	BEGIN
		RAISERROR('Founding year of a trophy must be smaller than the current year', 14, 1);
	END

	INSERT INTO Teams VALUES(@teamName, @cityID, @foundedTeam, @nickname);
	DECLARE @teamID INT;
	SET @teamID = (SELECT IDENT_CURRENT('Teams'));

	INSERT INTO Trophies VALUES(@trophyName, @foundedTrophy);
	DECLARE @trophyID INT;
	SET @trophyID = (SELECT IDENT_CURRENT('Trophies'));

	INSERT INTO Honours VALUES(@trophyID, @teamID, @numberOfTrophies);

	COMMIT TRANSACTION
	SELECT 'Transaction commited'
	END TRY

	BEGIN CATCH
	ROLLBACK TRANSACTION
	SELECT 'Transaction rollbacked'
	END CATCH
END

EXEC AddHonour 'TestTeam2', 3, 1990, 'TestTeam2', 'TestTrophy2', 1999, 10
EXEC AddHonour 'TestTeam2', 4, 1990, 'TestTeam2', 'TestTrophy2', 2500, 10

SELECT * FROM Teams WHERE [Team Name] = 'TestTeam2';
SELECT * FROM Trophies WHERE [Trophy Name] = 'TestTrophy2';
SELECT * FROM Honours WHERE TeamID IN (SELECT TeamID FROM Teams WHERE [Team Name] = 'TestTeam2');

GO

CREATE OR ALTER PROCEDURE AddHonourDifferentTransactions
@teamName VARCHAR(30),
@cityID INT,
@foundedTeam INT, 
@nickname VARCHAR(30),
@trophyName VARCHAR(30),
@foundedTrophy INT,
@numberOfTrophies INT
AS
BEGIN
	BEGIN TRANSACTION 
	BEGIN TRY
	IF (dbo.ValidateVarcharParameter(@teamName) <> 1)
	BEGIN
		RAISERROR('Team name must be a varchar', 14, 1);
	END
	ELSE
	BEGIN
		IF(dbo.ValidateNames(@teamName) <> 1)
		BEGIN
			RAISERROR('Team name must have at least 3 characters', 14, 1);
		END
	END
	IF (dbo.ValidateCityID(@cityID) <> 1)
	BEGIN
		RAISERROR('CityID must be a value in the table "Cities"', 14, 1)
	END
	IF (dbo.ValidateTeamYear(@foundedTeam) <> 1)
	BEGIN
		RAISERROR('Founding year of a team must be smaller than the current year', 14, 1);
	END
	IF (dbo.ValidateVarcharParameter(@nickname) <> 1)
	BEGIN
		RAISERROR('Nickname must be a varchar', 14, 1);
	END
	ELSE
	BEGIN
		IF(dbo.ValidateNames(@nickname) <> 1)
		BEGIN
			RAISERROR('Nickname must have at least 3 characters', 14, 1);
		END
	END
	INSERT INTO Teams VALUES(@teamName, @cityID, @foundedTeam, @nickname);
	COMMIT TRANSACTION
	SELECT 'Transaction T1 commited'
	END TRY

	BEGIN CATCH
	ROLLBACK TRANSACTION
	SELECT 'Transaction T1 rollbacked'
	END CATCH

	BEGIN TRANSACTION
	BEGIN TRY
	IF (dbo.ValidateVarcharParameter(@trophyName) <> 1)
	BEGIN
		RAISERROR('Trophy name must be a varchar', 14, 1);
	END
	ELSE
	BEGIN
		IF(dbo.ValidateNames(@trophyName) <> 1)
		BEGIN
			RAISERROR('Trophy name must have at least 3 characters', 14, 1);
		END
	END
	IF (dbo.ValidateTrophyYear(@foundedTrophy) <> 1)
	BEGIN
		RAISERROR('Founding year of a trophy must be smaller than the current year', 14, 1);
	END
	INSERT INTO Trophies VALUES(@trophyName, @foundedTrophy);
	COMMIT TRANSACTION
	SELECT 'Transaction T2 commited'
	END TRY

	BEGIN CATCH
	ROLLBACK TRANSACTION
	SELECT 'Transaction T2 rollbacked'
	END CATCH

	BEGIN TRANSACTION
	BEGIN TRY
	DECLARE @teamID INT;
	--SET @teamID = (SELECT IDENT_CURRENT('Teams'));
	SET @teamID = (SELECT MAX(TeamID) FROM Teams WHERE [Team Name] = @teamName AND CityID = @cityID AND Founded = @foundedTeam AND Nickname = @nickname);

	DECLARE @trophyID INT;
	--SET @trophyID = (SELECT IDENT_CURRENT('Trophies'));
	SET @trophyID = (SELECT MAX(TrophyID) FROM Trophies WHERE [Trophy Name] = @trophyName AND Founded = @foundedTrophy);

	INSERT INTO Honours VALUES(@trophyID, @teamID, @numberOfTrophies);

	COMMIT TRANSACTION
	SELECT 'Transaction T3 commited'
	END TRY

	BEGIN CATCH
	ROLLBACK TRANSACTION
	SELECT 'Transaction T3 rollbacked'
	END CATCH
END

EXEC AddHonourDifferentTransactions 'TestTeam3', 3, 1990, 'TestTeam3', 'TestTrophy3', 1999, 10
EXEC AddHonourDifferentTransactions 'TestTeam3', 4, 1990, 'TestTeam3', 'TestTrophy3', 2022, 10

DELETE FROM Teams WHERE [Team Name]='TestTeam3'
DELETE FROM Trophies WHERE [Trophy Name]='TestTrophy3'
DELETE FROM Honours WHERE TrophyID > 17000

SELECT * FROM Teams WHERE [Team Name] = 'TestTeam3';
SELECT * FROM Trophies WHERE [Trophy Name] = 'TestTrophy3';
SELECT * FROM Honours WHERE TeamID IN (SELECT TeamID FROM Teams WHERE [Team Name] = 'TestTeam3');
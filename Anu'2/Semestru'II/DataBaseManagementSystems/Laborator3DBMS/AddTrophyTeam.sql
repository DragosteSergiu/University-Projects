USE [EnglishTeamsDB]

GO

CREATE OR ALTER PROCEDURE uspAddTrophyTeam
	@TrophyName varchar(30), 
	@FoundedTrophy int,
	@TeamName varchar(30),
	@CityID int,
	@FoundedTeam int,
	@Nickname varchar(30),
	@NumberOfTrophies int

AS
BEGIN
	DECLARE @isValid int = 0
	BEGIN TRANSACTION
		IF (LEN(@TrophyName) < 3)
		BEGIN
			SET @isValid = 1
		END
		IF (LEN(@TeamName) < 3)
		BEGIN
			SET @isValid = 1
		END
		IF (LEN(@Nickname) < 3)
		BEGIN
			SET @isValid = 1
		END
		IF (@CityID NOT IN (SELECT CityID FROM Cities))
		BEGIN
			SET @isValid = 1
		END
			INSERT INTO Trophies values (@TrophyName, @FoundedTrophy)
			PRINT('INSERT TROPHY COMPLETED')
			INSERT INTO Teams values(@TeamName, @CityID, @FoundedTeam, @Nickname)
			PRINT('INSERT TEAM COMPLETED')
			DECLARE @trophyID int
			SET @trophyID = (SELECT IDENT_CURRENT('Trophies'))
			DECLARE @teamID int
			SET @teamID = (SELECT IDENT_CURRENT('Teams'))
			INSERT INTO Honours values(@trophyID, @teamID, @NumberOfTrophies)
			PRINT('INSERT HONOUR COMPLETED')
			IF @@ERROR <> 0 or @isValid > 0
			BEGIN
				PRINT('TRANSACTION IS ROLLED BACK')
				ROLLBACK TRANSACTION
			END
			ELSE
			BEGIN
				COMMIT TRAN
				PRINT 'TRANSACTION COMPLETED'
			END
		RETURN  0
END

SELECT *
FROM Trophies

SELECT * 
FROM Teams

SELECT *
FROM Honours


EXEC uspAddTrophyTeam 'testtrophy', 1900, 'testteam', 1, 1900, 'testteam', 10



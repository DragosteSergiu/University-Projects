USE [EnglishTeamsDB]

GO

CREATE OR ALTER PROCEDURE uspAddTrophy
	@TrophyName varchar(30),
	@Founded int
AS
BEGIN
	DECLARE @isValid int = 0
	BEGIN TRANSACTION
		IF (LEN(@TrophyName) < 3)
		BEGIN
			SET @isValid = 1
		END
			INSERT INTO Trophies values(@TrophyName, @Founded)

			IF @@ERROR <> 0 or @isValid > 0
			BEGIN
				ROLLBACK TRANSACTION
			END
			ELSE
			BEGIN
				COMMIT TRAN
				PRINT 'Insert trophy complet'
			END
		RETURN  0
END

EXEC uspAddTrophy 50, 1970

SELECT *
FROM Trophies

DELETE FROM Trophies WHERE [Trophy Name] = '50'
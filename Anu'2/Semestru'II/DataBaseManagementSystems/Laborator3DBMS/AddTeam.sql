USE [EnglishTeamsDB]

GO

CREATE OR ALTER PROCEDURE uspAddTeam
	@TeamName varchar(30),
	@CityID int,
	@Founded int,
	@Nickname varchar(30)
AS
BEGIN
	DECLARE @isValid int = 0
	BEGIN TRANSACTION
		IF (LEN(@TeamName) < 3)
		BEGIN
			SET @isValid = 1
		END
			INSERT INTO Teams values(@TeamName, @CityID, @Founded, @Nickname)

			IF @@ERROR <> 0 or @isValid > 0
			BEGIN
				ROLLBACK TRANSACTION
			END
			ELSE
			BEGIN
				COMMIT TRAN
				PRINT 'Insert team complet'
			END
		RETURN  0
END

EXEC uspAddTeam 50, 1970

SELECT *
FROM Teams


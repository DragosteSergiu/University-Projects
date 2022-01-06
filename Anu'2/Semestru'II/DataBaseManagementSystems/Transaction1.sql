USE [EnglishTeamsDB]
--a)DIRTY READS
--PROBLEM:
BEGIN TRANSACTION
	UPDATE Teams
	SET Nickname = 'TestNick'
	WHERE [Team Name] = 'Chelsea'
	WAITFOR DELAY '00:00:10'
ROLLBACK TRANSACTION

--to restore the initial nickname for the team with name = 'Chelsea'
UPDATE Teams SET Nickname = 'The Blues' WHERE [Team Name] = 'Chelsea'

--SOLUTION:
BEGIN TRANSACTION
	UPDATE Teams
	SET Nickname = 'TestNick'
	WHERE [Team Name] = 'Chelsea'
	WAITFOR DELAY '00:00:10'
ROLLBACK TRANSACTION

SELECT * FROM Teams


--b)NON-REPEATABLE READS
--PROBLEM:
BEGIN TRANSACTION
	WAITFOR DELAY '00:00:10'
	UPDATE Teams
	SET Founded = 2000
	WHERE [Team Name] = 'Liverpool FC'
COMMIT TRANSACTION

--to restore the initial founding year for the team with name = 'Liverpool FC'
UPDATE Teams SET Founded = 1892 WHERE [Team Name] = 'Liverpool FC'

--SOLUTION:
BEGIN TRANSACTION
	WAITFOR DELAY '00:00:10'
	UPDATE Teams
	SET Founded = 2005
	WHERE [Team Name] = 'Liverpool FC'
COMMIT TRANSACTION

SELECT * FROM Teams


--c)PHANTOM READS
--PROBLEM:
BEGIN TRANSACTION
	WAITFOR DELAY '00:00:05'
	INSERT INTO Teams VALUES('PhantomTest', 9, 1990, 'phantomNickname');
COMMIT TRANSACTION

--to restore the initial table'
DELETE FROM Teams WHERE [Team Name] = 'PhantomTest'

--SOLUTION:
BEGIN TRANSACTION
	WAITFOR DELAY '00:00:05'
	INSERT INTO Teams VALUES('PhantomTest', 9, 1990, 'phantomNickname');
COMMIT TRANSACTION

SELECT * FROM Teams


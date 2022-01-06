if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

	ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

	ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRuns]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tests]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Views]

GO



CREATE TABLE [Tables] (

	[TableID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunTables] (

	[TestRunID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunViews] (

	[TestRunID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRuns] (

	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,

	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,

	[StartAt] [datetime] NULL ,

	[EndAt] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestTables] (

	[TestID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[NoOfRows] [int] NOT NULL ,

	[Position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestViews] (

	[TestID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Tests] (

	[TestID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Views] (

	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [Tables] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 

	(

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRuns] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Tests] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 

	(

		[TestID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Views] WITH NOCHECK ADD 

	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 

	(

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] ADD 

	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestRunViews] ADD 

	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestTables] ADD 

	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestViews] ADD 

	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	),

	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	)

GO

--- Views -------------------------------------------
USE [EnglishTeamsDB]
GO

CREATE OR ALTER VIEW firstView AS
SELECT *
FROM Trophies

GO

CREATE OR ALTER VIEW secondView AS
SELECT t.[Team Name], c.[City Name]
FROM Cities as c
INNER JOIN Teams as t
ON (t.CityID = c.CityID)

GO

CREATE OR ALTER VIEW thirdView AS
SELECT h.TrophyID, t.[Team Name], h.[Number Of Trophies]
FROM Honours as h
INNER JOIN Teams as t
ON (h.TeamID = t.TeamID)
GROUP BY h.TrophyID, t.[Team Name], h.[Number Of Trophies]


--- Inserts ---------------------------------------

GO

CREATE OR ALTER PROCEDURE insertTrophies @numberOfRows int
AS
BEGIN
	DECLARE @tableName varchar(30)
	SET @tableName = 'Trophies'
	DECLARE @contor int
	SET @contor = 1
	DECLARE @TrID int
	DECLARE @TrName varchar(30)
	DECLARE @Founded int

	WHILE @contor <= @numberOfRows
	BEGIN
		SET @TrID = @contor
		SET @TrName = 'Team Name' + CONVERT(varchar(7), @contor)
		SET @Founded = RAND()*(150) + 1860
		INSERT INTO Trophies([Trophy Name], Founded)
		values(@TrName, @Founded)
		set @contor = @contor + 1
	END

END

GO

CREATE OR ALTER PROCEDURE insertTeams @numberOfRows int
AS
BEGIN
	DECLARE @tableName varchar(30)
	SET @tableName = 'Teams'
	DECLARE @contor int
	SET @contor = 1
	DECLARE @TeamID int
	DECLARE @TeamName varchar(30)
	DECLARE @CityID int
	SET @CityID = (SELECT TOP 1 CAST (RAND()*MAX(CityID) + 1 AS INTEGER)FROM Cities)
	DECLARE @Founded int
	DECLARE @Nickname varchar(30)

	WHILE @contor <= @numberOfRows
	BEGIN
		SET @TeamName = 'Team Name' + CONVERT(varchar(7), @contor)
		SET @Founded = RAND()*(150) + 1860
		SET @Nickname = 'Nickname' + CONVERT(varchar(7), @contor)

		INSERT INTO Teams([Team Name], CityID, Founded, Nickname)
		values (@TeamName, @CityID, @Founded, @Nickname)
		SET @contor = @contor + 1
		SET @CityID = (SELECT TOP 1 CAST (RAND()*MAX(CityID) + 1 AS INTEGER)FROM Cities)
	END

END

GO

CREATE OR ALTER PROCEDURE insertHonours @numberOfRows int
AS
BEGIN
	DECLARE @tableName varchar(30)
	SET @tableName = 'Honours'
	DECLARE @contor int
	SET @contor = 1
	DECLARE @TrophyID varchar(30)
	DECLARE @TeamID varchar(30)
	DECLARE @NoOfTrophies int
	SET @TrophyID = (SELECT MIN(TrophyID) FROM Trophies)
	SET @TeamID = (SELECT TOP 1 CAST (RAND() * (99) + MAX(TeamID)-98 AS INTEGER)FROM Teams)

	WHILE @contor <= @numberOfRows
	BEGIN
		SET @NoOfTrophies = RAND()*(50)
		INSERT INTO Honours(TrophyID, TeamID, [Number Of Trophies])
		values (@TrophyID, @TeamID, @NoOfTrophies)
		SET @contor = @contor + 1
		SET @TrophyID = @TrophyID + 1
		SET @TeamID = (SELECT TOP 1 CAST (RAND() * (99) + MAX(TeamID)-98 AS INTEGER)FROM Teams)
	END

END

GO

--- Deletes----------------------

CREATE OR ALTER PROCEDURE deleteTrophies @numberOfRows int
AS
BEGIN

	DECLARE @tableName varchar(30)
	SET @tableName = 'Trophies'
	DECLARE @lastRow int
	SET @lastRow = (SELECT MAX(TrophyID) FROM Trophies) - @numberOfRows
	
	DELETE 
	FROM Trophies
	WHERE TrophyID > @lastRow

END

GO

CREATE OR ALTER PROCEDURE deleteTeams @numberOfRows int
AS
BEGIN
	DECLARE @tableName varchar(30)
	SET @tableName = 'Teams'
	DECLARE @lastRow int
	SET @lastRow = (SELECT MAX(TeamID) FROM Teams) - @numberOfRows

	DELETE
	FROM Teams
	WHERE TeamID > @lastRow

END

GO 

CREATE OR ALTER PROCEDURE deleteHonours @numberOfRows int
AS
BEGIN
	DECLARE @tableName varchar(30)
	SET @tableName = 'Honours'
	DECLARE @lastRow int
	SET @lastRow = (SELECT MAX(TrophyID) FROM Honours) - @numberOfRows 

	DELETE 
	FROM Honours
	WHERE TrophyID > @lastRow

END

GO

--- Select Views -------------------

CREATE OR ALTER PROCEDURE selectView @numberOfView int
AS
BEGIN
	IF @numberOfView = 1
	BEGIN
		SELECT *
		FROM firstView
	END
	IF @numberOfView = 2
	BEGIN
		SELECT *
		FROM secondView
	END
	IF @numberOfView = 3
	BEGIN
		SELECT * 
		FROM thirdView
	END

END

GO

--- Main procedure -----------------

CREATE OR ALTER PROCEDURE MainProcedure @option int
AS
BEGIN
	DECLARE @numberOfRows int
	IF @option = 1
		SET @numberOfRows = 100
	IF @option = 2
		SET @numberOfRows = 500
	IF @option = 3
		SET @numberOfRows = 1000

	DECLARE @allStart datetime
	SET @allStart = GETDATE()

	DECLARE @HonoursDeleteStart datetime
	SET @HonoursDeleteStart = GETDATE()
	EXEC deleteHonours @numberOfRows
	DECLARE @HonoursDeleteEnd datetime
	SET @HonoursDeleteEnd = GETDATE()

	DECLARE @TeamsDeleteStart datetime
	SET @TeamsDeleteStart = GETDATE()
	EXEC deleteTeams @numberOfRows
	DECLARE @TeamsDeleteEnd datetime
	SET @TeamsDeleteEnd = GETDATE()

	DECLARE @TrophiesDeleteStart datetime
	SET @TrophiesDeleteStart = GETDATE()
	EXEC deleteTrophies @numberOfRows
	DECLARE @TrophiesDeleteEnd datetime
	SET @TrophiesDeleteEnd = GETDATE()

	DECLARE @TrophiesInsertStart datetime
	SET @TrophiesInsertStart = GETDATE()
	EXEC insertTrophies @numberOfRows
	DECLARE @TrophiesInsertEnd datetime
	SET @TrophiesInsertEnd = GETDATE()

	DECLARE @TeamsInsertStart datetime
	SET @TeamsInsertStart = GETDATE()
	EXEC insertTeams @numberOfRows
	DECLARE @TeamsInsertEnd datetime
	SET @TeamsInsertEnd = GETDATE()

	DECLARE @HonoursInsertStart datetime
	SET @HonoursInsertStart = GETDATE()
	EXEC insertHonours @numberOfRows
	DECLARE @HonoursInsertEnd datetime
	SET @HonoursInsertEnd = GETDATE()

	DECLARE @firstViewStart datetime
	SET @firstViewStart = GETDATE()
	EXEC selectView 1
	DECLARE @firstViewEnd datetime
	SET @firstViewEnd = GETDATE()

	DECLARE @secondViewStart datetime
	SET @secondViewStart = GETDATE()
	EXEC selectView 2
	DECLARE @secondViewEnd datetime
	SET @secondViewEnd = GETDATE()

	DECLARE @thirdViewStart datetime
	SET @thirdViewStart = GETDATE()
	EXEC selectView 3
	DECLARE @thirdViewEnd datetime
	SET @thirdViewEnd = GETDATE()

	DECLARE @allStop datetime
	SET @allStop = GETDATE()

	DECLARE @description varchar(100)
	SET @description = (SELECT Name FROM Tests WHERE @option = TestID)

	INSERT INTO TestRuns(Description, StartAt, EndAt)
	values (@description, @allStart, @allStop)

	DECLARE @lastTestRunID int; 
	SET @lastTestRunID = (SELECT MAX(TestRunID) FROM TestRuns);

	INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)
	values (@lastTestRunID, 1, @HonoursDeleteStart, @HonoursInsertEnd)

	INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)
	values (@lastTestRunID, 2, @TrophiesDeleteStart, @TrophiesInsertEnd)

	INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)
	values (@lastTestRunID, 3, @TeamsDeleteStart, @TeamsInsertEnd)

	INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt)
	values (@lastTestRunID, 1, @firstViewStart, @firstViewEnd)

	INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt)
	values (@lastTestRunID, 2, @secondViewStart, @secondViewEnd)

	INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt)
	values (@lastTestRunID, 3, @thirdViewStart, @thirdViewEnd)

	SELECT *
	FROM TestRuns

	SELECT *
	FROM TestRunTables

	SELECT *
	FROM TestRunViews

END

---EXEC insertTrophies 100

---EXEC insertTeams 100

---EXEC insertHonours 100

---EXEC deleteTeams 1000

---EXEC deleteHonours 1000

---EXEC deleteTrophies 100

SELECT * FROM Trophies

SELECT * FROM Honours

SELECT * FROM Teams

EXEC MainProcedure 3
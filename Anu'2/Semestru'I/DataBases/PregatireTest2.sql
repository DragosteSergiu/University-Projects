use [IPracticalTest923]

CREATE TABLE Company(
	CompanyID int PRIMARY KEY IDENTITY,
	CompanyName varchar(30)
);

CREATE Table StageDirector(
	StageDirectorID int PRIMARY KEY IDENTITY,
	StageDirectorName varchar(30),
	NumberOfAwards int
)

CREATE TABLE Movie(
	MovieID int PRIMARY KEY,
	MovieName varchar(30),
	ReleaseDate date,
	CompanyID int FOREIGN KEY REFERENCES Company(CompanyID),
	StageDirectorID int FOREIGN KEY REFERENCES StageDirector(StageDirectorID)
);

CREATE TABLE Actor(
	ActorID int PRIMARY KEY,
	ActorName varchar(30), 
	Ranking int
);

CREATE TABLE CinemaProduction(
	Title varchar(30),
	MovieID int FOREIGN KEY REFERENCES Movie(MovieID),
	EntryMoment time,
	ActorID int FOREIGN KEY REFERENCES Actor(ActorID)
	PRIMARY KEY(ActorID, MovieID)
)


INSERT INTO Company(CompanyName) values ('digi')
INSERT INTO Company(CompanyName) values ('telekom')
INSERT INTO Company(CompanyName) values ('sport.ro')
INSERT INTO Company(CompanyName) values ('eurosport')

INSERT INTO StageDirector(StageDirectorName, NumberOfAwards) values ('Popescu', 5)
INSERT INTO StageDirector(StageDirectorName, NumberOfAwards) values ('Ionescu', 3)
INSERT INTO StageDirector(StageDirectorName, NumberOfAwards) values ('Georgescu', 7)
INSERT INTO StageDirector(StageDirectorName, NumberOfAwards) values ('Pop', 4)

INSERT INTO Movie(MovieID, MovieName, ReleaseDate, CompanyID, StageDirectorID) values (1, 'a', '20101010', 1, 1)
INSERT INTO Movie(MovieID, MovieName, ReleaseDate, CompanyID, StageDirectorID) values (2, 'b', '20121101', 1, 3)
INSERT INTO Movie(MovieID, MovieName, ReleaseDate, CompanyID, StageDirectorID) values (3, 'c', '20090119', 2, 4)
INSERT INTO Movie(MovieID, MovieName, ReleaseDate, CompanyID, StageDirectorID) values (4, 'd', '20201201', 4, 2)

INSERT INTO Actor(ActorID, ActorName, Ranking) values (1, 'Ion', 7)
INSERT INTO Actor(ActorID, ActorName, Ranking) values (2, 'Vasile', 8)
INSERT INTO Actor(ActorID, ActorName, Ranking) values (3, 'Gheorghe', 5)
INSERT INTO Actor(ActorID, ActorName, Ranking) values (4, 'Marcel', 9)

INSERT INTO CinemaProduction(Title, MovieID, EntryMoment, ActorID) values('a', 1, '12:00:10', 1)
INSERT INTO CinemaProduction(Title, MovieID, EntryMoment, ActorID) values('a', 1, '12:00:10', 3)
INSERT INTO CinemaProduction(Title, MovieID, EntryMoment, ActorID) values('b', 2, '02:20:13', 4)
INSERT INTO CinemaProduction(Title, MovieID, EntryMoment, ActorID) values('c', 3, '12:00:10', 1)

GO
CREATE OR ALTER PROCEDURE uspAddActor @name varchar(30), @entry time, @prod varchar(30)
AS
BEGIN
	IF @name NOT IN (SELECT a.ActorName From Actor as a INNER JOIN CinemaProduction as c ON (a.ActorID = c.ActorID) WHERE c.Title = @prod)
		INSERT INTO CinemaProduction(Title, MovieID, EntryMoment, ActorID) values (@prod, (SELECT MovieID FROM CinemaProduction WHERE Title = @prod), 
		@entry, (SELECT ActorID FROM Actor WHERE ActorName = @name))
END

EXEC uspAddActor 'Vasile', '12:00:12', 'c'

CREATE OR ALTER VIEW V1
AS
	SELECT a.ActorName
	FROM Actor as a
	WHERE NOT EXISTS
	(SELECT Title
	FROM CinemaProduction
	EXCEPT 
	SELECT Title
	FROM CinemaProduction
	WHERE ActorID = a.ActorID)
GO

INSERT INTO CinemaProduction(Title, MovieID, EntryMoment, ActorID) values('b', 2, '02:25:19', 1)

SELECT *
FROM V1

CREATE OR ALTER FUNCTION ufListAllFunctions (@p int)
RETURNS TABLE
RETURN SELECT m.MovieName
	   FROM Movie as m
	   WHERE m.MovieID IN
	   (SELECT c.MovieID
	   FROM CinemaProduction as c
	   GROUP BY c.MovieID
	   HAVING COUNT(c.Title) > @p)
GO

SELECT *
FROM CinemaProduction

SELECT *
FROM ufListAllFunctions(1)
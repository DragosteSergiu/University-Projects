use [EnglishTeamsDB]
CREATE TABLE Cities(
	CityID int IDENTITY(1,1) PRIMARY KEY,
	[City Name] varchar(50),
	[City Population] int,
);

CREATE TABLE Teams(
	TeamID int IDENTITY(1,1) PRIMARY KEY,
	[Team Name] varchar(50),
	CityID int,
	Founded int,
	Nickname varchar(50),
	FOREIGN KEY (CityID) REFERENCES Cities([CityID])
);


CREATE TABLE Stadium(
	StadiumID int IDENTITY(1,1) PRIMARY KEY,
	[Stadium Name] varchar(50),
	TeamID int,
	Capacity int,
	FOREIGN KEY(TeamID) REFERENCES Teams([TeamID])
);

CREATE TABLE Trophies(
	TrophyID int IDENTITY(1,1) PRIMARY KEY,
	[Trophy Name] varchar(50),
	Founded int
);

CREATE TABLE Honours(
	TrophyID int,
	TeamID int,
	[Number Of Trophies] int,
	FOREIGN KEY (TrophyID) REFERENCES Trophies(TrophyID),
	FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
	PRIMARY KEY(TrophyID, TeamID)
);

CREATE TABLE Managers(
	ManagerID int IDENTITY(1,1) PRIMARY KEY,
	[Manager Name] varchar(50),
	TeamID int,
	FOREIGN KEY(TeamID) REFERENCES Teams(TeamID),
	[Weekly Wage] money
);

CREATE TABLE Players(
	PlayerID int IDENTITY(1,1) PRIMARY KEY,
	[Player Name] varchar(50),
	TeamID int,
	FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
	[Playing Position] varchar(15)
);

CREATE TABLE Owners(
	OwnerID int CONSTRAINT pk_OwnerID PRIMARY KEY(OwnerID),
	[Owner Name] varchar(50),
	TeamID int,
	FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
	Nationality varchar(20)
);

CREATE TABLE Sponsors(
	SponsorID int IDENTITY(1,1) PRIMARY KEY,
	[Sponsor Name] varchar(50),
	TeamID int,
	FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
	[Value Of Sponsorship] money
);

CREATE TABLE AllTimeGoalscorers(
	GoalscorerID int IDENTITY(1,1) PRIMARY KEY,
	[Goalscorer Name] varchar(50),
	TeamID int,
	FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
	[Number of goals] int
);
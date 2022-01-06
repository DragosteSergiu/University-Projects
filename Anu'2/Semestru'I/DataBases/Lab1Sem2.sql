USE [Laborator1]


SELECT *
FROM Cities

CREATE TABLE Cities(
	CityID int IDENTITY(1,1) PRIMARY KEY,
	CityName varchar(50),
	CityPopulation int,
);

CREATE TABLE Teams(
	TeamID int IDENTITY(1,1) PRIMARY KEY,
	TeamName varchar(50),
	CityID int,
	Founded int,
	Nickname varchar(50),
	FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('London', 8961989);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Manchester', 552858);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Liverpool', 498042);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Birmingham', 1141816);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Sheffield', 584853);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Wolverhampton', 254406);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Newcastle upon Tyne', 	302820);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Stoke-on-Trent', 	256375);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Bristol', 463400);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Portsmouth', 238800);
INSERT INTO [dbo].[Cities] (CityName, CityPopulation)
values ('Nottingham', 321500);

INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Arsenal', 1, 1886, 'The Gunners');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Chelsea', 1, 1905, 'The Blues');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('West Hame United', 1, 1895, 'The Irons');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Everton', 3, 1878, 'The Toffees');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Sheffield Wednesday', 5, 1867, 'The Owls');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Aston Villa', 4, 1874, 'The Villa');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Liverpool FC', 3, 1892, 'The Reds');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Manchester United', 2, 1878, 'The Red Devils');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Manchester City', 2, 1880, 'The Citizens');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('West Bromwich Albion', 4, 1878, 'The Baggies')
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Sheffield United', 5, 1889, 'The Blades');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Birmingham City', 4, 1875, 'The Blues');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Wolverhampton Wanderers', 6, 1877, 'The Wolves');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Newcastle United', 7, 1892, 'The Magpies');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Stoke City', 8, 1863, 'The Potters');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Bristol City', 9, 1894, 'The Robins');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Portsmouth FC', 10, 1898, 'Pompey');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Nottingham Forest', 11, 1865, 'Forest')
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Notts County', 11, 1862, 'The Magpies');
INSERT INTO  [dbo].[Teams] ([TeamName], CityID, Founded, Nickname)
values ('Tottenham Hotspurs', 1, 1882, 'Spurs');
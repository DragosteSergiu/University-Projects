use [EnglishTeamsDB]

INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('London', 8961989);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Manchester', 552858);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Liverpool', 498042);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Birmingham', 1141816);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Sheffield', 584853);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Wolverhampton', 254406);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Newcastle upon Tyne', 	302820);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Stoke-on-Trent', 	256375);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Bristol', 463400);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Portsmouth', 238800);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Nottingham', 321500);

use [EnglishTeamsDB]
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Arsenal', 1, 1886, 'The Gunners');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Chelsea', 1, 1905, 'The Blues');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('West Hame United', 1, 1895, 'The Irons');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Everton', 3, 1878, 'The Toffees');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Sheffield Wednesday', 5, 1867, 'The Owls');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Aston Villa', 4, 1874, 'The Villa');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Liverpool FC', 3, 1892, 'The Reds');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Manchester United', 2, 1878, 'The Red Devils');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Manchester City', 2, 1880, 'The Citizens');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('West Bromwich Albion', 4, 1878, 'The Baggies')
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Sheffield United', 5, 1889, 'The Blades');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Birmingham City', 4, 1875, 'The Blues');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Wolverhampton Wanderers', 6, 1877, 'The Wolves');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Newcastle United', 7, 1892, 'The Magpies');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Stoke City', 8, 1863, 'The Potters');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Bristol City', 9, 1894, 'The Robins');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Portsmouth FC', 10, 1898, 'Pompey');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Nottingham Forest', 11, 1865, 'Forest')
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Notts County', 11, 1862, 'The Magpies');
INSERT INTO  [dbo].[Teams] ([Team Name], CityID, Founded, Nickname)
values ('Tottenham Hotspurs', 1, 1882, 'Spurs');

SELECT *
FROM [dbo].[Teams]

INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('Goodison Park', 4, 39572);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('Villa Park', 6, 42749);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('Stamford Bridge', 2, 40834);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('Anfield Road', 7, 53394);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('Emirates Stadium', 1, 60704);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('London Stadium', 3, 60000);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Hillsborough', 5, 34854);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Old Trafford', 8, 75000);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Emirates Stadium', 9, 54000);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('The Hawthorns', 10, 26688);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Bramall Lane', 11, 32702);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('St.Andrew', 12, 29409);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Molineux', 13, 32050);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('St James Park', 14, 520305);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('bet365 Stadium', 15, 30089);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Ashton Gate', 16, 27000);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Fratton Park', 17, 20620);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('City Ground', 18, 30446);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Meadow Lane', 19, 19841);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values('Tottenham Stadium', 20, 62303);

ALTER TABLE Managers
ADD Nationality varchar(30)

ALTER TABLE Players
ADD Nationality varchar(30)

ALTER TABLE AllTimeGoalscorers
ADD Nationality varchar(30)

INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Jurgen Klopp', 7, 192000, 'German');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('David Moyes', 3, 15000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Mikel Arteta', 1, 140000, 'Spanish');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Carlo Ancelotti', 4, 230000, 'Italian');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values  ('Dean Smith', 6, 20000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Garry Monk', 5, 10000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Frank Lampard', 2, 77000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Gunnar Solskjaer', 8, 70000, 'Norwegian');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Josep Guardiola', 9, 200000, 'Spanish');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Slaven Bilic', 10, 40000, 'Croatian');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Chris Wilder', 11, 35000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Aitor Karanka', 12, 20000, 'Spanish');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Espirito Santo', 13, 48000, 'Portuguese');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Steve Bruce', 14, 34000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Michel ''O''Neal', 15, 22000, 'Northern Irish');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Dean Holden', 16, 18000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Kenny Jackett', 17, 13000, 'Welsh');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Chris Hughton', 18, 24000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Neal Ardley', 19, 5000, 'English');
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage], Nationality)
values ('Jose Mourinho', 20, 200000, 'Portuguese');


use [EnglishTeamsDB]
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Sergio Aguero', 9, 'Striker', 'Argentinian');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Harry Kane', 20, 'Striker', 'English');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Harry Maguire', 8, 'Center Back', 'English');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Andy Robertson', 7, 'Full Back', 'Scottish');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Kevin de Bruyne', 9, 'Off Midfielder', 'Belgian');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('James Rodriguez', 4, 'Off Midfielder', 'Columbian');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Kepa Arizabalaga', 2, 'Goalkeeper', 'Spanish');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Jesse Lingard', 8, 'Striker', 'English');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Raul Gimenez', 13, 'Striker', 'Mexican');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Jack Grealish', 6, 'Midfielder', 'English');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Willian', 1, 'Winger', 'Brazilian');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Branislav Ivanovic', 10, 'Center Back', 'Serbian');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Oliver Burke', 11, 'Winger', 'Scottish');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Allan Saint-Maximin', 14, 'Winger', 'French');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('John Obi Mikel', 15, 'Def Midfielder', 'Nigerian');
INSERT INTO [dbo].[Players]([Player Name], TeamID, [Playing Position], Nationality)
values ('Scott Hogan', 12, 'Striker', 'Irish');


--- update and delete from tables

UPDATE [dbo].[Managers]
SET [Weekly Wage] = 23000
WHERE [Manager Name] LIKE 'Dean Smith'

UPDATE [dbo].[Managers]
SET [Weekly Wage] = 8000
WHERE [Manager Name] = 'Garry Monk'OR [Weekly Wage] <= 7000

UPDATE [dbo].[Stadium]
SET Capacity = 39732
WHERE [Stadium Name] = 'Hillsborough' AND [StadiumID] = 5

UPDATE [dbo].[Stadium]
SET Capacity = 52500
WHERE [Stadium Name] = 'St James Park'


DELETE 
FROM [dbo].[Stadium]
WHERE Capacity < 25000 OR [Stadium Name] = 'Goodison Park'


DELETE
FROM [dbo].[Managers]
WHERE [Weekly Wage] BETWEEN 5000 AND 15000

ALTER TABLE [dbo].[Stadium]
ADD CONSTRAINT FK_CityID 
FOREIGN KEY (CityID) REFERENCES [dbo].[Cities](CityID);


--- a.

--- We want to list all the english players and managers

SELECT m.[Manager Name] as 'Manager or Player'
FROM Managers as m
WHERE m.Nationality LIKE 'English'
UNION ALL
SELECT p.[Player Name]
FROM Players as p
WHERE p.Nationality = 'English'

--- We want to list all the teams that are from big cities or have large stadiums

SELECT DISTINCT t.[Team Name]
FROM Cities as c, Stadium as s, Teams as t
WHERE (c.[City Population] > 700000 and c.[CityID] = t.CityID) or (s.Capacity > 35000 and t.TeamID = s.TeamID)


---b.

--- We want to list all that are from big cities and have big stadiums

SELECT DISTINCT t.[Team Name]
FROM Cities as c, Teams as t
WHERE (c.[City Population] > 500000) and (c.CityID = t.CityID)
INTERSECT
SELECT DISTINCT t.[Team Name]
FROM Stadium as s, Teams as t
WHERE (s.Capacity > 50000) and (s.TeamID = t.TeamID)

--- We want to list all teams that are from Liverpool and Manchester

SELECT t.[Team Name]
FROM Teams as t, Cities as c
WHERE (t.CityID = c.CityID) and (c.[City Name] in ('Liverpool', 'Manchester'))

---c.

--- We want to list all the big stadiums that aren't from London

SELECT TOP 10 s.[Stadium Name], s.Capacity
FROM Stadium as s
WHERE (s.Capacity > 35000)
EXCEPT
SELECT DISTINCT s.[Stadium Name], s.Capacity
FROM Stadium as s, Cities as c, Teams as t
WHERE (s.TeamID = t.TeamID) and (t.CityID = c.CityID) and (c.[City Name] LIKE 'London')
ORDER BY s.Capacity

--- We want to list all players and managers who are not from Great Britain

SELECT p.[Player Name] as 'Players and Managers'
FROM Players as p
WHERE (p.Nationality NOT IN ('English', 'Scottish', 'Northern Irish', 'Welsh'))
UNION ALL
SELECT m.[Manager Name]
FROM Managers as m
WHERE (m.Nationality NOT IN ('English', 'Scottish', 'Northern Irish', 'Welsh'))

---d.

--- We want to list all players who play in Manchester

SELECT p.[Player Name], t.[Team Name]
FROM Players as p
INNER JOIN Teams as t
ON (p.TeamID = t.TeamID) 
INNER JOIN Cities as c
ON (t.CityID = c.CityID)
WHERE (c.[City Name] = 'Manchester')

--- We want to display the manager of Arsenal

SELECT m.[Manager Name]
FROM Managers as m
LEFT JOIN Teams as t
ON (m.TeamID = t.TeamID)
WHERE (t.[Team Name] LIKE 'Arsenal')

--- We want to list all the teams from Birmingham

SELECT t.[Team Name]
FROM Cities as c
RIGHT JOIN Teams as t
ON (c.CityID = t.CityID)
WHERE (c.[City Name] LIKE 'Birmingham')

--- We want to list all the stadiums and teams from Sheffield

SELECT s.[Stadium Name], t.[Team Name]
FROM Stadium as s, Teams as t
FULL JOIN Cities as c
ON (t.CityID = c.CityID)
WHERE (c.[City Name] LIKE 'Sheffield') and (t.TeamID = s.TeamID)

---e.

--- We want to list list all the teams that are from small cities

SELECT t.[Team Name], t.CityID
FROM Teams as t
WHERE t.CityID IN (SELECT c.CityID
FROM Cities as c
WHERE c.[City Population] < 400000)

--- We want to list all stadiums from Nottingham

SELECT s.[Stadium Name], s.Capacity
FROM Stadium as s
WHERE s.TeamID IN (SELECT t.TeamID
FROM Teams as t
INNER JOIN Cities as c
ON (t.CityID = c.CityID)
WHERE (c.[City Name] LIKE 'Nottingham'))

---f.

--- We want to list all players who are from Tottenham Hotspurs

SELECT p.[Player Name]
FROM Players as p
WHERE EXISTS (SELECT t.TeamID
FROM Teams as t
WHERE (t.[Team Name] LIKE 'Tottenham Hotspurs') and (p.TeamID = t.TeamID))

--- We want to display the manager of Newcastle United

SELECT m.[Manager Name]
FROM Managers as m
WHERE EXISTS (
SELECT t.TeamID
FROM Teams as t
WHERE (t.TeamID = m.TeamID) and (t.[Team Name] LIKE 'Newcastle United'))

---g.

--- We want to list all the Top 3 managers sorted by wage

SELECT TOP 3 managers.[Manager Name], managers.[Weekly Wage]
FROM (SELECT * 
FROM Managers as m
WHERE m.[Weekly Wage] >= 100000) as managers
ORDER BY managers.[Weekly Wage] DESC

--- We want to list all managers who are from Spain or Portugal

SELECT managers.[Manager Name], managers.Nationality
FROM (SELECT * 
FROM Managers as m
WHERE m.Nationality LIKE 'Spanish') as managers 
UNION ALL
SELECT managers.[Manager Name], managers.Nationality
FROM (SELECT * 
FROM Managers as m
WHERE m.Nationality LIKE 'Portuguese') as managers 

---h.

--- We want to count how many managers are from each country

SELECT COUNT (m.[Manager Name]), m.Nationality
FROM Managers as m
GROUP BY m.Nationality

--- We want to see how many strikers are in the official list of players

SELECT COUNT (p.[Player Name]) as 'Number', p.[Playing Position]
FROM Players as p
GROUP BY p.[Playing Position]
HAVING (p.[Playing Position] = 'Striker')

--- We want to count how many teams has each city

SELECT COUNT (t.[Team Name]) as 'Number of teams', t.CityID
FROM Teams as t
GROUP BY t.CityID
HAVING t.CityID = (SELECT c.CityID
FROM Cities as c
WHERE t.CityID = c.CityID)

--- We want to list the wage for the managers from London

SELECT AVG (m.[Weekly Wage]) as 'Wage'
FROM Managers as m
GROUP BY m.TeamID
HAVING m.TeamID = (SELECT t.TeamID
FROM Teams as t
WHERE t.CityID = 1 and t.TeamID = m.TeamID)

---i.

--- We want to list all the stadiums from Birmingham

SELECT s.[Stadium Name], s.Capacity
FROM Stadium as s
WHERE s.TeamID = ANY (SELECT t.TeamID
FROM Teams as t
INNER JOIN Cities as c
ON t.CityID = c.CityID
WHERE c.[City Name] = 'Birmingham')
ORDER BY s.Capacity DESC

SELECT s.[Stadium Name], s.Capacity
FROM Stadium as s
WHERE s.TeamID in (SELECT t.TeamID
FROM Teams as t
INNER JOIN Cities as c
ON t.CityID = c.CityID
WHERE c.[City Name] LIKE 'Birmingham')
ORDER BY s.Capacity DESC

--- We want to list all the players from London teams

SELECT *
FROM Players as p
WHERE p.TeamID = ANY (SELECT t.TeamID
FROM Teams as t
INNER JOIN Cities as c
ON (t.CityID = c.CityID)
WHERE c.[City Name] LIKE 'London')

--- We want to list all players from Liverpool FC

SELECT *
FROM Players as p
WHERE p.TeamID = ALL (SELECT t.TeamID
FROM Teams as t
WHERE t.[Team Name] LIKE 'Liverpool FC')

SELECT *
FROM Players as p
WHERE P.TeamID IN (SELECT t.TeamID 
FROM Teams as t
WHERE t.[Team Name] = 'Liverpool FC')

--- We want to list all teams from Wolverhampton

SELECT *
FROM Teams as t
WHERE t.CityID = ALL(SELECT c.CityID
FROM Cities as c
WHERE c.[City Name] = 'Wolverhampton')
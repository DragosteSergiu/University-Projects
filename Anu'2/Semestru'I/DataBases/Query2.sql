INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('London', 8961989);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Manchester', 552858);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Liverpool', 498042);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Birmingham', 1141816);
INSERT INTO [dbo].[Cities] ([City Name], [City Population])
values ('Sheffield', 584,853);


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

INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('Goodison Park', 4, 39572);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('Villa Park', 6, 42749);
INSERT INTO [dbo].[Stadium] ([Stadium Name], [TeamID], Capacity)
values ('Stamford Bridge', 2, 40834);

INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage])
values ('Jurgen Klopp', 7, 192000);
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage])
values ('David Moyes', 3, 15000);
INSERT INTO [dbo].[Managers] ([Manager Name], TeamID, [Weekly Wage])
values ('Mikel Arteta', 1, 140000);


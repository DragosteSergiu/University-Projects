use [IPracticalTest923]

CREATE TABLE PresentationShops(
	PresentationShopID int PRIMARY KEY IDENTITY,
	PresentationShopName varchar(30),
	City varchar(30)
);

CREATE TABLE Woman(
	WomanID int PRIMARY KEY IDENTITY,
	Name varchar(30),
	Money money
);

CREATE TABLE ShoeModel(
	ShoeModelID int PRIMARY KEY IDENTITY,
	ShoeModelName varchar(30),
	Season varchar(30)
);

CREATE TABLE Shoe(
	ShoeID int PRIMARY KEY IDENTITY,
	ShoeModelID int FOREIGN KEY REFERENCES ShoeModel(ShoeModelID),
	Price money
);

CREATE TABLE Stocks(
	ShoeID int FOREIGN KEY REFERENCES Shoe(ShoeID),
	PresentationShopID int FOREIGN KEY REFERENCES PresentationShops(PresentationShopID),
	AvailableShoes int,
	PRIMARY KEY(ShoeID, PresentationShopID)
);

CREATE TABLE Purchase(
	WomanID int FOREIGN KEY REFERENCES Woman(WomanID),
	ShoeID int FOREIGN KEY REFERENCES Shoe(ShoeID),
	Price money, 
	numberOfShoes int
	PRIMARY KEY(WomanID, ShoeID)
);


INSERT INTO PresentationShops(PresentationShopName, City) values ('C&A', 'Cluj')
INSERT INTO PresentationShops(PresentationShopName, City) values ('H&M', 'Cluj')
INSERT INTO PresentationShops(PresentationShopName, City) values ('Deichman', 'Cluj')
INSERT INTO PresentationShops(PresentationShopName, City) values ('New Yorker', 'Bucuresti')

INSERT INTO Woman(Name, Money) values ('Ana', 600)
INSERT INTO Woman(Name, Money) values ('Maria', 400)
INSERT INTO Woman(Name, Money) values ('Viorela', 700)
INSERT INTO Woman(Name, Money) values ('Gianina', 300)

INSERT INTO ShoeModel(ShoeModelName, Season) values ('Nike', 'Winter')
INSERT INTO ShoeModel(ShoeModelName, Season) values ('Adidas', 'Summer')
INSERT INTO ShoeModel(ShoeModelName, Season) values ('Puma', 'Winter')
INSERT INTO ShoeModel(ShoeModelName, Season) values ('Victory', 'AllSeason')
INSERT INTO ShoeModel(ShoeModelName, Season) values ('Memphis', 'Winter')

INSERT INTO Shoe(ShoeModelID, Price, SName) values (1, 50, 'Mercurial')
INSERT INTO Shoe(ShoeModelID, Price, SName) values (2, 75, 'b')
INSERT INTO Shoe(ShoeModelID, Price, SName) values (1, 80, 'c')

INSERT INTO Stocks(ShoeID, PresentationShopID, AvailableShoes) values (1, 2, 10)
INSERT INTO Stocks(ShoeID, PresentationShopID, AvailableShoes) values (2, 1, 5)
INSERT INTO Stocks(ShoeID, PresentationShopID, AvailableShoes) values (2, 3, 6)
INSERT INTO Stocks(ShoeID, PresentationShopID, AvailableShoes) values (3, 4, 12)

INSERT INTO Purchase(WomanID, ShoeID, Price, numberOfShoes) values (1, 5, 50, 1)
INSERT INTO Purchase(WomanID, ShoeID, Price, numberOfShoes) values (2, 2, 75, 1)
INSERT INTO Purchase(WomanID, ShoeID, Price, numberOfShoes) values (4, 5, 50, 1)
INSERT INTO Purchase(WomanID, ShoeID, Price, numberOfShoes) values (3, 3, 50, 1)
INSERT INTO Purchase(WomanID, ShoeID, Price, numberOfShoes) values (1, 3, 60, 1)

SELECT *
FROM Shoe

GO
CREATE OR ALTER PROCEDURE uspAddShoe @shoeID int, @presentationShopID int, @numberOfShoes int
AS
BEGIN
	IF @shoeID IN (SELECT ShoeID FROM Shoe)
	BEGIN
		INSERT INTO Stocks(ShoeID, PresentationShopID, AvailableShoes) values (@shoeID, @presentationShopID, @numberOfShoes)
	END
END

EXEC uspAddShoe 3, 1, 15

CREATE OR ALTER VIEW V1
AS
	SELECT w.WomanID
	FROM Woman as w
	WHERE EXISTS
	(SELECT  p.ShoeID
	FROM Purchase as p
	WHERE w.WomanID = p.WomanID)
GO

SELECT *
FROM V1

CREATE OR ALTER FUNCTION ufFilter (@T int)
RETURNS TABLE
RETURN SELECT s.ShoeID
	   FROM Shoe as s
	   WHERE s.ShoeID IN
	   (SELECT st.ShoeID
	   FROM Stocks as st
	   GROUP BY st.ShoeID
	   HAVING COUNT(*) > @T)
GO

SELECT *
FROM Shoe

SELECT *
FROM ufFilter(1)
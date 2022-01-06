USE [EnglishTeamsDB]
GO

CREATE TABLE Ta(
	aid int PRIMARY KEY,
	a2 int UNIQUE,
	aName varchar(20)
)

CREATE TABLE Tb(
	bid int PRIMARY KEY,
	b2 int,
	bName varchar(20)
)

CREATE TABLE Tc(
	cid int PRIMARY KEY,
	aid int FOREIGN KEY REFERENCES Ta(aid),
	bid int FOREIGN KEY REFERENCES Tb(bid),
	cName varchar(20)
)

INSERT INTO Ta values(2, 2, 'a2'), (3, 3, 'a3'), (4, 4, 'a4'), (5, 5, 'a5')
INSERT INTO Tb values(1, 1, 'b1'), (2, 1, 'b2'), (3, 1, 'b1'), (4, 4, 'b4'), (5, 2, 'b5')
INSERT INTO Tc values(1, 1, 1, 'c1'), (2, 1 , 2, 'c2'), (3, 2, 4, 'c3'), (4, 2, 3, 'c4'), (5, 3, 1, 'c5'), (6, 4, 5, 'c6'), (7, 4, 3, 'c7')

--a. Write queries on Ta such that their execution plans contain the following operators:

--clustered index scan
SELECT *
FROM Ta

--clustered index seek
SELECT *
FROM Ta 
WHERE aid = 1

--nonclustered index scan + key lookup
SELECT *
FROM Ta
ORDER BY a2

--nonclustered index seek
SELECT a2
FROM Ta
WHERE a2 > 2

--b. Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan. 
--Create a nonclustered index that can speed up the query. Examine the execution plan again.

SELECT *
FROM Tb
WHERE b2 = 2
--estimated subtree cost 0.0032875

IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_Tb_b2')
	DROP INDEX N_idx_Tb_b2 ON Tb
CREATE NONCLUSTERED INDEX N_idx_Tb_b2 ON Tb(b2)

SELECT b2
FROM Tb
WHERE b2 = 2
--estimated subtree cost 0.0032831

--c. Create a view that joins at least 2 tables. Check whether existing indexes are helpful; 
--if not, reassess existing indexes / examine the cardinality of the tables.

CREATE VIEW Lab5View
AS
SELECT a.aName, b.bName, c.cName
FROM Ta a
INNER JOIN Tc c
ON (a.aid = c.aid)
INNER JOIN Tb b
ON (c.bid = b.bid)
WHERE c.cid > 2
GO

SELECT * FROM Lab5View

IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_Tc_aid')
	DROP INDEX N_idx_Tc_aid ON Tc
IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_Tc_bid')
	DROP INDEX N_idx_Tc_bid ON Tc
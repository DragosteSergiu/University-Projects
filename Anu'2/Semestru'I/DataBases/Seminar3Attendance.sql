USE [AdventureWorks2017]

SELECT *
FROM [AdventureWorks2017].[Person].[Address]


CREATE OR ALTER PROCEDURE uspCountAllAddressInACity @City varchar(30), @count int OUTPUT
as
SELECT @count = COUNT( AddressID )
FROM [AdventureWorks2017].[Person].[Address] as p
WHERE p.City = @City
GO

DECLARE @rCount INT
SET @rCount = 0
EXEC uspCountAllAddressInACity @City = 'London', @count = @rCount OUTPUT
print(@rCount)

SELECT *
FROM [AdventureWorks2017].Person.Person

CREATE OR ALTER PROCEDURE uspGetAllPersonsWithMiddleName @middleName varchar(30)
as
SELECT CONCAT (p.FirstName, ' ', p.LastName, ' ', p.MiddleName) as [Full Name]
FROM [AdventureWorks2017].Person.Person as p
WHERE p.MiddleName = @middleName
GO

EXEC uspGetAllPersonsWithMiddleName 'J'

CREATE OR ALTER PROCEDURE  uspGetAllPersonsWithLastName @lName varchar(30)
as
BEGIN
	DECLARE @SQL varchar(100)
	SET @SQL = 'SELECT p.LastName FROM [AdventureWorks2017].Person.Person as p WHERE p.LastName = @lName'
	EXEC sp_executesql @SQL, N'@lastname VARCHAR(30)', @lastName = @lName
END
GO

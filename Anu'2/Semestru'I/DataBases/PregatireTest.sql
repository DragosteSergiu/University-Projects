use [IPracticalTest923]

CREATE TABLE Customer(
	CustomerID int PRIMARY KEY IDENTITY,
	CustomerName varchar(30),
	dateOfBirth date
);

CREATE TABLE BankAccount(
	IBAN varchar(30) PRIMARY KEY,
	currentBalance money,
	holder int FOREIGN KEY REFERENCES Customer(CustomerID)
);

CREATE TABLE Card(
	CardID int PRIMARY KEY,
	AccountIBAN varchar(30) FOREIGN KEY REFERENCES BankAccount(IBAN),
	CVV as (CardID % 1000)
);

CREATE TABLE ATM(
	ID int PRIMARY KEY IDENTITY,
	Address varchar(30)
);

CREATE TABLE Transactions(
	ATMID int FOREIGN KEY REFERENCES ATM(ID),
	CardID int FOREIGN KEY REFERENCES Card(CardID),
	Time datetime,
	sumOfMoney money,
	PRIMARY KEY(ATMID, CardID, Time)
);

INSERT INTO Customer(CustomerName, dateOfBirth) values ('a', '19860512')
INSERT INTO Customer(CustomerName, dateOfBirth) values ('b', '19781223')
INSERT INTO Customer(CustomerName, dateOfBirth) values ('c', '20000604')
INSERT INTO Customer(CustomerName, dateOfBirth) values ('d', '19990112')
INSERT INTO BankAccount(IBAN, currentBalance, holder) values ('12345', 200, 1)
INSERT INTO BankAccount(IBAN, currentBalance, holder) values ('54321', 2000, 1)
INSERT INTO BankAccount(IBAN, currentBalance, holder) values ('9999', 1002, 2)
INSERT INTO BankAccount(IBAN, currentBalance, holder) values ('7777', 300, 3)
INSERT INTO BankAccount(IBAN, currentBalance, holder) values ('8888', 2800, 4)
INSERT INTO Card(CardID, AccountIBAN) values (1111, '12345')
INSERT INTO Card(CardID, AccountIBAN) values (2222, '9999')
INSERT INTO Card(CardID, AccountIBAN) values (3333, '9999')
INSERT INTO Card(CardID, AccountIBAN) values (4444, '7777')
INSERT INTO Card(CardID, AccountIBAN) values (5555, '8888')

SELECT *
FROM Card

INSERT INTO ATM(Address) values ('Cluj')
INSERT INTO ATM(Address) values ('Bucuresti')
INSERT INTO ATM(Address) values ('Turda')
INSERT INTO ATM(Address) values ('Huedin')
INSERT INTO ATM(Address) values ('Gherla')
INSERT INTO ATM(Address) values ('Dej')

INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (1, 1111, GETDATE(), 3000)
INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (2, 2222, GETDATE(), 2300)
INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (3, 2222, GETDATE(), 2300)
INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (4, 2222, GETDATE(), 2300)
INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (5, 2222, GETDATE(), 2300)
INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (6, 2222, GETDATE(), 2300)
INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (1, 2222, GETDATE(), 2300)
INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (3, 4444, GETDATE(), 500)
INSERT INTO Transactions(ATMID, CardID, Time, sumOfMoney) values (5, 3333, GETDATE(), 700)

SELECT *
FROM Transactions

GO
CREATE OR ALTER PROCEDURE uspDeleteTransactions @CardID int
AS
BEGIN
	DELETE 
	FROM Transactions
	WHERE CardID = @CardID
END

EXEC uspDeleteTransactions 1111


GO
CREATE OR ALTER VIEW V1
AS
SELECT c.CardID
FROM Card as c
WHERE NOT EXISTS
	(SELECT a.ID
	FROM ATM as a
	EXCEPT 
	SELECT t.ATMID
	FROM Transactions as t
	WHERE CardID = c.CardID)

GO


SELECT *
FROM V1


CREATE OR ALTER FUNCTION ufListCards
	(@m int)
RETURNS TABLE
RETURN SELECT c.CardID, c.CVV
	   FROM Card as c
	   WHERE c.CardID IN
	   (SELECT t.CardID
	   FROM Transactions as t
	   GROUP BY t.CardID
	   HAVING SUM(t.sumOfMoney) > @m)
GO

SELECT *
FROM ufListCards(2000)
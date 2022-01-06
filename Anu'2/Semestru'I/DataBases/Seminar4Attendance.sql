CREATE TABLE Products
(PID INT PRIMARY KEY,
PName VARCHAR(50),
Quantity INT)



CREATE TABLE LogBuy
(PName VARCHAR(50),
OperationDate DATE,
Quantity INT)



SELECT * FROM Products
SELECT * FROM LogBuy



GO
CREATE TRIGGER trWhenAddingProd
ON Products
FOR INSERT
AS
INSERT LogBuy(PName, OperationDate, Quantity)
SELECT PName, GETDATE(), Quantity
FROM inserted

INSERT Products VALUES
(1, 'p1', 100),
(2, 'p2', 100),
(3, 'p3', 100),
(4, 'p4', 1)

USE [Product]
GO
EXECUTE sys.sp_cdc_enable_db;
GO


DELETE 
FROM [Person].[Person]

sys.sp_cdc_enable_table
  [ @source_schema = ] '[Product]',   
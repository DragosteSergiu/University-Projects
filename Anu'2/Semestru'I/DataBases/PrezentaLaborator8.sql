
use [EnglishTeamsDB]

CREATE OR ALTER PROCEDURE uspModifyColumn @ColumnName varchar(30), @Type varchar(30)
as
BEGIN
DECLARE @sql nvarchar(1024) = 'ALTER TABLE [EnglishTeamsDB].[dbo].[Teams] ALTER COLUMN ' + @ColumnName + ' ' + @Type;
EXEC sp_executesql @sql
END;


EXEC uspModifyColumn '[Team Name]', 'varchar(25)'

use [EnglishTeamsDB]

CREATE OR ALTER PROCEDURE uspAddColumn @TableName varchar(30), @ColumnName varchar(30), @Type varchar(30)
as
BEGIN
DECLARE @sql nvarchar(1024) = 'ALTER TABLE [EnglishTeamsDB].' +@TableName+' ADD ' + @ColumnName +' ' + @Type;
EXEC sp_executesql @sql
END;

EXEC uspAddColumn '[dbo].[Teams]', 'Town', 'varchar(30)'

CREATE OR ALTER PROCEDURE uspDeleteColumn @TableName varchar(30), @ColumnName varchar(30)
as
BEGIN
DECLARE @sql nvarchar(1024) = 'ALTER TABLE [EnglishTeamsDB].' +@TableName+' DROP ' + @ColumnName;
EXEC sp_executesql @sql
END;

EXEC uspDeleteColumn '[dbo].[Teams]', 'Town'

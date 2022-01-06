BEGIN TRANSACTION
    UPDATE Trophies SET [Trophy Name] = 'Whatever' WHERE Founded = 1876;
    UPDATE Trophies SET [Trophy Name] = 'Whatever' WHERE Founded = 2007;
COMMIT TRANSACTION
/*seesion_id check command*/
SELECT @@SPID;
SELECT @@TRANCOUNT;
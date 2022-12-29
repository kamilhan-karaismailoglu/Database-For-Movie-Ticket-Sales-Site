USE  sinemaDb_log 
GO

DROP INDEX IF EXISTS ekipAdIndex
ON Ekip
GO

CREATE NONCLUSTERED INDEX ekipAdIndex ON Ekip
        (
        Adi ASC
        )
		GO

		SET STATISTICS IO ON
		SET STATISTICS TIME ON

SELECT * FROM Ekip WHERE Cinsiyet = 'E'
GO
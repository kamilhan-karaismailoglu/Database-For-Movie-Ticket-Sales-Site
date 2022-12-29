use sinemaDb_log
GO

IF OBJECT_ID('dbo.SinemaKurulus') IS NOT NULL
	BEGIN
		DROP FUNCTION SinemaYas
	END
GO

Create OR ALTER FUNCTION SinemaYas(@TARIH DATE)
RETURNS INT
AS
        BEGIN

        DECLARE @yas INT = DATEDIFF(YY,@TARIH,GETDATE())
	
	    RETURN @yas

END
GO

Select s.Adi as Adý, dbo.SinemaYas(s.KurulusYili) as Yas From Sinema s
GO


use sinemaDb_log
GO

--!!!!!!  ÖNEMLÝ  !!!!!
--TRIGGER'dan önce Ekip adlý tabloya DogumTarihi kolonunu ekliyoruz.

ALTER TABLE Ekip
ADD DogumTarihi DATE
GO

IF OBJECT_ID ('trgEkipDuzenle') IS NOT NULL
	BEGIN
		DROP TRIGGER trgEkipDuzenle
	END
GO

/* Ekipdekilerin dogum tarihi günümüzden ileri bir tarih olmasý durumunda yeni bir ekip eklenmesi veya ekiplerin güncellenmesini engelleyen triggerý yazýnýz.
 */

CREATE OR ALTER TRIGGER trgEkipDuzenle ON Ekip FOR INSERT , UPDATE  AS

DECLARE @EkipID TABLE ( ID INT )
DECLARE @DogumTarihi DATE = (SELECT DogumTarihi FROM inserted)

INSERT INTO @EkipID SELECT EkipID FROM inserted

IF (@DogumTarihi > GETDATE())
	BEGIN
		ROLLBACK	 
		PRINT('dogum tarihi günümüz tarihinden sonra olamaz.')
	END
ELSE
	UPDATE Ekip SET DogumTarihi=GETDATE() WHERE EkipID IN (SELECT ID FROM @EkipID)
GO

-- Öncelikle doðru bir örnek deneyelim. Burada veri yine ayný þekilde tabloya eklenir ve kayýt tarihi de kolonuna yazýlýr.

EXEC ekipDuzenle 'Tesla','safad' ,'2020-12-30', 'K'
GO

EXEC ekipDuzenle 'Alperen','Civelek' ,'2020-12-30', 'K'
GO

-- Þimdi ise Dogum Tarihi sütununa günümüzden ileri bir tarih yazarak yanlýþ bir örnek deneyelim.

EXEC ekipDuzenle 'Alperen','civelek' ,'2024-12-30', 'E'
GO


--Ek olarak SP'de bulunan catch bloðu ek bir hata fýrlatýyor. Ancak bizim procedurumuz ve triggerýmýzda bir sorun yaratmýyor.

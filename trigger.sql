use sinemaDb_log
GO

--!!!!!!  �NEML�  !!!!!
--TRIGGER'dan �nce Ekip adl� tabloya DogumTarihi kolonunu ekliyoruz.

ALTER TABLE Ekip
ADD DogumTarihi DATE
GO

IF OBJECT_ID ('trgEkipDuzenle') IS NOT NULL
	BEGIN
		DROP TRIGGER trgEkipDuzenle
	END
GO

/* Ekipdekilerin dogum tarihi g�n�m�zden ileri bir tarih olmas� durumunda yeni bir ekip eklenmesi veya ekiplerin g�ncellenmesini engelleyen trigger� yaz�n�z.
 */

CREATE OR ALTER TRIGGER trgEkipDuzenle ON Ekip FOR INSERT , UPDATE  AS

DECLARE @EkipID TABLE ( ID INT )
DECLARE @DogumTarihi DATE = (SELECT DogumTarihi FROM inserted)

INSERT INTO @EkipID SELECT EkipID FROM inserted

IF (@DogumTarihi > GETDATE())
	BEGIN
		ROLLBACK	 
		PRINT('dogum tarihi g�n�m�z tarihinden sonra olamaz.')
	END
ELSE
	UPDATE Ekip SET DogumTarihi=GETDATE() WHERE EkipID IN (SELECT ID FROM @EkipID)
GO

-- �ncelikle do�ru bir �rnek deneyelim. Burada veri yine ayn� �ekilde tabloya eklenir ve kay�t tarihi de kolonuna yaz�l�r.

EXEC ekipDuzenle 'Tesla','safad' ,'2020-12-30', 'K'
GO

EXEC ekipDuzenle 'Alperen','Civelek' ,'2020-12-30', 'K'
GO

-- �imdi ise Dogum Tarihi s�tununa g�n�m�zden ileri bir tarih yazarak yanl�� bir �rnek deneyelim.

EXEC ekipDuzenle 'Alperen','civelek' ,'2024-12-30', 'E'
GO


--Ek olarak SP'de bulunan catch blo�u ek bir hata f�rlat�yor. Ancak bizim procedurumuz ve trigger�m�zda bir sorun yaratm�yor.

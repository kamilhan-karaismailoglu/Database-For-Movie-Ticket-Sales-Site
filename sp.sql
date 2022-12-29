use sinemaDb_log
GO

IF OBJECT_ID('ekipDuzenle') IS NOT NULL
	BEGIN
		DROP PROCEDURE ekipDuzenle
	END
GO

CREATE or ALTER PROCEDURE ekipDuzenle(
@Adi VARCHAR(50), 
@Soyadi VARCHAR(50), 
@DogumTarihi DATE,
@Cinsiyet CHAR(1) 
)
AS 
BEGIN
SET NOCOUNT ON; 
 
 BEGIN TRAN
   BEGIN TRY       
			  --Kullanýcýnýn verdiði ekip adý db'de var mý kontrol ediliyor.
					IF @Adi NOT IN (SELECT e.Adi FROM Ekip e WHERE e.Adi= @Adi and e.Soyadi = @Soyadi )
					BEGIN
	
						--Kullanýcýnýn verdiði ekip yoksa kaydediyor
							INSERT INTO Ekip 
							VALUES (@Adi,@Soyadi,@DogumTarihi,@Cinsiyet);
					END

					--Kullanýcýnýn verdiði ekip adý db'de varsa else kýsmý çalýþýyor.
					ELSE BEGIN
				
					--Kullanýcýnýn verdiði  bilgiler doðrultusunda ekip db'de update ediliyor.
					UPDATE Ekip
					SET DogumTarihi = @DogumTarihi , Cinsiyet = @Cinsiyet
					WHERE (Adi = @Adi and Soyadi = @Soyadi)

					END
               
			   --Hata olmadýðý takdirde bu iþlemler commit edilir.
              COMMIT TRANSACTION
       END TRY
       BEGIN CATCH
			--Hata yakalanýldýðý takdirde rollback ile iþlemler geri alýnýr.
              ROLLBACK TRANSACTION
       END CATCH
END
GO

-- olan bir ekip update ediliyor

EXEC ekipDuzenle 'Jon','Watts','1971-06-28','K'
GO

-- olmayan ekip tabloya ekleniyor
EXEC ekipDuzenle 'alperen','civelekoglu','1942-06-28','K'
GO

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
			  --Kullan�c�n�n verdi�i ekip ad� db'de var m� kontrol ediliyor.
					IF @Adi NOT IN (SELECT e.Adi FROM Ekip e WHERE e.Adi= @Adi and e.Soyadi = @Soyadi )
					BEGIN
	
						--Kullan�c�n�n verdi�i ekip yoksa kaydediyor
							INSERT INTO Ekip 
							VALUES (@Adi,@Soyadi,@DogumTarihi,@Cinsiyet);
					END

					--Kullan�c�n�n verdi�i ekip ad� db'de varsa else k�sm� �al���yor.
					ELSE BEGIN
				
					--Kullan�c�n�n verdi�i  bilgiler do�rultusunda ekip db'de update ediliyor.
					UPDATE Ekip
					SET DogumTarihi = @DogumTarihi , Cinsiyet = @Cinsiyet
					WHERE (Adi = @Adi and Soyadi = @Soyadi)

					END
               
			   --Hata olmad��� takdirde bu i�lemler commit edilir.
              COMMIT TRANSACTION
       END TRY
       BEGIN CATCH
			--Hata yakalan�ld��� takdirde rollback ile i�lemler geri al�n�r.
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

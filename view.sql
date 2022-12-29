/*sinemalarýn özellikleri(isim,salon sayýsý,yaþ fonksiyonu kullanarak) , 
 vizyondaki filmler isimleri , 
 ve bilet fiyatlarýna göre iyi,orta ve kötü olarak sýnýflandýran  */

 use sinemaDb_log
 GO

 Create OR ALTER FUNCTION SinemaYas(@TARIH DATE)
RETURNS INT
AS
        BEGIN

        DECLARE @yas INT = DATEDIFF(YY,@TARIH,GETDATE())
	
	    RETURN @yas

END
GO

 IF OBJECT_ID('dbo.SinemaView') IS NOT NULL
 BEGIN
        DROP VIEW SinemaView
 END
 GO

 CREATE OR ALTER VIEW SinemaView AS

 Select si.SinemaID as SinemaID, si.Adi as SinemaAdý, dbo.SinemaYas(si.KurulusYili) as BinaYasý,f.Adi as FilmAdý,
 CASE 
          WHEN b.BiletFiyati BETWEEN 0 AND 20 THEN 'Öðrenci'
		  WHEN b.BiletFiyati BETWEEN 20 AND 35 THEN 'Ekonomik'
		  ELSE 'Normal'
		  END AS BiletSýnýflandýrmasý
From Sinema si INNER JOIN Bilet b ON si.SinemaID = b.SinemaID
               INNER JOIN SinemaSalonu sa ON sa.SinemaID = si.SinemaID
			   INNER JOIN HangiSalonHangiSeans hshs ON hshs.SalonNumarasi = sa.SalonNumarasi
			   INNER JOIN Seans sea ON sea.SeansID = hshs.SeansID
			   INNER JOIN Film f ON f.FilmID = sea.FilmID
GO

/*Sinemalarýn bulunduðu þehirleri,
  Filmlerin sürelerini 
*/

Select sw.*, i.Adi as SalonunBulunduðuÝl, f.Sure FROM 
SinemaView sw INNER JOIN Sinema si ON si.SinemaID = sw.SinemaID
              INNER JOIN Il i ON si.IlID = i.ID
			  
			  INNER JOIN SinemaSalonu sa ON sa.SinemaID = si.SinemaID
			  INNER JOIN HangiSalonHangiSeans hshs ON hshs.SalonNumarasi = sa.SalonNumarasi
			  INNER JOIN Seans sea ON sea.SeansID = hshs.SeansID
			  INNER JOIN Film f ON f.FilmID = sea.FilmID
GO
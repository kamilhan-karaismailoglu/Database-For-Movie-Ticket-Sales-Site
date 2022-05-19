USE sinema
GO

--1)Son 5 yýlda çekilen aksiyon filmlerinin ortalama bütçesinden daha fazla bütçeye sahip bu yýlki aksiyon filmlerinin hepsinde baþrol oynayan oyuncularýn listesi

SELECT Ekip.EkipID, Ekip.Adi, Ekip.Soyadi, Ekip.Cinsiyet,Ekip.DogumTarihi,Ekip.Yas
FROM HangiFilmHangiEkipHangiGorev HF INNER JOIN Film ON HF.FilmID=Film.FilmID 
									 INNER JOIN Ekip ON HF.EkipID = Ekip.EkipID
									 INNER JOIN Gorev ON HF.GorevID = Gorev.GorevID
									 INNER JOIN HangiFilmHangiKategori HFHG ON Film.FilmID = HFHG.FilmID 
									 INNER JOIN FilmKategori ON HFHG.KategoriID = FilmKategori.KategoriID 										  
WHERE Gorev.Adi='baþrol' AND FilmKategori.Adi = 'Aksiyon' AND Film.CekildigiYil = YEAR(GETDATE()) AND Film.Butce > (SELECT AVG(Butce) FROM Film INNER JOIN HangiFilmHangiKategori HFHG ON Film.FilmID = HFHG.FilmID INNER JOIN FilmKategori ON HFHG.KategoriID = FilmKategori.KategoriID WHERE Film.CekildigiYil>= YEAR(GETDATE())-5 AND FilmKategori.Adi = 'Aksiyon' )

--2)Ýstanbul'un Bahçelievler ilçesindeki sinemalarýn pazartesi günü olan seanslarýnda oynanan filmlerin bütçelerinin ortalamasý 

SELECT AVG(Butce) 
FROM Seans INNER JOIN HangiSalonHangiSeans HSHS ON Seans.SeansID=HSHS.SeansID 
		   INNER JOIN SinemaSalonu SS ON HSHS.SalonNumarasi = SS.SalonNumarasi
		   INNER JOIN Sinema ON SS.SinemaID = Sinema.SinemaID
		   INNER JOIN Il ON sinema.IlID = Il.ID
		   INNER JOIN Ilce ON sinema.IlceID = Ilce.ID
		   INNER JOIN Film ON Seans.FilmID = Film.FilmID		   
WHERE Il.Adi='istanbul' AND Ilce.Adi='bahçelievler' AND Seans.Gun='pazartesi'

--3)Yönetmenlerin ortalama yaþýndan daha küçük yaþtaki yönetmenlerin yönettiði filmlerin Imdb puanlarýnýn yönetmen isimleri ve film isimleriyle birlikte listesi

SELECT Ekip.Adi,Ekip.Soyadi,Ekip.Yas,Film.Adi AS FilmAdi,Film.ImdbPuani
FROM HangiFilmHangiEkipHangiGorev HF INNER JOIN Film ON HF.FilmID=Film.FilmID 
									 INNER JOIN Ekip ON HF.EkipID = Ekip.EkipID
									 INNER JOIN Gorev ON HF.GorevID = Gorev.GorevID
WHERE Ekip.Yas< (SELECT AVG(Yas) FROM HangiFilmHangiEkipHangiGorev HF INNER JOIN Film ON HF.FilmID=Film.FilmID INNER JOIN Ekip ON HF.EkipID = Ekip.EkipID INNER JOIN Gorev ON HF.GorevID = Gorev.GorevID WHERE Gorev.Adi='Yönetmen' ) AND Gorev.Adi='Yönetmen'

--4)10'den fazla bilet satýn almýþ seyircilerin yaþadýðý il ve ilçeler ile birlikte isimlerinin listesi

SELECT Seyirci.SeyirciID,Seyirci.Adi, Seyirci.Soyadi, Il.Adi AS Il, Ilce.Adi AS Ilce
FROM Seyirci INNER JOIN Il ON Seyirci.IlID = Il.ID
			 INNER JOIN Ilce ON Seyirci.IlceID = Ilce.ID
WHERE SeyirciID IN (SELECT Seyirci.SeyirciID FROM Bilet INNER JOIN Seyirci ON Bilet.SeyirciID=Seyirci.SeyirciID GROUP BY Seyirci.SeyirciID HAVING COUNT(Seyirci.SeyirciID) >10)
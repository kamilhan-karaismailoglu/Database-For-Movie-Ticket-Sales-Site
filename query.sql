USE sinema
GO

--1)Son 5 y�lda �ekilen aksiyon filmlerinin ortalama b�t�esinden daha fazla b�t�eye sahip bu y�lki aksiyon filmlerinin hepsinde ba�rol oynayan oyuncular�n listesi

SELECT Ekip.EkipID, Ekip.Adi, Ekip.Soyadi, Ekip.Cinsiyet,Ekip.DogumTarihi,Ekip.Yas
FROM HangiFilmHangiEkipHangiGorev HF INNER JOIN Film ON HF.FilmID=Film.FilmID 
									 INNER JOIN Ekip ON HF.EkipID = Ekip.EkipID
									 INNER JOIN Gorev ON HF.GorevID = Gorev.GorevID
									 INNER JOIN HangiFilmHangiKategori HFHG ON Film.FilmID = HFHG.FilmID 
									 INNER JOIN FilmKategori ON HFHG.KategoriID = FilmKategori.KategoriID 										  
WHERE Gorev.Adi='ba�rol' AND FilmKategori.Adi = 'Aksiyon' AND Film.CekildigiYil = YEAR(GETDATE()) AND Film.Butce > (SELECT AVG(Butce) FROM Film INNER JOIN HangiFilmHangiKategori HFHG ON Film.FilmID = HFHG.FilmID INNER JOIN FilmKategori ON HFHG.KategoriID = FilmKategori.KategoriID WHERE Film.CekildigiYil>= YEAR(GETDATE())-5 AND FilmKategori.Adi = 'Aksiyon' )

--2)�stanbul'un Bah�elievler il�esindeki sinemalar�n pazartesi g�n� olan seanslar�nda oynanan filmlerin b�t�elerinin ortalamas� 

SELECT AVG(Butce) 
FROM Seans INNER JOIN HangiSalonHangiSeans HSHS ON Seans.SeansID=HSHS.SeansID 
		   INNER JOIN SinemaSalonu SS ON HSHS.SalonNumarasi = SS.SalonNumarasi
		   INNER JOIN Sinema ON SS.SinemaID = Sinema.SinemaID
		   INNER JOIN Il ON sinema.IlID = Il.ID
		   INNER JOIN Ilce ON sinema.IlceID = Ilce.ID
		   INNER JOIN Film ON Seans.FilmID = Film.FilmID		   
WHERE Il.Adi='istanbul' AND Ilce.Adi='bah�elievler' AND Seans.Gun='pazartesi'

--3)Y�netmenlerin ortalama ya��ndan daha k���k ya�taki y�netmenlerin y�netti�i filmlerin Imdb puanlar�n�n y�netmen isimleri ve film isimleriyle birlikte listesi

SELECT Ekip.Adi,Ekip.Soyadi,Ekip.Yas,Film.Adi AS FilmAdi,Film.ImdbPuani
FROM HangiFilmHangiEkipHangiGorev HF INNER JOIN Film ON HF.FilmID=Film.FilmID 
									 INNER JOIN Ekip ON HF.EkipID = Ekip.EkipID
									 INNER JOIN Gorev ON HF.GorevID = Gorev.GorevID
WHERE Ekip.Yas< (SELECT AVG(Yas) FROM HangiFilmHangiEkipHangiGorev HF INNER JOIN Film ON HF.FilmID=Film.FilmID INNER JOIN Ekip ON HF.EkipID = Ekip.EkipID INNER JOIN Gorev ON HF.GorevID = Gorev.GorevID WHERE Gorev.Adi='Y�netmen' ) AND Gorev.Adi='Y�netmen'

--4)10'den fazla bilet sat�n alm�� seyircilerin ya�ad��� il ve il�eler ile birlikte isimlerinin listesi

SELECT Seyirci.SeyirciID,Seyirci.Adi, Seyirci.Soyadi, Il.Adi AS Il, Ilce.Adi AS Ilce
FROM Seyirci INNER JOIN Il ON Seyirci.IlID = Il.ID
			 INNER JOIN Ilce ON Seyirci.IlceID = Ilce.ID
WHERE SeyirciID IN (SELECT Seyirci.SeyirciID FROM Bilet INNER JOIN Seyirci ON Bilet.SeyirciID=Seyirci.SeyirciID GROUP BY Seyirci.SeyirciID HAVING COUNT(Seyirci.SeyirciID) >10)
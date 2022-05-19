USE sinema
GO

/* 1)Mail adresi dilara@gmail.com olan seyirciyi silelim. */

--1a)Seyirciyi kaydýný seyirci tablosundan silelim. 
DELETE 
FROM Seyirci 
WHERE SeyirciID = (SELECT SeyirciID FROM Seyirci WHERE Mail = 'dilara@gmail.com')

--1b)Silinen Seyircinin bilet tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM Bilet
WHERE Bilet.SeyirciID IS NULL

/* 2)Ekip tablomuzdan yaþý 70 dan büyük olan oyuncularý silelim. */

--2a)Oyuncularýn kaydýný Ekip tablosundan silelim. 
DELETE 
FROM Ekip
WHERE DATEDIFF(YEAR,DogumTarihi,GETDATE()) > 70

--2b)Silinen Oyuncularýn HangiFilmHangiEkipHangiGorev tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM HangiFilmHangiEkipHangiGorev
WHERE HangiFilmHangiEkipHangiGorev.EkipID IS NULL

/* 3)Mustafa aktaþ isimli seyircinin 25/04/2022 kesim tarihli biletini silelim. */
DELETE 
FROM Bilet
WHERE SeyirciID = (SELECT SeyirciID FROM Seyirci WHERE Adi = 'mustafa' AND Soyadi = 'aktaþ') AND KesimTarihi = '2022-04-25'

/* 4)Jason Segel'in baþrol olduðu filmleri silelim. */

--4a)Filmlerin kayýtlarýný Film tablosundan silelim.
DELETE 
FROM Film
WHERE FilmID = (SELECT FilmID FROM HangiFilmHangiEkipHangiGorev WHERE EkipID = (SELECT EkipID FROM Ekip WHERE Adi='Jason' AND Soyadi='Segel') AND GorevID=(SELECT GorevID FROM Gorev WHERE Adi='Baþrol') )

--4b)Silinen Filmlerin HangiFilmHangiEkipHangiGorev tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM HangiFilmHangiEkipHangiGorev
WHERE HangiFilmHangiEkipHangiGorev.FilmID IS NULL

--4c)Silinen Filmlerin HangiFilmHangiKategori tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM HangiFilmHangiKategori
WHERE HangiFilmHangiKategori.FilmID IS NULL

--4d)Silinen Filmlerin Bilet tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM Bilet
WHERE Bilet.FilmID IS NULL

--4e)Silinen Filmlerin Seans tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM Seans
WHERE Seans.FilmID IS NULL

--4f)Silinen Filmlerin Seanslarýnýn HangiSalonHangiSeans tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM HangiSalonHangiSeans
WHERE HangiSalonHangiSeans.SeansID IS NULL

/* 5)Bütçesi 200 milyon ile 299 milyon arasý olan filmleri silelim. */

--5a)Filmlerin kayýtlarýný Film tablosundan silelim.
DELETE 
FROM Film 
WHERE Butce BETWEEN 200000000 AND 299000000

--5b)Silinen Filmlerin HangiFilmHangiEkipHangiGorev tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM HangiFilmHangiEkipHangiGorev
WHERE HangiFilmHangiEkipHangiGorev.FilmID IS NULL

--5c)Silinen Filmlerin HangiFilmHangiKategori tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM HangiFilmHangiKategori
WHERE HangiFilmHangiKategori.FilmID IS NULL

--5d)Silinen Filmlerin Bilet tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM Bilet
WHERE Bilet.FilmID IS NULL

--5e)Silinen Filmlerin Seans tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM Seans
WHERE Seans.FilmID IS NULL

--5f)Silinen Filmlerin Seanslarýnýn HangiSalonHangiSeans tablosundaki foregn key olduðu satýrlarý silelim.
DELETE
FROM HangiSalonHangiSeans
WHERE HangiSalonHangiSeans.SeansID IS NULL

USE sinema
GO

--1-) sinema istanbul'un kurulu� y�l�n� g�ncelleyelim.
UPDATE Sinema
SET Sinema.KurulusYili = '1980'
WHERE Sinema.Adi = 'sinema istanbul'

--2-) Mail adresi kamilhan@gmail.com olan seyircinin mail adresini ve do�um tarihini g�ncelleyelim.
UPDATE Seyirci 
SET Seyirci.Mail = 'kamilhan.yeniMail@gmail.com', Seyirci.DogumTarihi = '2000-02-17'
WHERE Seyirci.Mail = 'kamilhan@gmail.com'

--3-) Lily Collins'in ad�n� Lily Jane olarak g�ncelleyelim.
UPDATE Ekip
SET Ekip.Adi = 'Lily Jane'
WHERE Ekip.Adi = 'Lily' AND Ekip.Soyadi = 'Collins'

--4-) mail adresi bedirhan@gmail.com olan seyircinin g�sterim tarih� yar�n olan biletini pasif duruma getirelim.
UPDATE Bilet
SET Bilet.BiletDurumu = 0
FROM Bilet INNER JOIN Seyirci ON Bilet.SeyirciID = Seyirci.SeyirciID
WHERE Seyirci.Mail = 'bedirhan@gmail.com' AND Bilet.GosterimTarihi = DATEADD(DAY,DATEDIFF(DAY,0,GETDATE()),1)

--5-) Jon Watts'�n y�netmen oldu�u filmin b�t�esini 225 milyon olarak de�i�tirelim.
UPDATE Film
SET Butce = 225000000
FROM Film   INNER JOIN HangiFilmHangiEkipHangiGorev ON Film.FilmID = HangiFilmHangiEkipHangiGorev.FilmID 
			INNER JOIN Ekip ON HangiFilmHangiEkipHangiGorev.EkipID = Ekip.EkipID
			INNER JOIN Gorev ON HangiFilmHangiEkipHangiGorev.GorevID = Gorev.GorevID
			WHERE Ekip.Adi = 'Jon' AND Ekip.Soyadi='Watts' AND Gorev.Adi='Y�netmen'

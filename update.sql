USE sinema
GO

--1-) sinema istanbul'un kuruluþ yýlýný güncelleyelim.
UPDATE Sinema
SET Sinema.KurulusYili = '1980'
WHERE Sinema.Adi = 'sinema istanbul'

--2-) Mail adresi kamilhan@gmail.com olan seyircinin mail adresini ve doðum tarihini güncelleyelim.
UPDATE Seyirci 
SET Seyirci.Mail = 'kamilhan.yeniMail@gmail.com', Seyirci.DogumTarihi = '2000-02-17'
WHERE Seyirci.Mail = 'kamilhan@gmail.com'

--3-) Lily Collins'in adýný Lily Jane olarak güncelleyelim.
UPDATE Ekip
SET Ekip.Adi = 'Lily Jane'
WHERE Ekip.Adi = 'Lily' AND Ekip.Soyadi = 'Collins'

--4-) mail adresi bedirhan@gmail.com olan seyircinin gösterim tarihÝ yarýn olan biletini pasif duruma getirelim.
UPDATE Bilet
SET Bilet.BiletDurumu = 0
FROM Bilet INNER JOIN Seyirci ON Bilet.SeyirciID = Seyirci.SeyirciID
WHERE Seyirci.Mail = 'bedirhan@gmail.com' AND Bilet.GosterimTarihi = DATEADD(DAY,DATEDIFF(DAY,0,GETDATE()),1)

--5-) Jon Watts'ýn yönetmen olduðu filmin bütçesini 225 milyon olarak deðiþtirelim.
UPDATE Film
SET Butce = 225000000
FROM Film   INNER JOIN HangiFilmHangiEkipHangiGorev ON Film.FilmID = HangiFilmHangiEkipHangiGorev.FilmID 
			INNER JOIN Ekip ON HangiFilmHangiEkipHangiGorev.EkipID = Ekip.EkipID
			INNER JOIN Gorev ON HangiFilmHangiEkipHangiGorev.GorevID = Gorev.GorevID
			WHERE Ekip.Adi = 'Jon' AND Ekip.Soyadi='Watts' AND Gorev.Adi='Yönetmen'

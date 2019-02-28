--1) 1.000 YTL'den fazla olan kredilerin, kredi numaralarýný listeleyin.
SELECT kredi_numarasi 
FROM kredi 
WHERE miktar > 1000


--2) Kredi veren þube isimlerini listeleyin. Tekrar eden satýrlarý elemeyiniz.
SELECT ALL(sube_adi) 
FROM kredi


--3) Þ201 isimli þubeden borç alan müþterilerin 
-- isimlerini (ad, soyad bilgisi), kredi miktarlarýný ve kredi numaralarýný listeleyin.
-- borcalan tablosu, kredi ve musteri arasýndaki iliþki tablosudur.
SELECT musteri_adi, musteri_soyadi, miktar, k.kredi_numarasi
FROM kredi k, borcalan b, musteri m
WHERE
b.kredi_numarasi = k.kredi_numarasi AND 
b.musteri_id     = m.musteri_id AND 
k.sube_adi='Þ201'


--4) Þ201 adlý þubeden kredi çeken fakat herhangi bir þubede hesabý olmayan
-- tüm müþterilerin isim ve soyisimlerini listeleyin. Bu sorgu için except tümcesini kullanýn.
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM  kredi k, borcalan b, musteri m 
WHERE
b.kredi_numarasi	= k.kredi_numarasi AND
b.musteri_id		= m.musteri_id AND
k.sube_adi			= 'Þ201') 
EXCEPT
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, parayatiran p
WHERE m.musteri_id	= p.musteri_id)


--5) Bazý þubelerden kredi çeken müþterilerin isim ve soyisimlerini, 
-- çektikleri kredilerin numaralarýný ve miktarlarýný listeleyiniz.
SELECT m.musteri_adi, m.musteri_soyadi, b.kredi_numarasi, k.miktar
FROM kredi k, borcalan b, musteri m
WHERE 
m.musteri_id=b.musteri_id AND 
k.kredi_numarasi=b.kredi_numarasi


--6) Eskiþehir'de bulunan bazý þubelerden daha fazla miktarda kazanca sahip olan þubelerin isimlerini listeleyin.
--Tekrar eden þube isimlerini eleyiniz.
SELECT DISTINCT(T.sube_adi)
FROM sube T, sube S
WHERE T.kazanc > S.kazanc AND S.sube_sehir='Eskiþehir'


--7) Para yatýran veya kredi çeken müþterileri (isim, soyisim) listeleyin. 
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, parayatiran p
WHERE m.musteri_id = p.musteri_id)
UNION
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, borcalan b
WHERE m.musteri_id=b.musteri_id)


--8) Kredi çeken ve hesabý olan müþterileri (isim, soyisim) listeleyin. 
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, borcalan b
WHERE m.musteri_id = b.musteri_id)
INTERSECT
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, parayatiran p
WHERE m.musteri_id = p.musteri_id)


--9) Þ201 isimli þubede hem hesabý hem de borcu olan müþterileri (isim, soyisim) listeleyin. 
SELECT m.musteri_adi, m.musteri_soyadi
FROM kredi, borcalan b, musteri m
WHERE 
b.kredi_numarasi	= kredi.kredi_numarasi AND 
kredi.sube_adi		= 'Þ201' AND 
b.musteri_id IN
(
	SELECT p.musteri_id
	FROM hesap h, parayatiran p, musteri m
	WHERE	p.hesap_numarasi	= h.hesap_numarasi AND 
			m.musteri_id=p.musteri_id AND 
			h.sube_adi='Þ201'
)

--10) Eskiþehir'de bulunan tüm þubelerden daha fazla kazanca sahip olan tüm þubelerin isimlerini listeleyin.
SELECT sube_adi 
FROM sube
WHERE kazanc > all
(SELECT kazanc 
FROM sube
WHERE sube_sehir = 'Eskiþehir')

--1) 1.000 YTL'den fazla olan kredilerin, kredi numaralar�n� listeleyin.
SELECT kredi_numarasi 
FROM kredi 
WHERE miktar > 1000


--2) Kredi veren �ube isimlerini listeleyin. Tekrar eden sat�rlar� elemeyiniz.
SELECT ALL(sube_adi) 
FROM kredi


--3) �201 isimli �ubeden bor� alan m��terilerin 
-- isimlerini (ad, soyad bilgisi), kredi miktarlar�n� ve kredi numaralar�n� listeleyin.
-- borcalan tablosu, kredi ve musteri aras�ndaki ili�ki tablosudur.
SELECT musteri_adi, musteri_soyadi, miktar, k.kredi_numarasi
FROM kredi k, borcalan b, musteri m
WHERE
b.kredi_numarasi = k.kredi_numarasi AND 
b.musteri_id     = m.musteri_id AND 
k.sube_adi='�201'


--4) �201 adl� �ubeden kredi �eken fakat herhangi bir �ubede hesab� olmayan
-- t�m m��terilerin isim ve soyisimlerini listeleyin. Bu sorgu i�in except t�mcesini kullan�n.
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM  kredi k, borcalan b, musteri m 
WHERE
b.kredi_numarasi	= k.kredi_numarasi AND
b.musteri_id		= m.musteri_id AND
k.sube_adi			= '�201') 
EXCEPT
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, parayatiran p
WHERE m.musteri_id	= p.musteri_id)


--5) Baz� �ubelerden kredi �eken m��terilerin isim ve soyisimlerini, 
-- �ektikleri kredilerin numaralar�n� ve miktarlar�n� listeleyiniz.
SELECT m.musteri_adi, m.musteri_soyadi, b.kredi_numarasi, k.miktar
FROM kredi k, borcalan b, musteri m
WHERE 
m.musteri_id=b.musteri_id AND 
k.kredi_numarasi=b.kredi_numarasi


--6) Eski�ehir'de bulunan baz� �ubelerden daha fazla miktarda kazanca sahip olan �ubelerin isimlerini listeleyin.
--Tekrar eden �ube isimlerini eleyiniz.
SELECT DISTINCT(T.sube_adi)
FROM sube T, sube S
WHERE T.kazanc > S.kazanc AND S.sube_sehir='Eski�ehir'


--7) Para yat�ran veya kredi �eken m��terileri (isim, soyisim) listeleyin. 
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, parayatiran p
WHERE m.musteri_id = p.musteri_id)
UNION
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, borcalan b
WHERE m.musteri_id=b.musteri_id)


--8) Kredi �eken ve hesab� olan m��terileri (isim, soyisim) listeleyin. 
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, borcalan b
WHERE m.musteri_id = b.musteri_id)
INTERSECT
(SELECT m.musteri_adi, m.musteri_soyadi 
FROM musteri m, parayatiran p
WHERE m.musteri_id = p.musteri_id)


--9) �201 isimli �ubede hem hesab� hem de borcu olan m��terileri (isim, soyisim) listeleyin. 
SELECT m.musteri_adi, m.musteri_soyadi
FROM kredi, borcalan b, musteri m
WHERE 
b.kredi_numarasi	= kredi.kredi_numarasi AND 
kredi.sube_adi		= '�201' AND 
b.musteri_id IN
(
	SELECT p.musteri_id
	FROM hesap h, parayatiran p, musteri m
	WHERE	p.hesap_numarasi	= h.hesap_numarasi AND 
			m.musteri_id=p.musteri_id AND 
			h.sube_adi='�201'
)

--10) Eski�ehir'de bulunan t�m �ubelerden daha fazla kazanca sahip olan t�m �ubelerin isimlerini listeleyin.
SELECT sube_adi 
FROM sube
WHERE kazanc > all
(SELECT kazanc 
FROM sube
WHERE sube_sehir = 'Eski�ehir')

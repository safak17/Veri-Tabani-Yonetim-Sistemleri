CREATE DATABASE Lab2
GO
use [Lab2]
GO


CREATE TABLE sube (
sube_adi NVARCHAR(20) PRIMARY KEY,
sube_city NVARCHAR(20) NOT NULL,
kazanc INT
);


CREATE TABLE hesap (
hesap_numarasi INT PRIMARY KEY,
bakiye INT,

sube_adi NVARCHAR(20),
FOREIGN KEY(sube_adi) REFERENCES sube(sube_adi)
);


CREATE TABLE kredi (
kredi_numarasi INT PRIMARY KEY,
miktar INT,

sube_adi NVARCHAR(20),
FOREIGN KEY (sube_adi) REFERENCES sube(sube_adi)
);


CREATE TABLE musteri(
musteri_adi NVARCHAR(20) PRIMARY KEY,
musteri_sokak NVARCHAR(20),
musteri_sehir NVARCHAR(20)
);

CREATE TABLE borcalan(
kredi_numarasi INT,
musteri_adi NVARCHAR(20),
PRIMARY KEY( kredi_numarasi, musteri_adi ),
FOREIGN KEY( kredi_numarasi ) REFERENCES kredi( kredi_numarasi ),
FOREIGN KEY( musteri_adi ) REFERENCES musteri( musteri_adi )
);

CREATE TABLE parayatiran(
hesap_numarasi INT,
musteri_adi NVARCHAR(20),
PRIMARY KEY( hesap_numarasi, musteri_adi ),
FOREIGN KEY( hesap_numarasi ) REFERENCES hesap( hesap_numarasi ),
FOREIGN KEY( musteri_adi ) REFERENCES musteri( musteri_adi)
);
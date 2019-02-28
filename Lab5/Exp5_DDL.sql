create table satici(
	saticiID int,
	isim varchar(50),
	sehir varchar(20),
	komisyon decimal(15,2),
	primary key(saticiID)
)
create table musteri(
	musteriID int,
	musteriIsim varchar(50),
	sehir varchar(20),
	puan int,
	saticiID int,
	primary key(musteriID),
	foreign key(saticiID) references satici
)
create table siparis(
	siparisNo int,
	siparisMiktari decimal(8,2),
	siparisTarihi datetime,
	saticiID int,
	musteriID int,
	foreign key(musteriID) references musteri,
	foreign key(saticiID) references satici
)
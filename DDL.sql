create table Weather
(
	weatherid int identity primary key,
	[name] varchar(30) 
);

create table Category
(
	categoryid int identity primary key,
	[name] varchar(20)
);

create table City
(
	cityid int identity primary key,
	weatherid int,
	[name] varchar(20),
	foreign key (weatherid) references Weather(weatherid)
);

create table Fruit
(
	fruitid int identity primary key,
	[name] varchar(20),
	size varchar(3),
	categoryid int,
	cityid int,
	foreign key (categoryid) references Category(categoryid),
	foreign key (cityid) references City(cityid)
);
alter table Fruit
add check (size in ('S','M','L','XL'));


create table Person
(
	personid int identity primary key,
	firstname varchar(20),
	lastname varchar(35),
	date_of_birth datetime,
	email varchar(40)
);
ALTER TABLE Person
ADD CONSTRAINT birth_date
DEFAULT '2000-11-11 1:00:00' FOR date_of_birth;

create table Customer
(
	customerid int identity primary key,
	personid int,
	foreign key (personid) references Person(personid)
);

create table Farmer
(
	farmerid int identity primary key,
	personid int,
	foreign key (personid) references Person(personid)
);

create table production
(
	proid int identity primary key,
	fruitid int,
	farmerid int,
	amount numeric(6,1),
	price_per_k numeric(4,1),
	productiondate datetime,
	foreign key (fruitid) references Fruit(fruitid),
	foreign key (farmerid) references Farmer(farmerid)
);
ALTER TABLE production
ADD CONSTRAINT pro_date
DEFAULT getdate() FOR productiondate;

create table buy_fruit
(
	paymentid int identity primary key,
	proid int,
	customerid int,
	[weight] numeric(4,1),
	total_price numeric(4,0),
	dataofpayment datetime,
	foreign key (proid) references production(proid),
	foreign key (customerid) references Customer(customerid)
);
ALTER TABLE buy_fruit
ADD CONSTRAINT buy_date
DEFAULT getdate() FOR dataofpayment;



insert into Weather(name)
values ('windy');
insert into Weather(name)
values ('rainy');
insert into Weather(name)
values ('sunny');
insert into Weather(name)
values ('wet');
--------------------------------------------------------
insert into City(weatherid,name)
values ('3','Esfahan');
insert into City(weatherid,name)
values ('3','shiraz');
insert into City(weatherid,name)
values ('3','mashhad');
insert into City(weatherid,name)
values ('3','kerman');
insert into City(weatherid,name)
values ('2','rasht');
insert into City(weatherid,name)
values ('3','ahvaz');
--------------------------------------------------------
insert into Category(name)
values ('fruit');
insert into Category(name)
values ('vegetable');
insert into Category(name)
values ('nut');
--------------------------------------------------------
insert into Fruit(name,size,categoryid,cityid)
values ('orange','M','1','5');
insert into Fruit(name,size,categoryid,cityid)
values ('apple','M','1','1');
insert into Fruit(name,size,categoryid,cityid)
values ('Narenj','M','1','2');
insert into Fruit(name,size,categoryid,cityid)
values ('potato','M','1','3');
insert into Fruit(name,size,categoryid,cityid)
values ('tomato','M','1','3');
insert into Fruit(name,size,categoryid,cityid)
values ('cucumber','M','1','1');
insert into Fruit(name,size,categoryid,cityid)
values ('date','S','3','6');
insert into Fruit(name,size,categoryid,cityid)
values ('pistachio','S','3','4');
--------------------------------------------------------
insert into Person(firstname,lastname,date_of_birth)
values ('Ali','Ghadiri','1998-01-01 23:59:59');
insert into Person(firstname,lastname,date_of_birth)
values ('Mohammad','Ghadiri','1988-01-01 23:59:59');
insert into Person(firstname,lastname,date_of_birth)
values ('said','dayani','2002-01-01 23:59:59');
insert into Person(firstname,lastname,date_of_birth)
values ('adel','karshenas','2013-01-01 23:59:59');
insert into Person(firstname,lastname,date_of_birth)
values ('afrooz','goldaste','1993-01-01 23:59:59');
insert into Person(firstname,lastname,date_of_birth)
values ('shayan','shafie','1976-01-01 23:59:59');
insert into Person(firstname,lastname,date_of_birth)
values ('Ali','bighamian','1978-01-01 23:59:59');
--------------------------------------------------------
insert into Customer(personid)
values ('1');
insert into Customer(personid)
values ('3');
insert into Customer(personid)
values ('7');
insert into Customer(personid)
values ('5');
--------------------------------------------------------
insert into Farmer(personid)
values ('2');
insert into Farmer(personid)
values ('4');
insert into Farmer(personid)
values ('6');
--------------------------------------------------------
insert into production(fruitid,farmerid,amount,price_per_k,productiondate)
values ('1','1',300,10,getdate());
insert into production(fruitid,farmerid,amount,price_per_k,productiondate)
values ('2','2',500,15,getdate());
insert into production(fruitid,farmerid,amount,price_per_k,productiondate)
values ('5','3',800,14,getdate());
--------------------------------------------------------
insert into buy_fruit(proid, customerid, weight, dataofpayment)
values (1,2,3,getdate());
insert into buy_fruit(proid, customerid, weight, dataofpayment)
values (3,1,4,getdate());
insert into buy_fruit(proid, customerid, weight, dataofpayment)
values (2,3,2,getdate());
insert into buy_fruit(proid, customerid, weight, dataofpayment)
values (2,2,6,getdate());


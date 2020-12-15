create table Person
(
	personid varchar(7) not null primary key,
	firstname varchar(20),
	lastname varchar(35),
	date_of_birth datetime,
	email varchar(40)
);

create table Customer
(
	customerid varchar(7) not null primary key,
	personid varchar(7) not null,
	foreign key (personid) references Person(personid)
);

create table Farmer
(
	farmerid varchar(7) not null primary key,
	personid varchar(7) not null,
	foreign key (personid) references Person(personid)
);

create table Fruit
(
	fruitid varchar(7) not null primary key,
	[name] varchar(20),
	size varchar(3),
	categoryid varchar(5) not null,
	cityid varchar(5),
	foreign key (categoryid) references Category(categoryid),
	foreign key (cityid) references City(cityid)
);

create table Category
(
	categoryid varchar(5) not null primary key,
	[name] varchar(20)
);

create table City
(
	cityid varchar(5) not null primary key,
	weatherid varchar(5),
	[name] varchar(20),
	foreign key (weatherid) references Weather(weatherid)
);

create table Weather
(
	weatherid varchar(5) not null primary key,
	[name] varchar(30) 
);

create table buy_fruit
(
	paymentid varchar(5) not null primary key,
	fruitid varchar(7) not null,
	customerid varchar(7) not null,
	[weight] numeric(4,1),
	total_price numeric(4,0),
	dataofpayment datetime,
	foreign key (fruitid) references Fruit(fruitid),
	foreign key (customerid) references Customer(customerid)
);

create table production
(
	proid varchar(5) not null primary key,
	fruitid varchar(7) not null,
	farmerid varchar(7) not null,
	amount numeric(6,1),
	price_per_k numeric(4,1),
	productiondate datetime,
	foreign key (fruitid) references Fruit(fruitid),
	foreign key (farmerid) references Farmer(farmerid)
);
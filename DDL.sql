create table Person
(
	personid varchar(7) not null,
	firstname varchar(20),
	lastname varchar(35),
	date_of_birth datetime,
	email varchar(40),
);

create table Customer
(
	customerid varchar(7) not null,
	personid varchar(7) not null
);

create table Farmer
(
	farmerid varchar(7) not null,
	personid varchar(7) not null
);

create table Fruit
(
	fruitid varchar(7) not null,
	[name] varchar(20),
	size varchar(3),
	[weight] numeric(4,1),
	categoryid varchar(5) not null,
	weatherid varchar(5),
);

create table Category
(
	categoryid varchar(5) not null,
	[name] varchar(20)
);

create table [Type]
(
	cetegoryid varchar(5) not null,
	[name] varchar(20)
);

create table Weather
(
	weatherid varchar(5) not null,
	[name] varchar(30) 
);
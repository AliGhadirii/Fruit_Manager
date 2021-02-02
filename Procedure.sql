-- we have to call this procedure when some client wants to bye fruit
create or alter procedure buy @customerid int, @prodid int,@TOT_WEIGHT numeric(4,1)
as
begin
	begin tran buy;
	declare @temp_amount numeric(6,1);

	select @temp_amount = amount
	from production
	where proid=@prodid;

	if @temp_amount >= @TOT_WEIGHT
		update production
		set amount = amount - @TOT_WEIGHT
		where proid = @prodid;
	
	declare @cust_personid int;

	select @cust_personid=personid
	from Customer
	where customerid=@customerid;

	declare @cost numeric(6,1);
	
	select @cost=price_per_k 
	from production 
	where proid=@prodid;

	select @cost = @cost * @TOT_WEIGHT;

	update Person
	set Total_Balance = Total_Balance - @cost
	where personid = @cust_personid;

	declare @farm_personid int;

	select @farm_personid=personid
	from Farmer join production on Farmer.farmerid = production.farmerid
	where proid=@prodid;

	update Person
	set Total_Balance = Total_Balance + @cost
	where personid = @farm_personid;

	insert into buy_fruit(proid,customerid,[weight],dataofpayment)
	values (@prodid,@customerid,@TOT_WEIGHT,getdate());

	commit;
end;
go

--exec buy @customerid=1,@prodid=1,@TOT_WEIGHT=2;
----------------------------------------------------------------------
-- this procedure helps when we want to add new production
create or alter procedure produce @farmerid int, @fruitid int,@amount numeric(4,1),@price_k numeric(4,1)
as
begin
	begin tran prod;

	insert into production(fruitid,farmerid,amount,price_per_k)
	values(@fruitid,@farmerid,@amount,@price_k);

	commit;
end;
go

--exec produce @farmerid=1, @fruitid=2,@amount=800,@price_k=13;

----------------------------------------------------------------------
 --this procedure helps us to add a fruit easily
create or alter procedure addfruit @fname varchar(20), @cityname varchar(20),@categoryname varchar(20),@size varchar(3)
as
begin

	declare @fruit_city_id int;
	declare @fruit_category_id int;

	select @fruit_city_id=cityid
	from City
	where [name]=@cityname

	select @fruit_category_id=categoryid
	from Category
	where [name]=@categoryname

	begin tran prod;

	insert into fruit([name],size,categoryid,cityid)
	values(@fname,@size,@fruit_category_id,@fruit_city_id);

	commit;
end;
go

--exec addfruit @fname='Limon', @cityname='shiraz', @categoryname='fruit', @size='M';
--select * from fruit



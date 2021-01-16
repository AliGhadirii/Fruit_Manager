create trigger set_totalprice
on buy_fruit
after insert
as
begin
	declare @price_per_k int; 
	set @price_per_k = (select price_per_k from production where proid = (select proid from inserted))

	update buy_fruit
	set total_price = @price_per_k * (select [weight] from inserted)
	where paymentid = (select paymentid from inserted)

end
-------------------------------------------------------------------------------------------------------
create trigger fill_buy_log
on buy_fruit
after insert, delete, update
as
begin
	DECLARE @oper varchar(10)
	set @oper=
		case
			WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'Update'					
			WHEN EXISTS(SELECT * FROM inserted) THEN 'Insert'					
			WHEN EXISTS(SELECT * FROM deleted) THEN 'Delete'					
			else NULL
		end

	if @oper = 'Delete'
		insert into buy_fruit_log
		select d.*, 'delete' from deleted as d;

	if @oper = 'Update'
		insert into buy_fruit_log
		select d.*, 'Update' from inserted as d;

	if @oper = 'Insert'
		insert into buy_fruit_log
		select i.*, 'Inserted' from inserted as i;
end
-------------------------------------------------------------------------------------------------------
create trigger fill_production_log
on production
after insert, delete, update
as
begin
	DECLARE @oper varchar(10)
	set @oper=
		case
			WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'Update'					
			WHEN EXISTS(SELECT * FROM inserted) THEN 'Insert'					
			WHEN EXISTS(SELECT * FROM deleted) THEN 'Delete'					
			else NULL
		end

	if @oper = 'Delete'
		insert into production_log
		select d.*, 'delete' from deleted as d;

	if @oper = 'Update'
		insert into production_log
		select d.*, 'Update' from inserted as d;

	if @oper = 'Insert'
		insert into production_log
		select i.*, 'Inserted' from inserted as i;
end
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
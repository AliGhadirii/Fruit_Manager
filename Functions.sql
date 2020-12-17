--this function calculates the age of a person given personid
CREATE FUNCTION Age(@personid int)
RETURNS int
AS
BEGIN
DECLARE @ret int;
declare @temp datetime;
set @temp = (select date_of_birth from Person where personid = @personid)
set @ret = (CONVERT(int,CONVERT(char(8),getdate(),112))-CONVERT(char(8),@temp,112))/10000
IF (@ret IS NULL)
SET @ret = 0;
RETURN @ret;
END;
go
--------------------------------------------------------
--returns the log of purchases of a customer given customerid
CREATE FUNCTION purchases (@customerid int)
RETURNS TABLE
AS
RETURN
(
	select a.customerid, c.name, b.weight, b.total_price, b.dataofpayment
	from
		Customer a join buy_fruit as b on a.customerid = b.customerid
		join Fruit c on c.fruitid = b.fruitid
	where a.customerid = @customerid
);
GO
--------------------------------------------------------
--
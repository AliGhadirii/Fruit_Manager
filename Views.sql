create view customer_view as
	select
		a.customerid,
		b.name as fruit_name,
		c.name as city,
		d.name as category,
		a.weight,
		a.total_price,
		a.dataofpayment as purchase_date
	from 
		buy_fruit a join fruit b on a.fruitid=b.fruitid
		join city c on b.cityid=c.cityid
		join Category d on b.categoryid=d.categoryid;
---------------------------------------------------------
create view farmer_view as
	select 
		a.farmerid, 
		b.name as fruit_name,
		a.amount, 
		a.price_per_k,
		c.name as Category,
		d.name as City,
		a.productiondate
	from
		production a join Fruit b on a.fruitid=b.fruitid
		join Category c on c.categoryid=b.categoryid
		join City d on d.cityid = b.cityid
---------------------------------------------------------
create view manager_report_city_fruit as
	select
		case grouping(b.name)
			when 1 then 'All Fruits'
			else b.name
		end as fruit_name,

		case grouping(c.name)
			when 1 then 'All Category'
			else c.name
		end as Category,

		case grouping(d.name)
			when 1 then 'All City'
			else d.name
		end as City,
		count(a.fruitid) as [Count]
	from
		production a join Fruit b on a.fruitid=b.fruitid
		join Category c on c.categoryid=b.categoryid
		join City d on d.cityid = b.cityid
	group by cube(d.name,c.name,b.name)
---------------------------------------------------------
create view manager_report_weather_fruit as
	select
		case grouping(b.name)
			when 1 then 'All Fruits'
			else b.name
		end as fruit_name,

		case grouping(e.name)
			when 1 then 'All Category'
			else e.name
		end as Category,

		case grouping(d.name)
			when 1 then 'All Weather'
			else d.name
		end as Weather,
		count(a.fruitid) as [Count]
	from
		buy_fruit a join fruit b on a.fruitid=b.fruitid
		join city c on b.cityid=c.cityid
		join Weather d on d.weatherid=c.weatherid 
		join Category e on b.categoryid=e.categoryid
	group by cube(d.name,e.name,b.name)
---------------------------------------------------------
create view manager_report_size_fruit as
	with src as
	(
		select 
			a.fruitid,
			b.name,
			b.size
		from 
			buy_fruit a join Fruit b on a.fruitid = b.fruitid
	)
	select [name] as fruit_name, [S] as S, [M] as M, [L] as L
	from src
	pivot
	(
		count(fruitid)
		for size in ([S],[M],[L])
	) as pvt






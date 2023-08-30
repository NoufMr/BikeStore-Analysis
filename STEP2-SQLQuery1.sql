/*
--------------------------------------------------------------------
After create a datapase called BikeStores and 
creates the tables and insert to each table the value needded;
In this project in the SQL step, 
I wrote an SQL script that generated a dataset with fields consistent of:
Order ID, Customer's first and last name, Customer's city and state,
the order date,sales volume, revenue, product's name and category, store name and sales rep
These fields are scatterd across nearly 9 separate but 
related tables in the BikeStores database, 
so I performed a series of direct and indirect table joins to generate teh dataset
--------------------------------------------------------------------
*/


select 
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name) AS Customer,
	cus.city,
	cus.state,
	ord.order_date,
	SUM(ite.quantity) AS 'Total Units',
	SUM(ite.quantity * ite.list_price) AS 'Revenue',
	pro.product_name,
	cat.category_name,
	sto.store_name,
	CONCAT(sta.first_name,' ',sta.last_name) AS 'Sales Rep'
from sales.orders ord
join sales.customers cus
on ord.customer_id=cus.customer_id
join sales.order_items ite
on ord.order_id=ite.order_id
join production.products pro
on ite.product_id= pro.product_id
join production.categories cat
on pro.category_id=cat.category_id
join sales.stores sto
on ord.store_id=sto.store_id
join sales.staffs sta
on ord.staff_id=sta.staff_id
GROUP BY 
ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name,
	sto.store_name,
	CONCAT(sta.first_name,' ',sta.last_name)

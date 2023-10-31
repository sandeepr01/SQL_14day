 -----------		DAY 1	  -------------
use Employee
select*from empdata order by eeid
--Q.1  query to insert new record into the empdata table 
insert into empdata values('E00001','sandeep','manager','IT','Robotics','Male','Asian',
'22','2006-07-05','220000','0.1', 'India', 'jaipur',GETDATE())
 --Q2.  
 --2.1update column into empdata table
select*from empdata order by eeid
update empdata
set EEID='E00002' 
where Exit_date = 'Jul 25 2023  1:06AM'

--2.2 udpate name use eeid
update empdata
set fullname='raju' 
where eeid = 'E00002'
--2.3 update job title 
update empdata
set job_title='Sr. Maganger' 
where fullname='sandeep'
-- Q3. delete record into table
select*from empdata order by eeid
delete from empdata where hire_date<='2004-05-01'







------------		DAY 2		------------
-------filtring ans shorting data----------

use Employee
select*from empdata order by eeid 
--Q1 retrive all the column where department is it and age <49
select*from empdata where Department ='IT' and Age<49 order by eeid
--Q2 alphabetic order name
select*from empdata order by fullname
--Q3. USE Supply chain data
use supply_chain
select * from Car_SupplyChain
-- create a column then fill the column value by using other column value
alter table car_supplychain add order_yr varchar(10) null; 
update car_supplychain
set order_yr = year(orderdate);
-- Q3. total quantity sale by order yr (by using order_yr colun)
select order_yr,sum(Quantity) as total_qnt from Car_SupplyChain
group by order_yr order by total_qnt








------------		DAY 3		------------
---------		JOIN Command	----------
use Employee
select *from Data1
select*from Data2
--Q1. Write a query to retrieve full name, age and department from data1,
--	  data2 table to joining them?
select d1.fullname,d1.age,d2.department from Data1 as d1 inner join 
Data2 as d2 on(d1.EEID=d2.EEID)

--Q2. Write a query to retrieve the employee full name and salary from 
--	  data1 and data2 table and only include where salary is >1000000?
select d1.fullname,d2.Annual_Salary from Data1 as d1 inner join 
Data2 as d2 on(d1.EEID=d2.EEID)
where d2.Annual_Salary>200000








--------		DAY 4	-----------
-----		Agregating Data    -----
use sales
select*from sales_data_sample
--Q1. Write a SQL query to retrieve the avg price of product in each
--	  category from the 'Product' table?
select productline,PRODUCTCODE,avg(PRICEEACH) avg_price from sales_data_sample
group by productline,PRODUCTCODE order by avg_price

--Q2. Write a query to retrieve max salary of each department from employee data?
use Employee
select department, max(Annual_Salary) max_sal from empdata
group by Department order by max_sal

--Q3. Write a query to retrieve the total revanue genrated by each customer
--	  from sales data?
use sales
select CUSTOMERNAME,sum(SALES) total_revanue from sales_data_sample
group by CUSTOMERNAME order by total_revanue desc








---------		DAY 5    -----------
-------   Data Manipulation -------

--Q1. Write a sql query to update the quantity column of the product 
--	  table to 20 for all the product with a price greater then 90?
use sales
select*from sales_data_updated

update sales_data_updated
set QUANTITYORDERED = 20
where PRICEEACH>90
select ORDERNUMBER, QUANTITYORDERED, PRICEEACH from sales_data_updated  
order by ordernumber

--Q2. write a query to delete all the record of the customer where last login 
--    date is order then 1 year?
use sales

delete from sales_data_updated
where  CUSTOMERNAME not in (select distinct(CUSTOMERNAME) from sales_data_updated
where year_id=2005) 

--Q3. write a query to insert all new record into the temp_employee table selecting 
--	  data from employee table?

--ANS. First i create 2 temprarry table then save all records from employee table to 
----   this tebrarry table, then i devided records into two part using hire year.
--	   Now i insert data into temp1 table from temp2 table  
use Employee
select * into #temp_emptable1  from empdata
select * into #temp_emptable2  from empdata

delete from #temp_emptable1 where year(Hire_Date)>2019
delete from #temp_emptable2 where year(Hire_Date)<=2019

insert into #temp_emptable1 select * from #temp_emptable2 where year(Hire_Date)<=2020

--Q4. Write a query to update the discount column of the orders table by increasing it by 
--	  5% for all order placed before a specific date?
use employee

select sales, quantity,discount, profit,[Ship Date] as ship_date from odr 
where year([Ship Date])< 2016


select*from odr

update odr
set Discount= Discount+0.05
where year([Ship Date])<2016

select sales, quantity,discount, profit,[Ship Date] as ship_date from odr 
where year([Ship Date])< 2016






------------	    DAY 6    -----------
-------   Advance filtering and shorting   -----------

--Q1. Write a sql query to retrive all the customers whose name start with 'J' and 
--		city contain "York"?
use Employee
select * from empdata where fullname like 'J%' and city like '%Miami%'

--Q2. Write a sql query to retrive all the product with a price either above 
--    80 and below 85
use sales
select ORDERNUMBER,PRICEEACH from sales_data_sample where 
PRICEEACH between 80 and 85

--Q3. Write a sql query to retrive all the employee whose were hire in 
--	  btween specific date?
use Employee
select fullname, convert(date,Hire_Date)as hir_date from empdata 
where convert(date,Hire_Date) between '2014-01-01' and '2017-01-01'

--Q4. Write a sql query to retrive all the customer name who 
--	  do not have phone number in the dataset
use sales
select * from sales_data_sample where PHONE is  null







------------	    DAY 7    -----------
-------   Working with function   -----------

--Q1. Write a sql query to retrive all the length of the product name
--		from the product table?
use supply_chain
select SupplierID,CarModel,len(CarModel) as length from Car_SupplyChain

--Q2. query to retrive current date and time
select GETDATE()

--Q3. Write a query to retrive uppercase name of the employee from employee table
use Employee
select UPPER(fullname) from empdata

-- imp** Q4. Write a query to retrive avg price of the product after apllying a
--	  10% discount from the Product table?
use supply_chain
select CarPrice as old_price, CarPrice*0.90 after_10_discount from Car_SupplyChain









------------	    DAY 8    -----------
-------		     Subqueries			-----------

--Q1. write a sql query to retrive all the products with a price higher then
--	  average price of all products?
use supply_chain
select CarModel, CarPrice from Car_SupplyChain where  CarPrice> (select avg(CarPrice) from Car_SupplyChain) 

--Q2. write a sql query to retrive all the name of ll employee who have a salary
--	  higher then the maximum salary of the 'IT' department?
use Employee
select fullname,Annual_Salary,Job_Title from empdata 
where Annual_Salary > (select max(Annual_Salary) from empdata where Department = 'It')

--Q3. write a query to retrive all customer name who place a order after 
--	  latest order orderdate for a specific product?
use supply_chain
select CustomerName,CarModel as toyota_model from Car_SupplyChain where
OrderDate >'2019-02-13' and CarMaker = 'Toyota'

--Q4. write a sql query to retrive all the carmaker that belong to carmaker
--	  with more than 10 carmodel.
use supply_chain
with cte as
(select distinct(Carmodel) as car_modl,CarMaker from Car_SupplyChain )

select CarMaker , count(CarMaker) as total_car_model from cte 
group by CarMaker having count(CarMaker)>10
 








------------	     DAY 9        -----------
-----------	     Views and index	-----------
/*
Q1. Create a view name "high_salary_employee" that retrives all the employee
with a salary greater then 60000 from the "employee" table?
use Employee
*/

create view high_salary_employee as
select * from empdata where Annual_Salary>50000

select * from high_salary_employee
-- Total 70 row show in this result view

--Q2. Create a view name "Order_summary" that retrives all the total
--	  order amount and the number of order for each customer from the order table?
use sales 
create view Order_summary as
select CUSTOMERNAME,sum(QUANTITYORDERED) number_of_order,sum(sales) order_amount from sales_data_sample
group by CUSTOMERNAME

select * from Order_summary order by order_amount desc
/* After run this query we find total 92 row in this view 
	 there are top 3 row where highest order amount customers
	    Cutomername					    num_of_order			order_amount
	 1. Euro Shopping Channel		    7180					912294.110473633
	 2. Mini Gifts Distributors Ltd.	47761					654858.058105469
	 3. Australian Collectors, Co.		1432					200995.41015625
*/


--Q3. create an index on the "email" column of the customer table for faster searching?
use Music_database
create index email   -- Create Index 
on employee(email)			--- from emloyee table 


--Q4. Create a view name "product_inventory" that retrives the product name
--	  and the avilable quantity  for each product from the "products" and "inventory" tables?


------------	    DAY 10    -----------
/*						
PRACTICE QUESTIONS:
1. Create a table named "orders" with columns for order ID, customer ID, 
and order date, where the order ID is the primary key and the customer ID 
references the "customers" table.
*/


/*
2. Create a table named "products" with columns for product ID, name, and
price, where the product ID is the primary key and the price cannot be
null. 
*/

/*
3. Create a table named "categories" with columns for category ID and name, 
where the category ID is the primary key and the name must be unique.
*/


-------------------   Day 11   --------------------
------------------ Modifying Tables --------------------
/*
PRACTICE QUESTIONS:
1. Rename the table "customer_details" to "client_details".


2. Delete the "quantity" column from the "products" table.



3. Modify the "orders" table to change the data type of the "order_date" column to DATE.
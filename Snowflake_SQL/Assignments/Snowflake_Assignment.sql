
--1.Load the dataset with a primary key to order_date column

CREATE or replace TABLE sales1 (
	order_id VARCHAR(15) NOT NULL, 
	order_date VARCHAR(15) NOT NULL, 
	ship_date VARCHAR(15) NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 8) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	`year` DECIMAL(38, 0) NOT NULL,
  primary key(order_date)
);

select * from sales1;

show primary keys in sales1;

--2.Change the primary key to order_id column

ALTER TABLE sales1
DROP PRIMARY KEY;

ALTER TABLE sales1
ADD PRIMARY KEY (order_id);


show primary keys in sales1;
describe table sales1;

---3.Check the order date and ship date type and mention in which 
    ---data type it should be 


select * from sales1
  order by order_date,ship_date;
 show columns  in table sales1;   
  
 ---4.Create a new column called order_extract and extract the number after the last 
 ---   ‘–‘from Order ID column.
 
show columns  in table sales1;
ALTER TABLE sales1
ADD COLUMN order_extract varchar(15);

select order_id from sales1;

update  sales1
set order_extract = substr(order_id,9)

select order_id,order_extract from sales1;

--5. Create a new column called Discount Flag and categorize it based on discount. 
--Use ‘Yes’ if the discount is greater than zero else ‘No’.
ALTER TABLE sales1
ADD COLUMN Discount_Flag varchar(15);


select  discount,
     CASE 
     When discount > 0 then 'YES'
     Else 'FALSE'
     End as Discount_Flag
     from sales1;

---6. Create a new column called process days and calculate how many days it takes 
---for each order id to process from the order to its shipment
ALTER SESSION SET TIMESTAMP_INPUT_FORMAT = 'mm-DD-YYYY';
select order_id,order_date,ship_date,
datediff(day,order_date,ship_date)as
Process_days
from sales1;


--7. Create a new column called Rating and then based on the Process dates give 
--rating like given below.
--a. If process days less than or equal to 3days then rating should be 5
--b. If process days are greater than 3 and less than or equal to 6 then rating 
--should be 4
--c. If process days are greater than 6 and less than or equal to 10 then rating 
--should be 3
--d. If process days are greater than 10 then the rating should be 2

select order_id,order_date,ship_date,
datediff(day,order_date,ship_date)as
Process_days,
case
  when Process_days<=3 then 5
  when Process_days between 3 and 6 then 4
  when Process_days between 6 and 10 then 3
  else 2
  end as Rating
  from sales1;




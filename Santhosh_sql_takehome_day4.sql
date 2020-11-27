use orders;

-- 1.	Write a Query to display the  product id, product description and product  price of products  
-- whose product id  less than 1000 and that have the same price more than once.
-- (USE SUB-QUERY)(15 ROWS)[NOTE:PRODUCT TABLE]
 select product_id,product_desc,product_price from product 
 where product_id < 1000 and product_price in (
 select product_price from product 
 group by product_price 
 having count(product_price) > 1 );

-- 2.	Write a query to display product class description ,total quantity(sum(product_quantity),
-- Total value (product_quantity * product price) and show which class of products have been shipped highest to countries outside India other than USA? Also show the total value of those items.
 -- (1 ROWS)[NOTE:PRODUCT TABLE,ADDRESS TABLE,ONLINE_CUSTOMER TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT_CLASS TABLE]
select p.product_class_code ,sum(product_quantity) 'total quantity', sum(product_quantity*p.product_price) 'total value'
from product p join order_items oi 
on p.product_id=oi.product_id 
join order_header oh 
on oh.order_id=oi.order_id 
join online_customer oc 
on oc.customer_id = oh.customer_id 
join address a 
on oc.address_id = a.address_id 
where a.country not in ('India','USA') 
group by product_class_code 
order by 2 desc limit 1;

-- 3.	Write a query to display the customer id, customer first name, address line 2,city  total sales(sum(product quantity * product price (0 if they haven't purchased any item)) made by customers who stay in the same locality (i.e. same address_line2 & city). (USE SUB-QUERY)(4 ROWS)
-- [NOTE : ADDRESS,ONLINE_CUSTOMER,ORDER_HEADER,ORDER_ITEMS,PRODUCT]
select oc.customer_id, oc.customer_fname, a.address_line2, a.city, sum(oi.product_quantity * p.product_price) 'total sales'
from online_customer oc join address a
on oc.address_id = a.address_id 
join order_header oh 
on oc.customer_id=oh.customer_id
join order_items oi 
on oh.order_id=oi.order_id 
join product p
on oi.product_id=p.product_id;


-- 4.	Write a Query to display product id,product description,totalquantity(sum(product quantity) For a given item whose product id is 201 and which item has been bought along with it  maximum no. of times.
-- (USE SUB-QUERY)(1 ROW)[NOTE : ORDER_ITEMS TABLE,PRODUCT TABLE]
select p.product_id,p.product_desc, count(p.product_id) 'total quantity' 
from product p join order_items o 
on p.product_id=o.product_id 
where order_id in (
select order_id from order_items 
where product_id=201) 
group by p.product_id 
order by count(*) desc 
limit 1 offset 1; 

-- 5.	Write a Query to display the month,total quantity(sum(product quantity)) and show during which month of the year do foreign customers tend to buy max. no. of products.
-- (USE-SUB-QUERY)
-- (1ROW)[NOTE:ORDER_ITEMSTABLE,ORDER_HEADERTABLE,ONLINE_CUSTOMER TABLE,ADDRESS TABLE]
select month(oh.order_date) Month ,sum(ot.product_quantity) 'total quantity' 
from order_header oh join order_items ot
on oh.order_id=ot.order_id 
join online_customer oc
on oc.customer_id=oh.customer_id 
join address a
on a.address_id=oc.address_id 
where a.country in (
select country from address 
where country <> "India")
group by month(oh.order_date) 
order by sum(ot.product_quantity) desc limit 1 ;

-- 6.	Write a Query to display customer id,customer firstname,lastname,order status,total value(sum(product quantity * product price)) and show who is the most valued customer (customer who made the highest sales)
-- (1 ROW) [NOTE: ONLINE_CUSTOMER TABLE, ORDER_HEADER TABLE, ORDER_ITEMS TABLE, PRODUCT TABLE]
select oc.customer_id, oc.customer_fname,oc.customer_lname,oh.order_status,sum(ot.product_quantity * p.product_price) 'total sale' 
from online_customer oc join order_header oh 
on oh.customer_id=oc.customer_id
join order_items ot 
on oh.order_id=ot.order_id
join product p 
on ot.product_id=p.product_id 
group by oc.customer_id
order by sum(ot.product_quantity*p.product_price) desc 
limit 1; 
  
-- 7.	Write a query to display product class code,product class desc,product id product description,product price and show the most expensive products in their respective classes.
-- (16 ROWS)[NOTE : PRODUCT TABLE,PRODUCT CLASS TABLE]
select pc.product_class_code, pc.product_class_desc, p.product_id, p.product_desc, max(p.product_price) 
from product_class pc join product p 
on pc.product_class_code=p.product_class_code 
group by pc.product_class_code;

-- 8.	Write a query to display shipper id,shipper name , (len*width*height*product_quantity) as total volume shipped and show Which shipper has shipped highest volume of items.
-- (1 ROW) [NOTE : SHIPPER TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT TABLE]
select s.shipper_id, s.shipper_name, max(len*width*height*ot.product_quantity) 'total volume' 
from shipper s join order_header oh
on s.shipper_id= oh.shipper_id 
join order_items ot
on oh.order_id = ot.order_id 
join product p
on ot.product_id = p.product_id;

-- 9.	Write a query to display  carton id ,(len*width*height) as carton_vol and identify the optimum carton (carton with the least volume whose volume is greater than the total volume of all items) for a given order whose order id is 10006 , Assume all items of an order are packed into one single carton (box) .(1 ROW)[NOTE : CARTON TABLE]
select carton_id,min(len*width*height) 'carton vol'
from carton where (len*width*height)>(
select sum(len*width*height) 
from product p join order_items ot 
on p.product_id = ot.product_id 
where ot.order_id='10006' );

-- 10.	Write a query to display product id,product description,total_quantity (sum(order_quantity) Provided show the most and least sold products(quantity-wise).(3 ROWS)(USE:SUB-QUERY)
select p.product_id, p.product_desc, sum(ot.product_quantity) 'total quantity' 
from product p join order_items ot
on p.product_id = ot.product_id
group by ot.product_id 
having sum(ot.product_quantity)=(
select sum(ot.product_quantity) from order_items ot 
group by ot.product_id 
order by 1 limit 1)
or
sum(ot.product_quantity)=(
select sum(ot.product_quantity) 
from order_items ot 
group by ot.product_id 
order by 1 desc limit 1);
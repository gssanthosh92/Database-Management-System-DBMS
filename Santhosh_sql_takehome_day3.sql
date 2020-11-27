use orders;
show tables;
-- 1.	Write a query to Display the product details (product_class_code, product_id, product_desc, product_price,) as per the following criteria and sort them in descending order of category:
-- a.	If the category is 2050, increase the price by 2000
-- b.	If the category is 2051, increase the price by 500
-- c.	If the category is 2052, increase the price by 600.(60 ROWS)[NOTE:PRODUCT TABLE]
select product_class_code, product_id, product_desc, product_price,
case
when product_class_code=2050 then product_price+2000
when product_class_code=2051 then product_price+500
when product_class_code=2052 then product_price+600
end new_price
from product order by product_class_code desc; 

-- 2.	Write a Query to display the  the product description, product class description and product price of all products which are shipped.(168 rows)
-- [NOTE : TABLE TO BE USED:PRODUCT_CLASS,PRODUCT, ORDER_ITEMS,ORDER_HEADER]
select p.product_desc, pc.product_class_desc, p.product_price
from product p inner join product_class pc
on p.product_class_code=pc.product_class_code
inner join order_items oi
on p.product_id=oi.product_id
inner join order_header oh
on oi.order_id=oh.order_id
where oh.order_status = 'Shipped';

-- 3.	Write a query to display the  customer_id,customer name, email and order details (order id, product desc,product  qty, subtotal(product_quantity * product_price)) for all customers even if they have not ordered any item.(225 ROWS) 
-- [NOTE : TABLE TO BE USED - online_customer, order_header, order_items, product]
select oc.customer_id, concat(oc.customer_fname,' ',oc.customer_lname) customer_name, oc.customer_email, 
oh.order_id, p.product_desc, oi.product_quantity, (oi.product_quantity * p.product_price) 'subtotal'
from online_customer oc left join order_header oh
on oc.customer_id=oh.customer_id
left join order_items oi
on oh.order_id=oi.order_id
left join product p
on oi.product_id=p.product_id;

-- 4.	Write a query to display the customer_id,customer full name ,city,pincode,and order details (order id,order date, product class desc, product desc, subtotal(product_quantity * product_price)) 
-- for orders shipped to cities whose pin codes do not have any 0s in them. 
-- Sort the output on customer name, order date and subtotal.(52 ROWS) [NOTE : TABLE TO BE USED - online_customer, address, order_header, order_items, product, product_class]
select oc.customer_id, concat(oc.customer_fname,' ',oc.customer_lname) customer_name, a.city, a.pincode, 
oh.order_id, oh.order_date, pc.product_class_desc, p.product_desc, (oi.product_quantity * p.product_price) 'subtotal' 
from online_customer oc inner join address a
on oc.address_id=a.address_id
inner join order_header oh
on oc.customer_id=oh.customer_id
inner join order_items oi
on oh.order_id=oi.order_id
inner join product p
on oi.product_id=p.product_id
inner join product_class pc
on p.product_class_code=pc.product_class_code
where oh.order_status='Shipped' and a.pincode not like '%0%'
order by 2,6,9;

-- 5.	Write a query to display (customer id,customer fullname,city) of customers  
-- from outside ‘Karnataka’ who haven’t bought any toys or books.(19 ROWS)[NOTE : TABLES TO BE USED – online_customer, address, order_header, order_items, product, product_class].
select distinct oc.customer_id, concat(oc.customer_fname,' ',oc.customer_lname) customer_name, a.city
from online_customer oc inner join address a
on oc.address_id=a.address_id
inner join order_header oh
on oc.customer_id=oh.customer_id
inner join order_items oi
on oh.order_id=oi.order_id
inner join product p
on oi.product_id=p.product_id
inner join product_class pc
on p.product_class_code=pc.product_class_code
where a.state not like 'Karnataka' and pc.product_class_code not in (2051,2054)
group by oc.customer_id;

-- 6.	 Write a query to display  details (customer id,customer fullname,order id,product quantity) of customers who bought more than ten (i.e. total order qty) products per order.(11 ROWS)
-- [NOTE : TABLES TO BE USED - online_customer, order_header, order_items]
select oc.customer_id, concat(oc.customer_fname,' ',oc.customer_lname) customer_name, oh.order_id, sum(oi.product_quantity)
from online_customer oc join order_header oh
on oc.customer_id=oh.customer_id
join order_items oi
on oh.order_id=oi.order_id
group by oi.order_id
having sum(oi.product_quantity)>10;

-- 7.	Write a query to display the customer full name and total order value(product_quantity*product_price) of premium customers (i.e. the customers who bought items total worth > Rs. 1 lakh.)(2 ROWS)
-- [ NOTE : TABLES TO BE USED – ONLINE_CUSTOMER,ORDER_HEADER,ORDER_ITEMS,PRODUCT]
select concat(oc.customer_fname,' ',oc.customer_lname) customer_name, sum(oi.product_quantity * p.product_price) 'total order value'
from online_customer oc inner join order_header oh
on oc.customer_id=oh.customer_id
inner join order_items oi
on oh.order_id=oi.order_id
inner join product p
on oi.product_id=p.product_id
group by oh.customer_id
having sum(oi.product_quantity*p.product_price) >100000;

-- 8.	Write a query to display the customer id and cutomer full name of customers along with (product_quantity) as total quantity of products ordered for order ids > 10060.(6 ROWS)
-- [NOTE : TABLES TO BE USED - online_customer, order_header, order_items]
select distinct oc.customer_id, concat(oc.customer_fname,' ',oc.customer_lname) customer_name, oi.product_quantity 'total quantity'
from online_customer oc inner join order_header oh
on oc.customer_id=oh.customer_id
inner join order_items oi
on oh.order_id=oi.order_id
group by oh.order_id
having (oh.order_id>10060);

-- 9.	Write a query to display (product_class_desc, product_id, product_desc, product_quantity_avail ) and Show inventory status of products as below as per their available quantity:
-- a.	For Electronics and Computer categories, if available quantity is < 10, show 'Low stock', 11 < qty < 30, show 'In stock', > 31, show 'Enough stock'
-- b.	For Stationery and Clothes categories, if qty < 20, show 'Low stock', 21 < qty < 80, show 'In stock', > 81, show 'Enough stock'
-- c.	Rest of the categories, if qty < 15 – 'Low Stock', 16 < qty < 50 – 'In Stock', > 51 – 'Enough stock'
-- For all categories, if available quantity is 0, show 'Out of stock'.(60  ROWS)[NOTE : TABLES TO BE USED – product, product_class].
select pc.PRODUCT_CLASS_DESC, p.PRODUCT_ID, p.PRODUCT_DESC, p.PRODUCT_QUANTITY_AVAIL,
CASE WHEN pc.PRODUCT_CLASS_DESC IN ('Electronics' , 'Computer') THEN
CASE WHEN p.PRODUCT_QUANTITY_AVAIL < 10 THEN 'Low stock'
WHEN p.PRODUCT_QUANTITY_AVAIL BETWEEN 11 AND 30 THEN 'In Stock'
ELSE 'Enough stock'
END
WHEN pc.PRODUCT_CLASS_DESC IN ('Stationery' , 'Clothes') THEN
CASE WHEN p.PRODUCT_QUANTITY_AVAIL < 20 THEN 'Low stock'
WHEN p.PRODUCT_QUANTITY_AVAIL BETWEEN 16 AND 50 THEN 'In Stock'
ELSE 'Enough stock'
END
ELSE CASE WHEN p.PRODUCT_QUANTITY_AVAIL < 15 THEN 'Low stock'
WHEN p.PRODUCT_QUANTITY_AVAIL BETWEEN 21 AND 80 THEN 'In Stock'
ELSE 'Enough stock'
END
END inventory_status
FROM PRODUCT p JOIN product_class pc ON p.PRODUCT_CLASS_CODE = pc.PRODUCT_CLASS_CODE;


use dse;
select * from products;
-- cartesian product
select p.product_id,p.product_type_id,pt.name,p.name,p.description
from products p, product_types pt;

-- inner join 1
select p.product_id,p.product_type_id,pt.name,p.name,p.description
from products p, product_types pt
where p.product_type_id = pt.product_type_id;

-- inner join 2
select p.product_id,p.product_type_id,pt.name,p.name,p.description
from products p inner join product_types pt
on p.product_type_id = pt.product_type_id;

select * from purchases;
-- inner data into purchases
select p.product_id,p.name,pu.customer_id,pu.quantity
from products p, purchases pu
where p.product_id=pu.product_id;
select * from customers;
select pu.product_id,cu.customer_id,concat(cu.first_name,' ',cu.last_name) as 'customer_name',pu.quantity
from purchases pu, customers cu
where pu.customer_id=cu.customer_id;

select pu.product_id,p.name,cu.customer_id,concat(cu.first_name,' ',cu.last_name) as 'customer_name',pu.quantity
from purchases pu, customers cu,  products p
where pu.customer_id=cu.customer_id and p.product_id=pu.product_id;

select pu.product_id,p.name as 'product name',cu.customer_id,concat(cu.first_name,' ',cu.last_name) as 'customer name',pu.quantity
from products p inner join purchases pu
on p.product_id = pu.product_id
inner join customers cu
on pu.customer_id=cu.customer_id;

select pu.product_id,p.name as 'product name',pt.name as 'type',cu.customer_id,concat(cu.first_name,' ',cu.last_name) as 'customer name',pu.quantity
from products p inner join purchases pu
on p.product_id = pu.product_id
inner join customers cu
on pu.customer_id=cu.customer_id
inner join product_types pt
on p.product_type_id = pt.product_type_id;

select p.product_id,pt.product_type_id,pt.name as 'type',p.name as 'product name',p.description,p.price
from products p inner join product_types pt
on p.product_type_id = pt.product_type_id;

select p.product_id,pt.product_type_id,pt.name as 'type',p.name as 'product name',p.description,p.price
from products p left join product_types pt
on p.product_type_id = pt.product_type_id;

select p.product_id,pt.product_type_id,pt.name as 'type',p.name as 'product name',p.description,p.price
from products p right join product_types pt
on p.product_type_id = pt.product_type_id;

select p.product_id,pt.product_type_id,pt.name as 'type',p.name as 'product name',p.description,p.price
from products p left join product_types pt
on p.product_type_id = pt.product_type_id
union
select p.product_id,pt.product_type_id,pt.name as 'type',p.name as 'product name',p.description,p.price
from products p right join product_types pt
on p.product_type_id = pt.product_type_id;

select e.employee_id,concat(e.first_name,' ',e.last_name) as 'Employee Name', e.manager_id, concat(m.first_name,' ',m.last_name) as 'Manager Name' 
from employees e left join employees m
on e.manager_id=m.employee_id;

show tables;
update food set price=150 where id=1;
update food set price=60 where id in (6,8);
update food set price=200, name='Biriyani' where id=4;
delete from food where id=10;
alter table food add tax integer;
update food set tax=10;
alter table food drop tax;
alter table food modify name varchar(25);
rename table food to menu;
truncate table menu;
select * from menu;
drop table menu;

select * from products;
select product_id,name,price*3 'total price' from products;
select product_id,name,price,
case
when price<=12 then 'Price is low'
when price between 13 and 20 then 'Price is moderate'
when price between 21 and 30 then 'Price is high'
else 'Price is expensive'
end comments 
from products;
select * from products where price<15;
create view prod_vw as
select * from products where price<15;
show tables;
select * from prod_vw;
update prod_vw set price=25 where product_id=4;
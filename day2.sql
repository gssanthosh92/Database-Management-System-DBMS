show tables;
use dse;
 
select 'greatlakes' , ltrim('       Greatlakes'),rtrim('learning     '),trim('        mmms      '), trim('$' from "$123we") 
from dual;
select * from customers;
select first_name, lpad(first_name,7,'*') from customers;

select * from products;
select * from products where description like '%The%';
select name, substr(name,1,1) from products;
select name, substr(name,1,2) from products;
select name, substr(name,1,1), substr(name,1,2), substr(name,3,2), substr(name,-1) from products;
select name, replace(name,'o','O') from products;
select name, substr(name,5) from products;
select name, substr(lower(name),1) from products;
select name, replace(name,substr(name,1,1), lower(substr(name,1,1))) from products;
select name, replace(name,substr(name,3,2), upper(substr(name,3,2))) from products;
select name, instr(name,'s') from products;
select ascii('A') from dual;
select 5+3, 5-3, 5*3, 5/3, 5 mod 3, 5 div 3 from dual;
select ceil(35.6), ceil(35.00000001),floor(35.6), floor(35.9999) from dual;
select abs(50), abs(-23), sign(100), sign(-1382), sign(00) from dual;
select round(45.85501,2), round(45.55,-1) from dual;
select truncate(45.85501,2), truncate(45.55,-1) from dual;
select power(2,3), sqrt(121) from dual;
select curdate();
select current_date();
select curtime();
select current_time();
select current_timestamp();

select datediff(curdate(),'2018-03-13') from dual;
select floor(datediff(curdate(),'2000-01-01')/365) from dual;
select date_add(curdate(), interval 10 DAY) from dual;
select adddate(curdate(), interval 10 month) from dual;
select last_day(curdate());
select dayofweek(curdate()), dayname(curdate());
select year(curdate());
select 375 div 200 as '200s',(375 mod 200) div 100 as '100s', ((375 mod 200) mod 100) div 50 as '50s', (((375 mod 200) mod 100) mod 50) div 10 as '10s', 
((((375 mod 200) mod 100) mod 50) mod 10) div 5 as '5s' from dual;
select min(price), max(price), sum(price), count(price), avg(price) from products;
select min(price), max(price), sum(price), count(price), avg(price) from products where product_id>6;
select min(price), max(price), sum(price), count(price), avg(price) from products where price>=15;
select product_type_id, min(price) from products group by product_type_id ;
select product_type_id, min(price) from products where product_type_id is not null group by product_type_id ;
select product_type_id, min(price) from products 
where product_type_id is not null 
group by product_type_id 
having min(price)>13;
select * from products 
order by price desc 
limit 2;
-- for getting top 2 only
select * from products 
order by price desc 
limit 1 offset 1;
-- for getting 2nd highest selling product
select * from products
group by product_type_id;
select * from products where name between 'Chemistry' and 'Pop 3';
-- commit the transaction
COMMIT;
select prd_id,prd_type_id, name from more_products;
select product_id, product_type_id, name from products
union
select prd_id,prd_type_id, name from more_products
order by 1,3 desc;
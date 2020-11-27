use dse;
select * from product_types;
select * from product_types where name='Book';
select product_type_id from product_types where name='Book';
select * from products where product_type_id=(select product_type_id from product_types where name='Book');
select * from products where product_type_id=(select product_type_id from product_types where name='Magazine');
select * from products where product_type_id in (select product_type_id from product_types where name like '%d');
select avg(price) from products;
select * from products having price>= (select avg(price) from products);
select max(price) from products where product_type_id=3;
select product_type_id,avg(price) from products group by product_type_id having avg(price)>(select max(price) from products where product_type_id=3);

select product_type_id,min(price) from products group by product_type_id;
select * from products where (product_type_id,price) in (select product_type_id,min(price) from products group by product_type_id);

select avg(price) from products group by product_type_id;
select * from products where price>(select avg(price) from products group by product_type_id);
select * from products;

select * from products o  
where price>(select avg(price) from products where product_type_id=o.product_type_id);

select sum(price) from products where price in (select price from products where product_type_id=1);
select name, price from products where name like 'c%';

select product_type_id from product_types where name='Book';
select product_id from products where product_type_id=
(select product_type_id from product_types where name='Book');
select * from purchases where product_id in
(select product_id from products where product_type_id=
(select product_type_id from product_types where name='Book'));
select * from overtime;
select employee_name, hours, FIRST_VALUE(employee_name) over (order by hours) least_over_time from overtime;
SELECT employee_name, department, hours, FIRST_VALUE(employee_name) OVER (PARTITION BY department ORDER BY hours) least_over_time FROM overtime;
SELECT employee_name, department, hours, LAST_VALUE(employee_name) OVER (PARTITION BY department ORDER BY hours) HIGHEST_over_time FROM overtime;
select * from t;
SELECT val, RANK() OVER (ORDER BY val) my_rank FROM t;
SELECT val, DENSE_RANK() OVER (ORDER BY val) my_DENSE_rank FROM t;
SELECT val, ROW_NUMBER() OVER (ORDER BY val) my_ROW_NUM FROM t;
SELECT val, RANK() OVER (ORDER BY val) my_rank,DENSE_RANK() OVER (ORDER BY val) my_DENSE_rank,ROW_NUMBER() OVER (ORDER BY val) my_ROW_NUM FROM t;
SELECT employee_name, salary, NTH_VALUE(employee_name, 2) OVER  (ORDER BY salary DESC) second_highest_salary FROM basic_pays;
SELECT val, NTILE(4) OVER (ORDER BY val) bucket_no FROM t;
select product_type_id, sum(price) from products group by product_type_id with rollup;
use dse;
select distinct nth_value(employee_name, 4) over (order by salary desc) from basic_pays;
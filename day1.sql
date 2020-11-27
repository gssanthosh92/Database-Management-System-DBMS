create database dse;
use dse;

create table emp(
eid integer,
ename varchar(20),
salary integer
);

select * from emp;
insert into emp values (1,'Sam',25000);
insert into emp values (2,'Bill Gates',5000);
insert into emp values (3,'Ashwath',40000);
insert into emp values (4,'Shintu',40);
insert into emp values (5,'Pavitran',10);
insert into emp values (11,'Vignesh',5);
insert into emp values (20,'Krishnan',2500);
insert into emp values (40,'Prasad',10000);
insert into emp values (48,'Srinath',20000);
insert into emp values (88,'Raghuram',14000);
insert into emp values (89,'Raj',5500);

select * from emp;
select eid,ename,salary from emp;
select * from emp where eid = 20;
select * from emp where ename = 'Raj';
select * from emp where eid = 20 and 40;
select * from emp where eid = 20 or eid = 40;
select * from emp where eid = 20 or eid = 40 or eid = 48;
select * from emp where eid in (20,40,48,88,89);
select * from emp where ename in ('krishnan','prasad');

select * from emp where salary = 5000;
select * from emp where salary > 5000;
select * from emp where salary < 5000;
select * from emp where salary <> 25000;
select * from emp where salary >= 5000;
select * from emp where salary <= 5000;
select * from emp where salary <= 20000 and salary >=5000;
select * from emp where salary between 5000 and 20000;
-- between, both starting and ending values included

select * from emp where ename like 'R%';
select * from emp where ename like 'R__';
select * from emp where ename like '_a%';
select * from emp where ename like '_a_';
select * from emp where ename like '_a%';
select * from emp where length(ename) = 7;

select ename, length(ename) from emp;
select eid, ename from emp;
select eid, ename as Employee_Name from emp;
select eid as 'Employee ID', ename as 'Employee Name' from emp;
select eid 'Employee ID', ename 'Employee Name' from emp;
select salary, length(salary) from emp where length(salary)=5;
select distinct salary from emp;
select * from emp order by salary;
-- 'asc' is default, give 'desc' specifically for descending order
select * from emp order by salary desc;

select * from emp;
show tables;
describe emp;
select * from emp where lower(ename) = 'raj';
select ename, lower(ename), upper(ename), ucase(ename) from emp;

select * from customers;
select * from customers where first_name like '%ee%' or last_name like '%ee%';
select * from customers where last_name like '%b%';
select * from customers where first_name not like '%a%';
select * from customers where last_name like 'Bl%';
select * from customers where last_name like '%e_';
select * from customers where phone like '%12';
select * from customers where phone like '%12%';
select * from customers where dob is null;
select customer_id,concat(first_name,' ', last_name) 'Customer_Name' from customers;
select concat('Customer ',first_name,' ', last_name,' with customer ID ',customer_id,
' was born on ',ifnull(dob,'1900-01-01'),". Customer's phone number is ",ifnull(phone,0)) 'Certificate' from customers;
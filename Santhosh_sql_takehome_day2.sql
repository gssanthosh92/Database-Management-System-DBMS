use HR;
use orders;

show tables;
-- 1.	List all IT related departments where there are no managers .(2 rows)[NOTE:DEPARTMENT TABLE]
select * from departments where department_name like'IT%' and manager_id is null;

-- 2.	Print a bonafide certificate for an employee (say for emp. id 123) as below:
-- #"This is to certify that <full name> with employee id <emp. id> is working as <job id> in dept. <dept ID>. (1 ROW)[NOTE : EMPLOYEES table].
select concat('This is to certify that ',first_name,' ',last_name,' with employee id ',employee_id,' is working as ',job_id,' in dept.',department_id) as 'Certificate' from employees where employee_id=123;

-- 3.	Write a  query to display the  employee id, salary & salary range of employees as 'Tier1', 'Tier2' or 'Tier3' as per the range <5000, 5000-10000, >10000 respectively,ordering the output by those tiers.(107 ROWS)[NOTE :EMPLOYEES TABLE]
select  employee_id, salary, 'Tier1' salary_range from employees where salary<5000
union all
select  employee_id, salary, 'Tier2' salary_range from employees where salary between 5000 and 10000
union all
select  employee_id, salary, 'Tier3' salary_range from employees where salary>10000
order by 3;

-- 4.	Write a query to display the department-wise and job-id-wise total salaries of employees whose salary is more than 25000.(8 rows) [NOTE : EMPLOYEES TABLE]
select department_id,job_id,sum(salary) from employees group by department_id,job_id having sum(salary)>25000;

-- 5.	Write a query to display names of employees whose first name as well as last name ends with vowels.  (vowels : aeiou )(5 rows) [NOTE : EMPLOYEES TABLE]
select first_name, last_name from employees where substr(first_name,-1,1) in ('a','e','i','o','u') and substr(last_name,-1,1) in ('a','e','i','o','u');
select first_name, last_name from employees where first_name regexp '[aeiou]$' and last_name regexp '[aeiou]$'; 

-- 6.	What is the average salary range (diff. between min & max salary) of all types 'Manager's and 'Clerk's.(2 rows)[NOTE : JOBS TABLE]
select avg(max_salary-min_salary) as 'Average' from jobs where job_title like '%manager'
union
select avg(max_salary-min_salary) as 'Average' from jobs where job_title like '%clerk';

-- 7.    Show location id and cities of US or UK whose city name starts from 'S' but not from 'South'.(2 rows)[NOTE : LOCATION TABLE]
select location_id,city from locations where country_id in ('US','UK') and city like 'S%' and city not like 'South%';
    
-- 8.    Write a query to display the all the records of customers whose creation date is before ’12-Jan-2006’ and email address contains ‘gmail’ or ‘yahoo’ and user name starts with ‘dave’.(2 ROWS)[NOTE : ONLINE_CUSTOMER TABLE]
select * from online_customer where CUSTOMER_CREATION_DATE < '2006-01-12' and CUSTOMER_EMAIL like '%gmail.com';

-- 9.    Write query to display the product id,product_description and total worth(product_price * product_quantity available) of each product.(60 rows)[NOTE : PRODUCT TABLE]
select PRODUCT_ID,PRODUCT_DESC,PRODUCT_QUANTITY_AVAIL*PRODUCT_PRICE as 'total worth' from product;

-- 10.	Write a query to Display details of customer who have Gmail account and phone number consist of ‘77’ as below:
 -- <Customer full name> (<customer user name>) created on <date>. Contact Phone: <Phone no.> E-mail: <E-mail id>.(6 rows)[NOTE : ONLINE_CUSTOMER TABLE]
select concat(CUSTOMER_FNAME,' ',CUSTOMER_LNAME,' with username- ' ,CUSTOMER_USERNAME,' was created on ',CUSTOMER_CREATION_DATE,'. Contact Phone:',' ',CUSTOMER_PHONE,
', E-mail id: ',CUSTOMER_EMAIL) as 'Display' from ONLINE_CUSTOMER where CUSTOMER_EMAIL like '%gmail%' and CUSTOMER_PHONE like '%77%';

-- 11.	Write a query to Show the count of cities in all countries other than US & UK, with more than 1 city, in the descending  order of country id. (4 rows)[NOTE : LOCATION TABLE]
select country_id,count(city) from locations where country_id not in ('US','UK') group by  country_id having count(city)>1 order by country_id desc;
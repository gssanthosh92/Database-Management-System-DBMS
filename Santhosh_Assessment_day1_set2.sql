use hr;
-- 1.	Fetch details of departments in which the maximum salary is more than 10000. (6 rows)
select * from employees
join departments using (department_id)
group by department_id
having max(salary)>10000;

select * from departments where department_id in (
select department_id from employees 
group by department_id 
having max(salary)>10000);
 
 select d.* from employees e
 join departments d 
 on e.department_id=d.department_id
 group by d.department_id
 having max(e.salary)>10000;
 
-- 2.	Fetch the name of the city of the employees whose ID's are 130 and 150.
select employee_id, first_name, last_name, city from employees 
join departments using (department_id)
join locations using (location_id)
where employee_id in (130,150);

select city from locations where location_id in (
select location_id from departments where department_id in (
select department_id from employees where employee_id in (130,150)));

-- 3.	Fetch all the details of employees working in US / UK (103 rows)
select * from employees
join departments using (department_id)
join locations using (location_id)
where country_id in ('US','UK');

select * from employees where department_id in (
select department_id from departments where location_id in (
select location_id from locations where country_id in ('US','UK')));

-- 4.	Fetch all the details of employees working in Canada (2 rows)
select * from employees 
join departments using (department_id)
join locations using (location_id)
join countries using (country_id)
where country_name='Canada';

select * from employees where department_id in (
select department_id from departments where location_id in (
select location_id from locations where country_id =(
select country_id from countries where country_name='Canada')));

-- 5.	Fetch details of departments managed by John / Alexander (2 rows)
select e.department_id, department_name  from employees e
join departments using (department_id)
join employees m on e.manager_id=m.employee_id
where m.first_name in ('John','Alexander')
group by department_id;

select d.* from departments d join employees e 
on d.manager_id=e.employee_id
where e.first_name regexp 'John|Alexander';

select * from departments where manager_id in (
select employee_id from employees where first_name regexp 'John|Alexander');

-- 6.	Fetch records of all employees whose salary is more than the overall average salary (51 rows)
select * from employees where salary>(
select avg(salary) from employees);

-- 7.	Fetch all records of employees whose salary is greater than the average salary of a sales rep (job_id = SA_Rep) (30 rows)
select * from employees where salary>(
select avg(salary) from employees where job_id='SA_Rep');

-- 8.	Fetch a report all managers who manage more than 3 employees (15 rows)
select concat(m.first_name,' ',m.last_name) 'manager_name' 
from employees e join employees m 
on e.manager_id=m.employee_id
group by m.first_name
having count(e.employee_id)>3;

select concat(first_name,' ',last_name) 'manager_with_more_than_3_employees' from employees where employee_id in (
select manager_id from employees group by manager_id having count(manager_id)>3); 
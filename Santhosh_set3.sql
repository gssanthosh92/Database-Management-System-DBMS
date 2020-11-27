use hr;
select employees.*, salary*1.17 as'inc_sal' from employees where job_id='SA_REP' and (salary*1.17)>10000;
select * from (select employees.*, salary*1.17 as'inc_sal' from employees where job_id='SA_REP') as temp where temp.inc_sal>10000;

-- 1.	Select all the employees who joined the organization on the 3rd of every month. (17 rows)
select * from employees where date_format(hire_date,'%d')=03;

-- 2.	Fetch all the years in which more than 5 employees joined the organization. 
select date_format(hire_date,'%Y') 'Year', count(employee_id) from employees group by date_format(hire_date,'%Y') having count(employee_id)>5;

-- 3.	Fetch the total number of employees working in Canada. (2)
select count(*) from employees 
join departments using (department_id)
join locations using (location_id)
join countries using (country_id)
where country_name='Canada';

select count(*) from employees where department_id in (
select department_id from departments where location_id in (
select location_id from locations where country_id =(
select country_id from countries where country_name='Canada')));

-- 4.	Fetch the names of countries having less than 10 employees. (3 rows)
select country_name from employees 
join departments using (department_id)
join locations using (location_id)
join countries using (country_id)
group by country_name having count(employee_id)<10;

-- 5.	Fetch the total number of employees in each department (Department name, total number of employees) without joins. (27 rows)
select department_name from departments where department_id in (select department_id from employees group by department_id ); 
select department_name, (select count(employee_id) from employees where department_id=d.department_id) as 'no. of employees' from departments d;
select department_name, count from departments where 
(select department_id, count(employee_id) from employees group by department_id);

-- 6.	Fetch a report of all employees who has the most experience in a department (assuming they having changed departments since their hiring) (12 rows)
select * from employees group by department_id having min(hire_date);
select department_id, max(datediff(curdate(),hire_date)) from employees group by department_id;
select * from employees e where hire_date=(
select min(hire_date) from employees where department_id=e.department_id);

-- 7.	Fetch details of all employees earning more than their department average salary (38 rows).
select * from employees e where salary>(select avg(salary) from employees where department_id=e.department_id);

-- 8.	Fetch a report of all employees’ names, ids, department name, salary and department average salary.
select employee_id, first_name, (select avg(salary) from employees where department_id=e.department_id) as 'avg_salary',
(select department_name from departments where department_id=e.department_id) as 'dept_name',
salary, avg(salary) over (partition by department_id) as 'avg_dept_salary' from employees e;

select *,avg(salary) over (partition by department_id) as 'avg_salary' from employees;
select employee_id, first_name, 
(select department_name from departments where department_id=e.department_id) as 'dept_name',
salary, avg(salary) over (partition by department_id) as 'avg_dept_salary' from employees e;

-- 9.	Fetch a report of all employees (emp id, name & salary) along with the difference of their salary from their department’s average salary. Please group this data department-wise and sort the data in order of the salary difference	.
select employee_id,first_name,salary,
(salary-(select avg(salary) from employees where department_id=e.department_id)) as 'salary_diff' 
from employees e
order by 4;

-- 10.	Fetch a report of all employees (emp_id,names, salary) who earn more than 3000 along with the total number of all employees earning more than 3000. (64 rows)
select employee_id, first_name, salary, (
select count(employee_id) from employees where salary>3000) 'total_emp' 
from employees where salary>3000;

select employee_id, first_name, salary, count(*) over() as total from employees where salary>3000;

-- 11.	For each employee in department 80, fetch a report of their names, id, department name, salary,
-- max salary in their department, difference between the max salary and their salary. (34 rows)
select first_name, employee_id,
(select department_name from departments where department_id=e.department_id) as 'dept_name',
salary, (select max(salary) from employees where department_id=e.department_id) as 'max_salary',
((select max(salary) from employees where department_id=e.department_id)-salary) as 'salary_diff' 
from employees e
where department_id=80;

select first_name, employee_id, department_name, salary, 
max(salary) over(partition by department_id) as 'max_sal',
max(salary) over(partition by department_id)-salary as 'diff'
from employees join departments using (department_id) where department_id=80;

-- 12.	Show the employee id, his/her joining date and the number of employees that were hired on the same date
select employee_id, hire_date, 
(select count(employee_id) from employees where hire_date=e.hire_date) as 'no. of emp. hired on this date'
from employees e;


select *, count(*) over(partition by hire_date) count_emp from employees;
select * from 
(select *, count(*) over(partition by hire_date) count_emp from employees) as T 
where T.count_emp>1;

-- 13.	Sort the data by department_id and fetch the even records (2nd, 4th , 6th …..) (53 rows)
select * from employees where employee_id in (
select employee_id from employees where employee_id%2 = 1) order by department_id;

select * from (
select *,row_number() OVER (ORDER BY department_id desc) as row_no 
from employees) as temp where temp.row_no%2=0;

select *, row_number() over (order by department_id) as rn from employees;

-- 14.	Find the 3rd and 4th highest salary earned by an employee
select salary from (
select employee_id, salary, dense_rank() over (order by salary desc) my_rank 
from employees) as temp 
where temp.my_rank in (3,4) ;

-- 15.	Find the 25th – 30th highest salaries earned by an employee (6 rows)
select distinct salary from (
select employee_id, salary, dense_rank() over (order by salary desc) as my_rank 
from employees) as temp 
where my_rank between 25 and 30;

-- 16.	Display the name, department_id and salary of employees earning the 2nd highest salary in each department.  (9 rows)
select first_name,department_id,salary from (
select first_name,department_id,salary,rank() over (partition by department_id ORDER BY salary desc) as my_rank 
from employees) as temp where temp.my_rank=2;


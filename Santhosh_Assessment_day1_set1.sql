use hr;
show tables;
-- 1.	Fetch all the names and joining dates of employees reporting to manager whose manager id is 100 and display the date in this format - “January, 21, 1991” (14 rows)
select first_name,last_name,date_format(hire_date,'%M %d, %Y') 'joining_date' from employees where manager_id=100;

-- 2.	Fetch the records of all employees working as a sales rep (Job_id = SA_REP) whose salary would be greater than 10,000 after an increment of 17% (14 rows)
select * from employees where job_id='SA_REP' and (salary*1.17)>10000;


-- 3.	Fetch all the records of employees who joined the organization after the month of April in the 1997 (16 rows)
select * from employees where hire_date>'1997-04-30' and hire_date<'1997-12-31';
select * from employees where date_format(hire_date,'%m')>04 and date_format(hire_date,'%y')=97;
select * from employees where month(hire_date)>04 and year(hire_date)=1997;

-- 4.	Fetch the length of first name of all employees whose last name ends with a or z. (7 rows)
select first_name, length(first_name) from employees where last_name regexp '[az]$';

-- 5.	Fetch records of employee names beginning with ae or ending with ly. (2 rows)
select * from employees where first_name regexp '^ae|ly$'; 
 
-- 6.	Fetch records of employee names beginning and ending with a vowel (26 rows)
select * from employees where first_name regexp '^[aeiou]' or last_name regexp '[aeiou]$'; 

-- 7.	Display the unique departments in employees table along with the total number of employees in each department in the order of maximum employees.
select department_id, count(employee_id) from employees group by department_id order by 2 desc; 

-- 8.	Fetch all departments having more than 10 employees. (3 rows)
select department_id from employees group by department_id having count(employee_id)>10;

-- 9.	Fetch a report of all employees who joined before their respective managers. (30 rows)
select * from employees e join employees m 
on m.manager_id=e.employee_id 
where m.hire_date<e.hire_date;

-- 10.	Display a report of employee name, hiring date, current job of all employees who were hired after 1999. (30 rows)
select first_name,last_name,hire_date, job_id
from employees where hire_date>'1998-12-31' ;

-- 11.	Display a report of employee_id, employee name, city and manager name of all employees  

select e.employee_id, e.first_name, e.last_name, l.city
from employees e left join departments d 
on e.department_id=d.department_id
left join locations l 
on d.location_id=l.location_id;

select e.employee_id, e.first_name, e.last_name, city, concat(m.first_name,' ', m.last_name) 'manager_name' from employees e
left join departments using (department_id)
left join locations using (location_id)
left join employees m on e.manager_id=m.employee_id;


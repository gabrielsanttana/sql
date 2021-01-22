-- How many people were hired on any given hire date?
select count(emp_no) as "amount"
from employees
group by hire_date
order by "amount" desc;

-- Show me all the employees, hired after 1991 and count the amount of positions they've had
select e.*, count(t.title)
from employees e
inner join title t
using(emp_no)
where extract(year from hire_date) > 1991
group by e.emp_no
order by e.emp_no;

-- Show me all the employees that work in the department development and the from and to date
select e.*
from employees e
inner join dept_emp de
using(emp_no)
inner join department dp 
using(dept_no)
where dp.dept_no = 'd005'
group by e.emp_no, de.from_date, de.to_date
order by e.emp_no, de.to_date;
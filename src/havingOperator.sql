-- Show me all the employees, hired after 1991, that have had more than 2 titles
select e.emp_no, count(t.title) as "Amount of titles"
from employees e
inner join titles t
using(emp_no)
where extract(year from e.hire_date) > 1991;
group by e.emp_no
having count(t.title) > 2;

-- Show me all the employees that have had more than 15 salary changes that work in the department development
select e.emp_no, count(s.from_date) as "Amount of raises"
from employees e
inner join salaries s
using(emp_no)
inner join dept_emp de
using(emp_no)
where de.dept_no = 'd005'
group by e.emp_no
having count(s.from_date) > 15
order by emp_no;


-- Show me all the employees that have worked for multiple departments
select e.emp_no, count(de.from_date) as "Amount of departments"
from employees e
inner join dept_emp de
using(emp_no)
group by emp_no
having count(de.dept_no) > 1;
order by emp_no;

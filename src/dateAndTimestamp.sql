-- Get me all the employees above 60, use the appropriate date functions
select age(birth_date), *
from employees
where extract(year from age(birth_date)) > 60;

-- alternative
select count(birth_date)
from employees
where birth_date < now() - interval '61 years'; -- 61 years before the current date

-- How many employees where hired in February?
select count(emp_no)
from employees
where extract(month from hire_date) = 2;

-- How many employees were born in november?
select count(emp_no)
from employees
where extract(month from birth_date) = 11;

-- Who is the oldest employee?
select max(age(birth_date))
from employees;

-- How many orders were made in January 2004?
select count(id)
from orders
where date_trunc('month', order_date) = '2004-01-01';

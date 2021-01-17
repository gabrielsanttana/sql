-- Find the age of all employees who's name starts with M
select first_name, extract(year from age(birth_date)) as "age"
from employees
where name like 'M%';

-- How many people's name start with A and end with R?
select count(emp_no)
from employees
where name like 'A%R';

-- How many people's zipcode have a 2 in it?
select count(customerId)
from customers
where zip::text like '%2%';

-- How many people's zipcode start with 2 with the 3rd character being a 1
select count(customerId)
from customers
where zip::text like '2_1';

-- Which states have phone numbers starting with 302?
select coalesce(state, 'No State') as "State"
from customers
where phone_number::text like '302%';

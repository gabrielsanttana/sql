-- Female customers count from the Oregon or New York state
select count(*) from customers c 
where (state = 'OR' or state = 'NY')
and gender = 'F';

-- Customers that aren't 55
select count(*) from customers c 
where not age = 55;

-- Female customers count from the Oregon
select count(*) from customers c 
where gender = 'F'
and state = 'OR';

-- People that are 44 with 100000 or more of income
select * from customers c 
where age = 44
and income >= 100000;

-- People that are between 30 and 50 with less than 50000 of income
select * from customers c 
where age >= 30 and age <= 50
and income < 50000;

-- Average income between the ages of 20 and 50 (excluding ages 20 and 50)
select avg(income) from customers c 
where age > 20 and age < 50;

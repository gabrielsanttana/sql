-- Who between the ages of 30 and 50 has an income less than 50000?
select name as 'Name'
from customers
where (age between 30 and 50) and (income < 50000);

-- What is the average income between the ages of 20 and 50? (including 20 and 50)
select avg(income)
from customers
where age between 20 and 50;
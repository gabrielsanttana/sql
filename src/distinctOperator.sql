-- What unique titles do we have?
select distinct title
from titles;

-- How many unique birth dates are there?
select count(distinct birth_date)
from employees;

-- Can I get a list of distinct life expectancy ages?
select distinct life_expectancy
from country
where life_expectancy is not null
order by life_expectancy;
-- Average salary of the company:
select avg(salary)
from salaries s;

-- Youngest person in the company:
select max(birth_date)
from employees e;

-- Number of towns in Frace
select count(id)
from towns;

-- Number of official languages in the world
select count(countrycode)
from countrylanguage c
where isofficial = true;

-- Average life expectancy in the world:
select avg(lifeexpectancy)
from country c;

-- Average population for cities in the Netherlands:
select avg(population)
from city c 
where countrycode = 'NLD';

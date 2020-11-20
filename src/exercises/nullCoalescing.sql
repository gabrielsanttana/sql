-- Assuming a students minimum age for the class is 15, what is the average age of a student?
select avg(coalesce(age, 15))
from students;

-- Replace all empty first or last names with a default
select coalesce(firstName, 'No provided first name'), coalesce(lastName, 'No provided last name')
from person;
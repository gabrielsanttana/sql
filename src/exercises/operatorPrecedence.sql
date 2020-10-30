/* People either under 30 or over 50 with an income above 50000
that are from either Japan or Australia including people that are 50 */

select *
from customers c 
where income > 50000 and (age < 30 or age >= 50)
and (country = 'Japan' or country = 'Australia');

-- What was our total sales in June of 2004 for orders over 100 dollars?

select sum(totalamount)
from orders o
where (orderdate >= '2004-06-1' and orderdate < '2004-06-30')
and totalamount > 100;
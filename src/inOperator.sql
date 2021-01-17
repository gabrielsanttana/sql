-- How many orders were made by customer 7888, 1082, 12808, 9623
select count(id)
from order
where customer_id in (7888, 1082, 12808, 9623);

-- How many cities are in the district of Zuid-Holland, Noord-Brabant and Utrecht?
select count(id)
from city 
where district in ('Zuid-Holland', 'Noord-Brabant', 'Utrecht');

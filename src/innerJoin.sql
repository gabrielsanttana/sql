-- Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state * ordered by orderid
select *
from orders o 
inner join customers c
on o.customerid = c.customerid
where c.state in ('OH', 'NY', 'OR')
order by o.orderid;

-- Show me the inventory for each product
select p.*, i.*
from products p
inner join inventory i
on p.prod_id = i.prod_id;

-- Show me for each employee which department they work in
select e.*, d.*
from employees e
inner join dept_emp de
on e.emp_no = de.emp_no
inner join dp
on de.dept_no = dp.dept_no;


select e.*, d.*
from employees e
inner join dept_emp de
using(emp_no)
inner join dp
using(dept_no);
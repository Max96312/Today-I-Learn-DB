select *
from employees;

select
	e.name as employee_name,
    m.name as manager_name
from employees e
join employees m on e.manager_id = m.employee_id;


select
	e.name as employee_name,
    m.name as manager_name
from employees e
left join employees m on e.manager_id = m.employee_id;
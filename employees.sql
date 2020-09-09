/* Query all manager employees and count its subordinates and
* order by subordinates quantity
*/

```
select 
* 
from (
  select 
    employee_id, 
    first_name || ' ' || last_name as name, 
    (select count(*) from employees where manager_id = e.employee_id) 
      as sub_qty 
  from employees e 
  where 
    e.manager_id in (
        select distinct manager_id from employees where manager_id is not NULL
    ) 
  or e.manager_id is NULL
) as tmp 
where tmp.sub_qty > 0 
order by tmp.sub_qty desc
```

/* Query all employees and their dependent count */
```
select 
  e.employee_id,
  e.first_name || ' ' ||  e.last_name employee_name, 
  (select count(*) from dependents where e.employee_id = dependents.employee_id)
    as dep_count
from employees e 
left join dependents d on d.employee_id = e.employee_id
```

/* Find the number of countries in each region, order by the highest number */
```
select 
  (select region_name from regions r where r.region_id = c.region_id)
  as region_name,
  count(country_id) as qty
from countries c 
group by c.region_id
order by qty desc
```


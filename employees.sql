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

/* Count required count by semester in the year 2003 */
```
select
 count(if(requiredDate like '2003-%', 1, NULL)) as 'all',
 count(if(requiredDate between '2003-01-01' and '2003-06-30', 1, NULL)) 
  as 'first',
 count(if(requiredDate between '2003-07-01' and '2003-12-31', 1, NULL)) 
  as 'second'
from orders
```

/* Same as above without using if function (yields transposed matrix) */
```
select
  queryWithSemester.semester,
  count(queryWithSemester.semester) as 'count'
from (
  select
   *,
   (select if(requiredDate between '2003-01-01' and '2003-06-30', 'first', 'second')) 
    as semester
  from orders
) as queryWithSemester 
where queryWithSemester.requiredDate like '2003-%'
group by queryWithSemester.semester
```

/* Count required count by month in the year 2003 */
```
select
  month(o.requiredDate) as mth,
  count(*) as count
from orders o
where requiredDate like '2003-%'
group by mth
```

/* Union result sets */
```
select 
  customerNumber as id, customerLastName as name
from customers
union
select employeeNumber as id, firstName as name
from employees
order by name, id
```

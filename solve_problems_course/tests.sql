/* Select not like */
select employeeNumber, lastName, firstName from employees
where firstName not like 'B%';

/* Select escaped chars */
select productCode, productName from products where productCode like '%\_20%';

/* Select custom escape char */
select productCode, productName from products 
where productCode like '%$_20%' escape '$'

/* Limit with start index */
select * from orders limit 2, 5

/* order by more than one field */
select contactLastName, contactFirstName from customers
order by contactLastName desc, contactFirstName asc

/* select all the customers and their orders (note the aliases)*/
select
  c.customerNumber, c.customerName, o.orderNumber
from customers c left join orders o
on c.customerNumber = o.customerNumber

/* select all customers whose haven't made any orders */
select
  c.customerNumber, c.customerName, o.orderNumber
from customers c left join orders o
on c.customerNumber = o.customerNumber
where o.orderNumber is NULL

/* select with self join */
select
 concat(m.lastName, ' ', m.firstName) as Manager,
 concat(e.lastName, ' ', e.firstName) as 'Direct Report'
from employees e join employees m
on m.employeeNumber = e.reportsto
order by manager

/* select total amount on each order status */
/* Obs: note that if you're using same 
column name in both tables joining you can you use `using` keyword
*/
select
  status,
  sum(quantityOrdered * priceEach) as amount
from orders o inner join orderdetails od
#on o.orderNumber = od.orderNumber
using(orderNumber)
group by status

/* Select the amount on each orderNumber that are > 50,000 */
select
  orderNumber,
  sum(quantityOrdered * priceEach) as amount
from orderdetails
group by orderNumber having amount > 5e4

/* Select customer IDs in which amount is greater than the average */
select 
 customerNumber, checkNumber, amount 
from payments 
where amount > (select avg(amount) from payments)

/* Select customer who hasn't made a order yet */
select customerName from customers 
where customerNumber not in (select distinct customerNumber from orders)

/* Select customers union with employees */
select customerNumber as id, contactLastName as name from customers
union
select employeeNumber as id, firstName as name from employees
order by name, id

/*
- The following countruction of crate table/insert data are valid too:

- To copy a table definition
create table_copy like source_table

- Copy table data into another
insert into target_table (select * from source_table [where ...])
*/

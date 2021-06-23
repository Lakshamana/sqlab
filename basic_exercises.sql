-- Exercise 1
`select * from shippers`

-- Exercise 2
`select CategoryName, Description from categories`

-- Exercise 3
```
select FirstName, LastName, HireDate 
from employees 
where title = 'Sales Representative'
```

-- Exercise 4
```
select FirstName, LastName, HireDate 
from employees 
where 
 title = 'Sales Representative' and
 country = 'USA'
```

-- Exercise 5
`select OrderId, OrderDate from orders where EmployeeID = 5`

-- Exercise 6
```
select
 SupplierID,
 ContactTitle,
 ContactName
from suppliers
where ContactTitle != 'Marketing Manager'
```

-- Exercise 7
```
select 
  ProductID, 
  ProductName 
from products 
where ProductName like '%queso%'
```

-- Exercise 8
```
select 
 OrderID, 
 CustomerID, 
 ShipCountry
from orders
where ShipCountry in ('France', 'Belgium')
```

-- Exercise 9
```
select 
 OrderID, 
 CustomerID, 
 ShipCountry
from orders
where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
```

-- Exercise 10
`select FirstName, LastName, Title, BirthDate from employees order by BirthDate`

-- Exercise 11
```
select 
 FirstName, 
 LastName, 
 Title, 
 DATE(BirthDate) as bdate 
from employees 
order by bdate
```

-- Exercise 12
```
select
 FirstName,
 LastName,
 CONCAT(FirstName, ' ', LastName) as FullName
from employees
```

-- Exercise 13
```
select
 OrderID,
 ProductID,
 UnitPrice,
 Quantity,
 (UnitPrice * Quantity) as TotalPrice
from orderdetails
order by OrderID, ProductID
```

-- Exercise 14
`select count(*) from customers`

-- Exercise 15
`select OrderDate from orders order by OrderDate limit 1` OR
`select min(OrderDate) as FirstOrder from orders`

-- Exercise 16
`select distinct Country from customers`

-- Exercise 17
```
select
 ContactTitle,
 count(*) as Count
from customers
group by ContactTitle
order by Count desc, ContactTitle
```

-- Exercise 18
```
select
 p.ProductID,
 p.ProductName,
 s.CompanyName as Supplier
from products p inner join suppliers s
on p.SupplierID = s.SupplierID
```

-- Exercise 19
```
select
 OrderID,
 DATE(OrderDate) as OrderDate,
 (select CompanyName from shippers s where s.ShipperID = o.ShipVia) as Shipper
from orders o
where o.OrderID < 10300
```
OR
```
select
 OrderID,
 DATE(OrderDate) as OrderDate,
 CompanyName as Shipper
from orders o inner join shippers s
on o.ShipVia = s.ShipperID
where OrderID < 10300
order by OrderID
```

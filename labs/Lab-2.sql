2.1
select p.Color, count(*) as 'Amount'
from Production.Product as p
where p.ListPrice >= 30
group by p.Color

2.2
select p.Color
from Production.Product as p
group by p.Color
having MIN(p.ListPrice)

2.3
select  p.ProductSubcategoryID, COUNT(*) as 'ProductCount'
from  Production.Product as p
group by p.ProductSubcategoryID

2.4
select s.ProductID, count(*) as 'Count'
from Sales.SalesOrderDetail as s
group by s.ProductID

2.5
select s.ProductID, count(*) as 'Count'
from Sales.SalesOrderDetail as s
group by s.ProductID
having count(*) > 5

2.6
select distinct s.CustomerID, count(s.SalesOrderID) as 'Count' 
from Sales.SalesOrderHeader as s
group by s.CustomerID, s.OrderDate
having count(s.SalesOrderID) > 1

2.7
select s.SalesOrderID, count(s.ProductID) as 'Count of production'
from Sales.SalesOrderDetail as s
group by s.SalesOrderID
having count(s.ProductID) > 3

2.8
select s.ProductID, count(s.SalesOrderID) as 'Count of orders that contains this product'
from Sales.SalesOrderDetail as s
group by s.ProductID
having count(s.SalesOrderID) > 3

2.9
select s.ProductID
from Sales.SalesOrderDetail as s
group by s.ProductID
having count(s.SalesOrderID) = 3 or count(s.SalesOrderID) = 3

2.10
select p.ProductSubcategoryID, count(*) as 'Amount'
from Production.Product as p
group by p.ProductSubcategoryID
having count(*) > 10

2.11
select s.ProductID
from Sales.SalesOrderDetail as s
group by s.ProductID
having max(s.OrderQty) = 1

2.12
select top(1) s.SalesOrderId, sum(s.OrderQty) as 'Amount'
from Sales.SalesOrderDetail as s
group by s.SalesOrderID
order by sum(s.OrderQty) desc

2.13
select top(1) s.SalesOrderId, sum(s.OrderQty * s.UnitPrice) as 'SumPrice'
from Sales.SalesOrderDetail as s
group by s.SalesOrderID
order by sum(s.OrderQty * s.UnitPrice) desc

2.14
select p.ProductSubcategoryID, count(*) as 'Count'
from Production.Product as p
where p.ProductSubcategoryID is not null and p.Color is not null
group by p.ProductSubcategoryID

2.15
select p.Color, count(*) as 'Count'
from Production.Product as p
where p.Color is not null
group by p.Color
order by count(*) desc

2.16
select s.ProductID
from Sales.SalesOrderDetail as s
group by s.ProductID
having min(s.OrderQty) > 1 and count(*) > 2

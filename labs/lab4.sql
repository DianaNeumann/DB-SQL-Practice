-- 1 Найти название самого продаваемого продукта
select p.Name
from Production.Product as p
where p.ProductID = (
	select top 1 s.ProductID
	from Sales.SalesOrderDetail as s
	group by s.ProductID
	order by count(s.ProductID) desc
)

-- 2.Найти покупателя, совершившего покупку на самую большую сумм, считая
-- сумму покупки исходя из цены товара без скидки (UnitPrice).
select soh.CustomerID
from Sales.SalesOrderHeader as soh 
join Sales.SalesOrderDetail as sod on
soh.SalesOrderID = sod.SalesOrderID
where sod.UnitPrice * sod.OrderQty = (
	select max(UnitPrice * OrderQty)
	from Sales.SalesOrderDetail
)

-- 3 Найти такие продукты, которые покупал только один покупатель.

-- 1)
select sod.ProductID
from Sales.SalesOrderDetail as sod
where sod.ProductID in (
	select count(*)
	from Sales.SalesOrderHeader as soh
	group by soh.CustomerID
	having count(distinct soh.CustomerID) = 1
)

-- 2)
select p.Name
from Production.Product as p
where p.ProductID in (
	select sod.ProductID
	from Sales.SalesOrderHeader as soh
	join Sales.SalesOrderDetail as sod on
	soh.SalesOrderID = sod.SalesOrderID
	group by sod.ProductID
	having count(distinct soh.CustomerID) = 1
)

-- 4 Вывести список продуктов, цена которых выше средней цены товаров в
-- подкатегории, к которой относится товар.
select p1.Name
from Production.Product as p1
where p1.ListPrice > (
	select avg(p2.ListPrice)
	from Production.Product as p2
	where p1.ProductSubcategoryID = p2.ProductSubcategoryID 
)

-- Найти номер покупателя и самый дорогой купленный им товар для каждого покупателя
select soh.CustomerID, sod.ProductID
from Sales.SalesOrderHeader as soh
join Sales.SalesOrderDetail as sod
on soh.SalesOrderID = sod.SalesOrderID
WHERE sod.UnitPrice in (
    select max(sod1.UnitPrice)
    from Sales.SalesOrderDetail as sod1
    join Sales.SalesOrderHeader as soh1
    on sod1.SalesOrderID = soh1.SalesOrderID
    where soh.CustomerID = soh1.CustomerID
)
ORDER BY CustomerID

-- Найти самый дорогой красный товар для каждой подкатегории
select p.Name, p.ProductSubcategoryID, p.ListPrice
from Production.Product as p
where p.ListPrice = (
	select max(p1.ListPrice)
	from Production.Product as p1
	where p.ProductSubcategoryID = p1.ProductSubcategoryID and p1.Color = 'Red'
)

-- Найти название категории с наибольшим количеством товаров (с подзапросом)
select pc.Name
from Production.ProductCategory as pc join
Production.ProductSubcategory as ps 
on pc.ProductCategoryID = ps.ProductCategoryID join
Production.Product as p
on ps.ProductSubcategoryID = p.ProductSubcategoryID
group by pc.Name
having count(p.ProductID) = (
    select top 1 count(p1.ProductID)
    from Production.ProductCategory as pc1 join
    Production.ProductSubcategory as ps1 
    on pc1.ProductCategoryID = ps1.ProductCategoryID join
    Production.Product as p1
    on ps1.ProductSubcategoryID = p1.ProductSubcategoryID
    group by pc1.Name
    order by count(p1.ProductID) desc 
)
USE grind_sales;
GO

with all_orders as (SELECT 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM [grind_sales].[dbo].[Orders_2023]

union all

SELECT 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM [grind_sales].[dbo].[Orders_2024]

union all 
SELECT 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM [grind_sales].[dbo].[Orders_2025])

SELECT 
a.OrderID,
a.CustomerID,
c.Region,
a.ProductID,
a.OrderDate,
DATEADD(WEEK, DATEDIFF(week, 0, a.OrderDate),0) as Week_Date,
c.CustomerJoinDate,
a.Quantity,
a.Revenue,
CASE WHEN a.Revenue is null then p.Price * a.Quantity else a.Revenue end as Cleaned_Revenue,
a.Revenue - a.COGS as Profit,
a.COGS,
p.ProductName,
p.ProductCategory,
p.Price,
p.Base_Cost
FROM all_orders a
left join customers c 
on a.CustomerID = C.CustomerID
left join products p 
on a.ProductID = p.ProductID
where a.CustomerID is not null





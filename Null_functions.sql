--IsNULL is used to check if a value is null and replace it with another value or static value--
SELECT isNull(ShipAddr, 'N/A')
from Orders

/*COALESCE does similar to what ISNull does but, it takes unlimited arguments, and keeps checking from
left to right untill the value is not null, and if the last value is Null it just assigns that */

/* Select avg score of customers*/
select avg(Score) over () as AVG_WithNull, avg(coalesce(Score, 0)) over () as AVG_WithNoNull, score
from customers

--Display full name of customers in a single field, add 10 bonus points for their score--

select FirstName + ' ' + coalesce(LastName, '') as FullName, coalesce(Score, 0) + 10 AS TotalScore, Score
from Customers

-- Handle Joins in case of NULL values --

select first_name, order_date, coalesce(customer_id, 3) 
from customers
join orders
on customers.id = coalesce(orders.customer_id, 3)

-- Handle orderby in case of Nulls, where Nulls are in the end --

select *,
Case when customer_id IS NULL then 1 else 0 END
from orders
order by Case when customer_id IS NULL then 1 else 0 END, customer_id

-- NULLIF helps in divide by zero error --
SELECT 
  100 AS price,
  50 AS discount,
  100 / NULLIF(50, 0) AS price_ratio;

-- IS NULL and IS NOT NULL, display all the orders that have shipping address - 
select * 
from Orders
where ShipAddr IS NOT NULL

-- IS NULL and IS NOT NULL, display all the orders that do not have shipping address - 
select * 
from Orders
where ShipAddr IS NULL

-- IS NULL and IS NOT NULL, for left anti join - 
select *
from customers
left join orders
on orders.Customerid = customers.Customerid
where orders.Customerid is null

-- Data policy, Trim to have only empty string and NULLIF for only NULLS - 
select NULLIF(Trim(FirstName), ''), Datalength(NULLIF(Trim(FirstName), ''))
from Customers

-- Data policy, Trim to have only empty string and NULLIF for only NULLS, or have default values(but it will take extra space) - 
select coalesce(NULLIF(Trim(FirstName), ''), 'Missing Data')
from Customers

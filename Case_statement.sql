-- Count orders and assign category, then sort by product ID in ascending - 
select *
from (select productID, count(orderid) as order_Count,
CASE WHEN count(orderid) > 5 THEN 'High' WHEN count(orderid) > 3 THEN 'Medium' WHEN count(orderid) > 2 THEN 'Medium' Else 'Too Low' END CATEGORY
from orders
group by productID)t
order by  productID desc

-- retreive employee details with gender displayed as full text --
select FirstName, LastName,
Case when gender = 'M' Then 'Male' when gender ='F' THEN 'Female' else 'others'  END Full_Gender
from employees

SELECT *
FROM [DACORNER]..sales

SELECT *
FROM [DACORNER]..cars

SELECT *
FROM [DACORNER]..salesman

--1.What are the details of all cars purchased in the year 2022?

SELECT *
FROM [DACORNER]..sales sa
left join [DACORNER]..cars ca
on sa.Car_Id=ca.Car_Id
WHERE DATEPART(year,Purchase_Date)=2022
Order by Purchase_Date ASC

--2.What is the total number of cars sold by each salesperson?

SELECT sa.Salesman_Id,Name,count(Name) as Achievement
FROM [DACORNER]..sales sa
left join [DACORNER]..salesman ma
on sa.Salesman_Id=ma.Salesman_Id
Group by sa.Salesman_Id,Name

--3.What is the total revenue generated by each salesperson?

Select sa.Salesman_Id,Name,SUM(Cost) as Revenue
FROM [DACORNER]..sales sa
left join [DACORNER]..salesman ma
on sa.Salesman_Id=ma.Salesman_Id left join 
[DACORNER]..cars ca on sa.Car_Id=ca.Car_Id
Group by sa.Salesman_Id,Name

--4.Whar are the details of cars sold by each sales person?

select ma.Salesman_Id,ma.Name,ca.Car_Id,ca.Make,
ca.Type,ca.Style,ca.Cost
from [DACORNER]..salesman ma
left join [DACORNER]..sales sa
on ma.Salesman_Id=sa.Salesman_Id
left join [DACORNER]..cars ca
on sa.Car_Id=ca.Car_Id
order by ma.Salesman_Id,ma.Name,ca.Car_Id

--5.What is the total revenue generated by each car type?

SELECT ca.Car_Id,Type,sum(Cost) as Revenue
FROM [DACORNER]..sales sa
left join [DACORNER]..cars ca 
on sa.Car_Id=ca.Car_Id
group by Type,ca.Car_Id

--6.What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong'?

select ma.Salesman_Id,ma.Name,sa.Purchase_Date,sa.Sale_Id,sa.Car_Id,ca.Make,
ca.Type,ca.Style,ca.Cost
from [DACORNER]..salesman ma
left join [DACORNER]..sales sa
on ma.Salesman_Id=sa.Salesman_Id
left join [DACORNER]..cars ca
on sa.Car_Id=ca.Car_Id
where datepart(year,Purchase_Date)=2021 and Name='Emily Wong'
order by ma.Salesman_Id,ma.Name,ca.Car_Id

--7.What is the total revenue generated by the sales of hatchback cars?

SELECT ca.Style,sum(Cost) as Revenue
FROM [DACORNER]..sales sa
left join [DACORNER]..cars ca
on sa.Car_Id=ca.Car_Id
where ca.Style='hatchback'
Group by ca.Style

--8.What is the total revenue generated by the sales of SUV cars in the year 2022?


SELECT ca.Style,sum(Cost) as Revenue
FROM [DACORNER]..sales sa
left join [DACORNER]..cars ca
on sa.Car_Id=ca.Car_Id
where datepart(year,sa.Purchase_Date)=2022 and ca.Style='SUV'
Group by ca.Style

--9.What is the name and city of the salesperson who sold the most number of cars in the year 2023?

SELECT TOP 1 ma.Name,count(ma.Name) as no_of_sale,ma.City
FROM [DACORNER]..sales sa
left join [DACORNER]..salesman ma
on sa.Salesman_Id=ma.Salesman_Id
Group by ma.Name,ma.City
order by no_of_sale desc

--10.What is the name and age of the salesperson who generated the highest revenue in the year 2022?

Select TOP 1 ma.Name,ma.Age,sum(Cost) as Highest_revenue
FROM [DACORNER]..sales sa
left join [DACORNER]..salesman ma
on sa.Salesman_Id=ma.Salesman_Id left join 
[DACORNER]..cars ca on sa.Car_Id=ca.Car_Id
where datepart(year,Purchase_Date)=2022
group by ma.Name,ma.Age
ORDER BY Highest_revenue Desc

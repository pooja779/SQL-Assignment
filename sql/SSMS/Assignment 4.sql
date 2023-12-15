-- 26-10-2023
--JOINS

--ASSIGNMENT 4

CREATE DATABASE Shopping;
USE Shopping;

Create table tblSalesmen(Snum INT primary key,Sname varchar(20),City 
varchar(20), Commission decimal(6,2))


Create table tblOrders(Onum int primary key, Oamt decimal(7,2),Odate datetime,Cnum int 
references tblCustomers(Cnum),Snum int references tblSalesmen(Snum))


Create table tblCustomers (Cnum int primary key,Cname varchar(20),City varchar(20), Rating 
INT,Snum int references tblSalesmen(snum))

SELECT * FROM tblCustomers
SELECT * FROM tblSalesmen
SELECT * FROM tblOrders



--THREE TABLE JOINS

SELECT Onum,Odate,Oamt,Cname,Sname
FROM tblOrders O 
JOIN  tblCustomers C  ON O.Cnum=C.Cnum 
JOIN tblSalesmen S ON O.Snum=S.Snum

--orders  booked in this month

SELECT Onum,Odate,Oamt,Cname,Sname
FROM tblOrders O 
JOIN  tblCustomers C  ON O.Cnum=C.Cnum 
JOIN tblSalesmen S ON O.Snum=S.Snum
WHERE DATEPART(MONTH,GETDATE())= DATEPART(MONTH,O.Odate)

--this year


--THIS MONTH AND THIS YEAR
SELECT Onum,Odate,Oamt,Cname,Sname
FROM tblOrders O 
JOIN  tblCustomers C  ON O.Cnum=C.Cnum 
JOIN tblSalesmen S ON O.Snum=S.Snum
WHERE DATEPART(MONTH,GETDATE())= DATEPART(MONTH,O.Odate) 
AND
DATEPART(YYYY,GETDATE())= DATEPART(YYYY,O.Odate)

--OR

SELECT Onum,Odate,OAmt,CName,SName
FROM tblOrders O 
JOIN  tblCustomers C  ON O.Cnum=C.Cnum 
JOIN tblSalesmen S ON O.Snum=S.Snum
WHERE DATEPART(MONTH,GETDATE())+DATEPART(YYYY,GETDATE())= 
DATEPART(MONTH,O.Odate) +DATEPART(YYYY,O.Odate)

--------------------------------------------------------------------------------------

SELECT DATEPART(MONTH,GETDATE())
SELECT DATENAME(MONTH,GETDATE())


SELECT DATEPART(MONTH,GETDATE())+DATENAME(MONTH,GETDATE())
SELECT DATENAME(MONTH,GETDATE())+DATEPART(MONTH,GETDATE())


SELECT DATEPART(MONTH,GETDATE())+DATEPART(YEAR,GETDATE())
SELECT DATENAME(MONTH,GETDATE())+DATENAME(YEAR,GETDATE())

--
SELECT CONVERT(VARCHAR,GETDATE(),105)
----------------------------------------------------------------------------------

--Two table Join Questions:

USE payroll;

--1. Display All employees with their Department Names(Exclude the employees not allocated with department)

select * from Employees
select * from tblDepartment

SELECT E.Employee_FirstName,D.Depname
FROM Employees E JOIN tblDepartment D 
ON E.Depid=D.Depid
WHERE D.Depid is not null

--2. Display employees joined in the year 2020 with their Department Names

SELECT E.Employee_FirstName,D.Depname,E.JoiningDate
FROM Employees E JOIN tblDepartment D 
ON E.Depid=D.Depid 
WHERE DATEPART(YYYY,JoiningDate)=2020


--3. Display employees who work in their hometown  with their Department Names(Exclude the employees not allocated with department)


select * from Employees
select * from tblDepartment

SELECT E.Employee_FirstName,D.Depname,D.Location as DepLocation,E.location as EmpLocation
FROM Employees E JOIN tblDepartment D 
ON E.Depid=D.Depid
WHERE E.location=D.Location

--4. Display All Departments with their employees(Include departments without Employees too)

--OG OP
SELECT  D.Depname,COUNT(E.EmpId) AS [No.of Employees]
FROM tblDepartment D left JOIN Employees E
ON E.Depid=D.Depid 
GROUP BY D.Depname

--y to group by e.depid
--SELECT  D.Depname,COUNT(E.EmpId) AS [No.of Employees]
--FROM tblDepartment D left JOIN Employees E
--ON E.Depid=D.Depid 
--GROUP BY E.Depid 


select * from Employees
select * from tblDepartment


----OP ? shows how left join works
--SELECT  D.Depname
--FROM tblDepartment D left JOIN Employees E
--ON E.Depid=D.Depid 

----shows how left join works
--SELECT  D.Depname,E.Employee_FirstName
--FROM tblDepartment D left JOIN Employees E
--ON E.Depid=D.Depid 



--5. Display all employees with their department locations(Include employees who are not allocated with department)
SELECT  E.EmpId,Employee_FirstName,D.Location
FROM  Employees E left JOIN tblDepartment D
ON E.Depid=D.Depid 


select * from Employees
select * from tblDepartment
 

 exec sp_rename 'Employees.Employee_LastName','location','COLUMN'

 -----------------------------------------------------------------------------------------------
 --THREE TBLES JOIN
 USE Shopping;
-- 1.Display the following information about each order. 

SELECT * FROM tblCustomers
SELECT * FROM tblSalesmen
SELECT * FROM tblOrders

--a.Order No, Customer Name, Order Amount, Order Date 

SELECT Onum,Cname,Oamt,Odate
FROM tblOrders O 
INNER JOIN  tblCustomers C  ON O.Cnum=C.Cnum 



--2.Display customers associated with each Salesman 

SELECT Cname,Sname
FROM tblCustomers C 
RIGHT OUTER JOIN  tblSalesmen S  ON C.Snum=S.Snum 

--3.Display following information about each order: 
--a.OrderNo , Customer Name, Salesman Name, Order Amount, Order 
--Date 

SELECT Onum,Odate,Oamt,Cname,Sname
FROM tblOrders O 
JOIN  tblCustomers C  ON O.Cnum=C.Cnum 
JOIN tblSalesmen S ON O.Snum=S.Snum


--4.Display salesman with their order details in the decreasing order 
--value(Include salesman who has not captured any order) 
--a.Salesman name, Customer name,Ordervalue 

SELECT * FROM tblCustomers
SELECT * FROM tblSalesmen
SELECT * FROM tblOrders

SELECT Sname,Cname,Oamt,Onum,Odate
FROM tblOrders O 
JOIN  tblCustomers C ON O.Cnum=C.Cnum 
RIGHT JOIN tblSalesmen S ON O.Snum=S.Snum
ORDER BY Oamt DESC


--5.Display customers with their orders in the ascending order of date(Include 
--customers who hasn’t booked any order) 
--a.Customer Name, Order Value Order date 

SELECT C.Cname,Oamt as [Order Value],Odate
FROM tblCustomers C LEFT JOIN tblOrders O
ON C.Cnum=O.Cnum
ORDER BY Odate

--6.List the number of customers handled by each salesman.(Sales man 
--name, Number of Customers handled) 


SELECT S.Snum,S.Sname,COUNT(C.Cnum) AS [no.of customers]
FROM tblSalesmen S left join tblCustomers C 
ON S.Snum=C.Snum
GROUP BY S.Sname,S.Snum

SELECT *
FROM tblSalesmen S left join tblCustomers C 
ON S.Snum=C.Snum



--7.List the customers(Name of the customer) who have placed more than 
--one order 

SELECT * FROM tblCustomers
SELECT * FROM tblSalesmen
SELECT * FROM tblOrders

SELECT C.Cname
FROM tblCustomers C JOIN tblOrders O
ON C.Cnum=O.Cnum

HAVING COUNT(O.Cnum)>1



--8.Display sum of orders from each city from each customer and salesman

SELECT * FROM tblCustomers
SELECT * FROM tblSalesmen
SELECT * FROM tblOrders

select c.city, count(Onum) as [sum of orders ],Cname
from tblOrders o INNER JOIN tblCustomers c on o.cnum=c.cnum
group by c.city,Cname

----- OG OP BY 
select  c.city, count(Onum) as [sum of orders ],Cname,s.Sname
from tblCustomers c INNER JOIN tblOrders o on c.Cnum=o.Cnum
LEFT JOIN tblSalesmen s ON s.Snum=o.Snum
GROUP BY c.city,c.cname,s.Sname



-- EXPECTED O/P 
-- SALESMAN | CITY | CUSTOMER | SUM(ORDERS)


 
---------------------------------------------------------------------------------------------------------
 ALTER TABLE Employees ADD  Managerid int

 USE payroll;

 select * from Employees
---display manager who have atleast one person reporting to them

 SELECT E2.Managerid,E1.Employee_FirstName
 FROM Employees E1 JOIN Employees E2
 ON E1.EmpID=E2.Managerid
 group by E2.Managerid
 Having COUNT(E2.Managerid)>0



---display all manager with no .of people reporting to them
 

 SELECT E2.Managerid,COUNT(E1.EmpId) as [no .of people]
 FROM Employees E2 RIGHT JOIN Employees E1 
 ON E2.Managerid=E1.EmpId
 GROUP BY E2.Managerid

 --select * from Employees

  select e2.Employee_FirstName,count(e1.Employee_FirstName) as[no .of people]
  from Employees e1 join Employees e2
  on e1.Managerid=e2.EmpId
  GROUP BY e2.Employee_FirstName




------------------------------------------------------------------------
--ASSIGNMENT 7
 Create database Assignment_7
 USE Assignment_7

--Consider following tables  

--Salesman (Sid, Sname, Location) 

CREATE TABLE Salesman
( 
	Sid int primary key,
	Sname varchar(20),
	Location varchar(20)
)
--Product (Prodid, Pdesc, Price, Category, Discount) 

CREATE TABLE Product
(
	Pid int primary key,
	Pdesc varchar(30),
	Price Money,
	Category varchar(20),
	Discount INT
)
--Sale (Saleid, Sid, Sldate, Amount) 
CREATE TABLE Sale
(
	Saleid int primary key,
	Sid INT FOREIGN KEY REFERENCES Salesman(Sid),
	Sldate DATETIME,
	Amount Money
)
--Saledetail (Saleid, Prodid, Quantity) 
create TABLE Saledetail
(
	Saleid int FOREIGN key REFERENCES Sale(Saleid) ,
	Pid int FOREIGN key REFERENCES Product(Pid),
	Quantity INT
	CONSTRAINT Comp_key PRIMARY KEY(Saleid,Pid)
)


 
--Write queries for following: 
 
--1.Display the sale id and date for most recent sale. 

select * from Product
select * from Sale
select * from Saledetail
select * from Salesman

SELECT TOP 1 with ties Saleid,Sldate
FROM Sale
ORDER BY Sldate DESC


--2.Display the names of salesmen who have made at least 2 sales. 

select * from Sale

select * from Salesman

SELECT Sid,Sname
FROM Salesman 
WHERE Sid IN
(	SELECT Sid 
	FROM Sale
	GROUP BY Sid
	HAVING COUNT(Saleid)>=2	
)


--3.Display the product id and description of those products which are sold in 
--minimum total quantity. 

select * from Product
select * from Sale
select * from Saledetail
select * from Salesman

SELECT Pid,Pdesc
FROM Product
WHERE Pid IN 
( 
	SELECT  TOP 1 WITH TIES Pid--,SUM(Quantity) as [Total Quantity]
	from Saledetail
	group by Pid
	order by SUM(Quantity)
)

--4.Display SId, SName and Location of those salesmen who have total sales 
--amount greater than average sales amount of all the sales made. Amount can 
--be calculated from Price and Discount of Product and Quantity sold. 

select * from Product
select * from Sale
select * from Saledetail
select * from Salesman


UPDATE 
	Sale 
SET 
	Amount = [Amt]
		FROM
			(SELECT 
				SUM((p.Price-p.Discount)*S.Quantity) AS [Amt],
				s.Saleid
			FROM 
				Product p INNER JOIN Saledetail s ON p.pid=s.pid
			GROUP BY [Saleid]) AS [IT]
		WHERE 
			[IT].[Saleid]=[Sale].[Saleid];


--4.Display SId, SName and Location of those salesmen who have total sales 
--amount greater than average sales amount of all the sales made. Amount can 
--be calculated from Price and Discount of Product and Quantity sold. 
select * from Sale
select * from Salesman

SELECT s.Sid,S.Sname,S.Location
FROM Salesman S INNER JOIN Sale sl ON S.sid=sl.sid
GROUP BY S.Sid,S.Sname,S.Location
HAVING SUM(Amount) > 
(SELECT AVG(Amount)
FROM Sale )


 
--Corelated Subquery 
--5.Display the product id, category, description and price for those products whose 
--price is maximum in each category.

select * from Product

SELECT MAX(Price) ,Category
FROM Product 
GROUP BY Category







--6.Display the names of salesmen who have not made any sales. 

select * from Sale

select * from Salesman

SELECT Sid,Sname
FROM Salesman Sm
WHERE NOT exists (
	select Sid 
	FROM Sale S
	WHERE S.Sid=Sm.Sid)




--7.Display the names of salesmen who have made at least 1 sale in the month of 
--Jun 2015. 
select * from Sale

select * from Salesman

SELECT Sname
FROM Salesman sm
WHERE  EXISTS
	(SELECT Sid 
	FROM Sale s
	WHERE DATENAME(MONTH,Sldate)='June' AND	 DATEPART(yyyy,Sldate)=2015 and sm.Sid=s.Sid)


----------------------------------------------------------------------------------

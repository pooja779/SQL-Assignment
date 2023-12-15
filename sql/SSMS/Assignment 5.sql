---- 27-10-2023
--Assignment 5
---- HEALTHCARE 3 TABLES

USE Shopping;
create TABLE patient
(
	pid VARCHAR(20) PRIMARY KEY,
	pname VARCHAR(20),
	city VARCHAR(20)
)

create table doctor
(
	did VARCHAR(20) primary key,
	dname VARCHAR(20),
	dept VARCHAR(20),
	salary Money
)

create table consultation
(
	cid int primary key,
	pid VARCHAR(20) foreign key references patient(pid),
	did VARCHAR(20) foreign key references doctor(did),
	fee money
)


--Please provide solutions to the problem statements given below based on the scenario 
--and details provided on the previous page. 


--Requirement 1 : 
--Identify the consultation details of patients with the letter ‘e’ anywhere in their name, who 
--have consulted a cardiologist. Write a SQL query to display doctor’s name and patient’s 
--name for the identified consultation details. 

select * from doctor
select * from patient
select * from consultation

SELECT 
	d.dname,p.pname
FROM 
	patient p join consultation c on p.pid=c.pid
	join doctor d on c.did=d.did
WHERE 
	p.pname LIKE '%e%' AND d.dept='Cardiology'

--Requirement 2 : 
--Identify the doctors who have provided consultation to patients from the cities ‘Boston’ 
--and ‘Chicago’. Write a SQL query to display department and number of patients as 
--PATIENTS who consulted the identified doctor(s). 

select * 
from doctor
ORDER BY 3 

select * from patient
select * from consultation


SELECT 
	d.dept,count(p.pid) as[no.of patients],d.dname
FROM 
	patient p join consultation c on p.pid=c.pid
	join doctor d on c.did=d.did
WHERE 
	p.city in ('Boston','Chicago')
GROUP BY 
	d.dept,d.dname


--Requirement 3 : 
--Identify the cardiologist(s) who have provided consultation to more than one patient. 
--Write a SQL query to display doctor’s id and doctor’s name for the identified 
--cardiologists. 

select * from doctor
--select * from patient
select * from consultation

SELECT 
	  d.dname,
	  d.did, 
	  count(d.dname) as [no.of patients]
FROM 
      doctor d JOIN consultation c ON d.did=c.did
WHERE 
      d.dept='Cardiology'
GROUP BY
      d.did,d.dname
HAVING
     count(d.dname)>1


--Requirement 4 : 
--Write a SQL query to combine the results of the following two reports into a single report. 
--The query result should NOT contain duplicate records. 
--Report 1 – Display doctor’s id of all cardiologists who have been consulted by 
--patients. 
--Report 2 – Display doctor’s id of all doctors whose total consultation fee charged 
--in the portal is more than INR 800. 

select * from doctor
--select * from patient
select * from consultation

SELECT DISTINCT c.did,d.dname
FROM doctor d INNER JOIN consultation c ON d.did=c.did
WHERE d.dept='Cardiology' 

UNION

SELECT c.did,d.dname
FROM doctor d JOIN consultation c ON d.did=c.did
GROUP BY c.did,d.dname
HAVING  sum(c.fee)>800

--Requirement 5 : 
--Write a SQL query to combine the results of the following two reports into a single report. 
--The query result should NOT contain duplicate records. 
--Report 1 – Display patient’s id belonging to ‘New York’ city who have consulted 
--with the doctor(s) through the portal. 
--Report 2 – Display patient’s id who have consulted with doctors other than 
--cardiologists and have paid a total consultation fee less than INR 1000. 

select * from doctor
--select * from patient
select * from consultation

select DISTINCT p.pid
from patient p inner join consultation c ON p.pid=c.pid
WHERE p.city='New York'

union

SELECT  c.pid
FROM doctor d inner join consultation c ON d.did=c.did
WHERE d.dept!='Cardiology'
group by c.pid
having sum(c.fee)<1000


-------------------------------------------------------------------------------------------------

--TOY SHOP

CREATE DATABASE ToyShop
USE ToyShop;



SELECT * FROM tblCustomers
SELECT * FROM tblToys
SELECT * FROM tblCategory
SELECT * FROM tblTransaction

	 
--1.Display CustName and total transaction cost as TotalPurchase for those customers 
--whose total transaction cost is greater than 1000. 

SELECT CustName,sum(TxnCost) AS_TOTAL_PURCHASE
FROM tblCustomers JOIN tblTransaction
ON tblTransaction.Custid=tblCustomers.Custid
GROUP BY CustName
HAVING sum(TxnCost)>1000
--2.List all the toyid, total quantity purchased as 'total quantity' irrespective of the 
--customer. Toys that have not been sold should also appear in the result with total units as 
--0 
SELECT tblToys.ToyID,COUNT(Quantity) AS_TOTAL_QNTY
FROM tblToys LEFT JOIN tblTransaction
ON tblToys.Toyid=tblToys.Toyid
GROUP BY tblToys.Toyid


--3.The CEO of Toys corner wants to know which toy has the highest total Quantity sold. 
--Display CName, ToyName, total Quantity sold of this toy. 

SELECT Category.Cid,tblToys.ToyName,count(Quantity)
from tblToys join tblTransaction
on tblToys.Toyid=tblTransaction.Toyid
join Category on Category.Cid=tblToys.Toyid
---------------------------------------------------------------------------
--top highest paid employee

select empname
from employee
where salary>(select (avg(salary) from empoyee)



select * from Employees

select top 1 Salary
from Employees 
where Salary in
(select top 4 Salary
from Employees order by Salary desc)
order by salary 

select top 1 Salary
from Employees 
where Salary in
(select distinct top 4 Salary
from Employees order by Salary desc)
order by salary 


SELECT MIN(SALARY)
FROM EMPLOYEES
WHERE SALARY IN
(select distinct top 4 Salary
from Employees order by Salary desc)


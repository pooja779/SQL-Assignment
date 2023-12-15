-- 30-10-2023
--Assignment 6
--BANKING ASSIGNMENT

Create database Banking 
USE Banking;

CREATE TABLE AccountType
(
	Acctype int primary key,
	Accname varchar(30)
)

 create table TransactionType 
(
	Ttype int primary key,
	Tname varchar(20)
)

create table CustomerDetails
(
	Accno int primary key,
	Cname varchar(20),
	Address Varchar(20),
	Acctype int FOREIGN KEY REFERENCES  AccountType(Acctype)
)

CREATE TABLE AccountTransaction
(
	
	Tid INT PRIMARY KEY,
	Accno int FOREIGN KEY REFERENCES  CustomerDetails(Accno),
	Amount MONEY,
	dateofTran DATETIME,
	Ttype int FOREIGN KEY REFERENCES  TransactionType(Ttype)
)
SELECT * FROM AccountType
SELECT * FROM TransactionType
SELECT * FROM CustomerDetails
SELECT * FROM AccountTransaction


--⦁	List the Customer with transaction details who has done third lowest  transaction

SELECT	TOP 1 c.Cname,a.amount
from CustomerDetails c INNER JOIN AccountTransaction a
on c.AccNo=a.Accno
where a.Amount NOT IN (select top 2 a.Amount
from AccountTransaction a
order by a.Amount DESC)
order by a.Amount DESC

--⦁	List the customers who has done more transactions than average number of  transaction 

select AccountTransaction.Accno,count(AccountTransaction.Accno)
from AccountTransaction
group by AccountTransaction.Accno
HAVING count(AccountTransaction.accno)>(select avg(Amount)
from AccountTransaction


--⦁	List the total transactions under each account type.
SELECT AccountTransaction.Accno,count(AccountTransaction.Accno) As Total_Trans,count(AccountTransaction.accno) As Acc_Type
FROM AccountTransaction
GROUP BY AccountTransaction.Accno


--4⦁	List the total amount of transaction under each account type
	
	SELECT * FROM AccountTransaction
	SELECT * FROM CustomerDetails
	SELECT * FROM AccountType

	SELECT atype.Acctype,SUM(a.Amount) as [Total Amount of Transaction]
	FROM AccountTransaction a INNER JOIN CustomerDetails c ON a.Accno=c.Accno
	RIGHT JOIN AccountType atype ON c.Acctype=atype.Acctype
	GROUP BY atype.Acctype




--5⦁	List the total tranctions along with the total amount on a Sunday.

SELECT * FROM AccountTransaction
SELECT * FROM CustomerDetails
SELECT * FROM AccountType
SELECT * FROM TransactionType

SELECT count(Tid) as[Total Transaction],sum(Amount) as [Total Amount]
FROM AccountTransaction
WHERE DATENAME(WEEKDAY,dateofTran)='Sunday'



--6⦁	List the name, address, account type and total deposit from each customer account.
--scenario: if customer does only withdraw display his deposit amount as 0

SELECT * FROM AccountTransaction
SELECT * FROM CustomerDetails
SELECT * FROM AccountType
SELECT * FROM TransactionType

SELECT Cname,Address,Acctype,SUM(Amount)  as[Total Deposit]
FROM CustomerDetails c INNER JOIN AccountTransaction a ON c.Accno=a.Accno
WHERE a.Ttype=1
GROUP BY a.Accno,Cname,Address,Acctype



--OR WITH ACC TYPE NAME 

SELECT Cname,Address,c.Acctype,atype.Accname,SUM(Amount)  as[Total Deposit]
FROM CustomerDetails c INNER JOIN AccountTransaction a ON c.Accno=a.Accno
INNER JOIN AccountType atype ON c.Acctype=atype.Acctype
WHERE a.Ttype=1
GROUP BY a.Accno,Cname,Address,c.Acctype,atype.Accname



--7⦁	List the total amount of transactions of Mysore customers.

SELECT * FROM AccountTransaction
SELECT * FROM CustomerDetails
SELECT * FROM AccountType
SELECT * FROM TransactionType


SELECT SUM(Amount) AS[Total Amount]
FROM AccountTransaction t INNER JOIN CustomerDetails c ON t.Accno=c.Accno
WHERE Address='mysore'


--8⦁	List the name,account type and the number of transactions performed by each customer.

SELECT * FROM AccountTransaction
SELECT * FROM CustomerDetails
--SELECT * FROM AccountType
--SELECT * FROM TransactionType

SELECT c.Cname,a.Accname,COUNT(atr.Tid) as [number of transactions]
FROM CustomerDetails c LEFT OUTER JOIN AccountType a on c.Acctype=a.Acctype
left OUTER JOIN AccountTransaction atr ON atr.Accno=c.Accno
GROUP BY c.Cname,a.Accname,atr.Accno


--MODIFIED CODE : HAVE USED INNER JOIN BACAUSE IT TAKES ONLY THE NAME 
SELECT c.Cname,a.Accname,COUNT(atr.Tid) as [number of transactions]
FROM CustomerDetails c INNER  JOIN AccountType a on c.Acctype=a.Acctype
left OUTER JOIN AccountTransaction atr ON atr.Accno=c.Accno
GROUP BY c.Cname,a.Accname,atr.Accno


--9⦁	List the amount of transaction from each Location.

select CustomerDetails.Address,count(AccountTransaction.tid)
FROM AccountTransaction
RIGHT JOIN CustomerDetails
ON CustomerDetails.AccNo=AccountTransaction.Accno
GROUP BY CustomerDetails.Address


--10⦁Find out the number of customers  Under Each Account Type

SELECT * FROM AccountTransaction
SELECT * FROM CustomerDetails
SELECT * FROM AccountType
SELECT * FROM TransactionType

SELECT AccountType.AccName,count(AccountType.acctype) As No_of_cust
FROM AccountType
GROUP BY AccountType.AccName

















---------------------------------------------------------------------------------------------------

----SELECT Empname,Salary,
--(select avg(Salary) from tblEmployee as Avgsalary
--from tblEmployee)


--display emp who earn more than average salary than thier dep
select * from Employees
select * from tblDepartment
select Depid,AVG(Salary)
from Employees
group by Depid
Having Salary>AVG(Salary)

---display the dep which is drawing the maximum salary

SELECT TOP 1 Depid,SUM(Salary)
FROM (SELECT Depid,SUM(Salary) FROM Employees GROUP BY Depid ORDER BY SUM(Salary) DESC) as T1


-----------------------------------------------------------------------------------------------------------------

--31-10-2023 

-- NON EQVI JOIN

create table tblStudent 
(	
sid int primary key,
sname VARCHAR(15)
)

CREATE TABLE tblSubject
(
	subid int primary key,
	subname varchar(15)
)
CREATE TABLE tblStuMarks
(
	sid int FOREIGN KEY REFERENCES tblStudent(sid),
	subid  int FOREIGN KEY REFERENCES tblSubject(subid),
	marks int
)

create table tblGradedtl
(
	lbound int,
	ubound int,
	grade char(1)
)
-----------------------------------------------------------------

SELECT * FROM tblStudent
SELECT * FROM tblGradedtl
SELECT * FROM tblStuMarks
SELECT * FROM tblSubject

--query o/p :  SNAME | SUBNAME | MARKS | GRADE

select sname,subname,marks,grade
from tblStuMarks m INNER JOIN tblStudent s ON s.sid=m.sid
INNER JOIN tblSubject u ON u.subid=m.subid
INNER JOIN tblGradedtl g ON marks BETWEEN lbound and ubound




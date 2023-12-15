SELECT * FROM tblDepartment

SELECT * FROM tblEmployee

USE payroll;

create TABLE tblDepartment(
Depid INT PRIMARY KEY,
Depname VARCHAR(20) NOT NULL,
Location VARCHAR(20) NOT NULL)

create TABLE tblEmployee(
EmpId INT PRIMARY KEY IDENTITY(101,1),
EmpName VARCHAR(20) NOT NULL,
Designation VARCHAR(20) NOT NULL,
JoiningDate DATETIME NOT NULL DEFAULT GETDATE(),
Emailid VARCHAR(20) NOT NULL UNIQUE,
Phone BIGINT NOT NULL ,
Salary INT NOT NULL CHECK (Salary>15000),
Depid int FOREIGN KEY REFERENCES tblDepartment(Depid)
)


INSERT INTO tblDepartment values (10,'Software','Mysore')
INSERT INTO tblDepartment values (20,'HR','chennai')
INSERT INTO tblDepartment values (30,'Marketing','banglore')
INSERT INTO tblDepartment values (40,'Sales','delhi')
INSERT INTO tblDepartment values (50,'Finance','gujrat')


--------------------------------------------------------------------------------
--1.Insert 10 records into each table. 

INSERT INTO tblEmployee (EmpName,Designation,JoiningDate,Emailid,Phone,Salary,Depid) values ('pooja','software engineer','2023-01-12','po@gmail.com',9426272542,800000,10)
INSERT INTO tblEmployee (EmpName,Designation,JoiningDate,Emailid,Phone,Salary,Depid) values ('karishma','team lead','2021-11-16','kkc@gmail.com',7865432134,90000,10)
INSERT INTO tblEmployee (EmpName,Designation,JoiningDate,Emailid,Phone,Salary,Depid) values ('anjali','Coordinator','2020-07-13','anjli@gmail.com',8795574534,40000,30)
INSERT INTO tblEmployee (EmpName,Designation,JoiningDate,Emailid,Phone,Salary,Depid) values ('bhoomika','HR head','2022-05-19','bhu@gmail.com',9878767654,23000,20)
INSERT INTO tblEmployee (EmpName,Designation,Emailid,Phone,Salary,Depid) values ('pavithra','Business analyst','pavi@gmail.com',9878542167,800000,10)
INSERT INTO tblEmployee (EmpName,Designation,JoiningDate,Emailid,Phone,Salary,Depid) values ('deepika','Sales Associate','2023-01-23','deep@gmail.com',9158657389,17000,40)
INSERT INTO tblEmployee (EmpName,Designation,JoiningDate,Emailid,Phone,Salary,Depid) values ('steleena','Finance Analyst','2022-02-22','stel@gmail.com',9876785434,50000,50)
INSERT INTO tblEmployee (EmpName,Designation,Emailid,Phone,Salary,Depid) values ('anusha','Accountant Executive','anu@gmail.com',8765456787,25000,40)
INSERT INTO tblEmployee (EmpName,Designation,JoiningDate,Emailid,Phone,Salary,Depid) values ('ramya','Marketing Analyst','2021-02-25','ram@gmail.com',7896543456,40000,30)
INSERT INTO tblEmployee (EmpName,Designation,JoiningDate,Emailid,Phone,Salary) values ('kavya','software engineer','2020-01-11','kav@gmail.com',7689542314,60000)


--------------------------------------------------------------------------------
--2.Display Table information. 

SELECT * FROM tblDepartment

SELECT * FROM tblEmployee

SELECT 
	*
FROM 
	tblEmployee
WHERE 
	EmpName='pavithra H B'
--------------------------------------------------------------------------------

--3. Display Employee’s name,  EmployeeId, departmentId  from tblEmployee 

SELECT 
	EmpName,
	EmpId,
	Depid
FROM 
	tblEmployee;

--------------------------------------------------------------------------------

--4. Display Employee’s name,  EmployeeId, departmentId  of department 20 and 40. 

SELECT 
	Employee_FirstName,
	EmpId,
	Depid
FROM 
	Employees
WHERE 
	Depid IN (20,30)

--------------------------------------------------------------------------------
--5.Display information about all ‘ Sales Associate’  having salary less than 20000. 
 
 SELECT 
	*
 FROM 
	tblEmployee
 WHERE 
	Designation='Sales Associate' 
	AND Salary<20000


 --------------------------------------------------------------------------------
 --6. Display information about all employees of department 30 having salary greater than 
--20000. 

SELECT 
	* 
FROM 
	tblEmployee
WHERE 
	Depid=30	
	AND Salary>20000

--------------------------------------------------------------------------------
 --7. Display list of employees who are not allocated with Department. 

 SELECT 
	*
 FROM 
	tblEmployee
 WHERE 
	Depid IS  NULL

 --------------------------------------------------------------------------------
 --8.Display name and department of all ‘ Business Analysts’. 

SELECT 
	EmpName,
	Depid
FROM 
	tblEmployee
WHERE 
	Designation='Business Analyst'

 --------------------------------------------------------------------------------
 --9.Display name, Designation and salary of all the employees of department 30 who earn 
--more than 20000 and less than 40000. 

SELECT 
	EmpName,
	designation,
	Salary
FROM 
	tblEmployee
WHERE 
	Depid=30 
	AND SALARY BETWEEN 20000 AND 40000


--------------------------------------------------------------------------------
--10.Display unique job of tblEmployee. 

SELECT 
	DISTINCT Designation
FROM 
	tblEmployee

--------------------------------------------------------------------------------
--11.Display list of employees who earn more than 20000 every year of department 20 and 30.

SELECT 
	*,
	Salary*12 AS Annualsalary
FROM 
	tblEmployee
WHERE  
	Depid IN (20,30) 
	AND SALARY*12>20000


--------------------------------------------------------------------------------
--12.  List Designation, department no and Joined date in the format of Day, Month, and Year of 
--department 20. 

SELECT 
	Designation,
	Depid,
	FORMAT(JoiningDate,'yyyy') AS [DATE],
	--CONVERT ()
	DATEPART(DAY,JoiningDate) as day ,
	DATEPART(MONTH,JoiningDate) as month ,
	DATEPART(YEAR,JoiningDate) as year,DATENAME(WEEKDAY,JoiningDate) as Weekday
FROM 
	Employees
WHERE 
	Depid=20

SELECT * FROM Employees


SELECT FORMAT(CAST('2023-12-11 19:57:34.334' AS datetime),
			'dd MM yyyy HH mm ss') AS [DATE]
			'dd MM yyyy hh mm ss'
SELECT CAST('2023-12-11 19:57:34.666' AS datetime)

--------------------------------------------------------------------------------
--13.Display employees whose name starts with an vowel 

SELECT EmpName
FROM tblEmployee
WHERE EmpName LIKE '[aeiou]%'

--------------------------------------------------------------------------------
--14.Display employees whose name is less than 10 characters 

SELECT * 
FROM tblEmployee
WHERE len(EmpName)<10  

--------------------------------------------------------------------------------
--15.Display employees who have ‘N’ in their name 

SELECT EmpId,EmpName
FROM tblEmployee
WHERE EmpName LIKE '%N%'

--------------------------------------------------------------------------------
--16.Display the employees with more than three years of experience 


SELECT * 
FROM tblEmployee
WHERE DATEDIFF(YYYY,JoiningDate,GETDATE()) >3



--------------------------------------------------------------------------------
--17.Display employees who joined on Monday 

SELECT *
FROM tblEmployee
WHERE DATENAME(WEEKDAY,JoiningDate)='Monday'

--------------------------------------------------------------------------------
--18.Display employees who joined on 1st. 

SELECT *
FROM tblEmployee
WHERE DATEPART(DAY,JoiningDate)=1


----------------------------------------------------------------------------------
--19.Display all Employees joined in January 

SELECT *
FROM tblEmployee
WHERE DATEPART(MONTH,JoiningDate)=1

SELECT * FROM tblEmployee

--OR

SELECT *
FROM tblEmployee
WHERE DATENAME(MONTH,JoiningDate)='January'

--------------------------------------------------------------------------------
--20.Display Employees with their Initials. 

SELECT *
FROM tblEmployee
WHERE EmpName LIKE '% %'

---------------------------------------------------------------------------------

Create TABLE tblSubjectDtl
(SubID INT PRIMARY KEY IDENTITY(100,1),
SubName VARCHAR(20) NOT NULL)


INSERT INTO tblSubjectDtl (SubName)Values('SQL')

INSERT INTO tblSubjectDtl (SubName)Values('JAVA')

INSERT INTO tblSubjectDtl (SubName)Values('PYTHON')

INSERT INTO tblSubjectDtl (SubName)Values('C')

INSERT INTO tblSubjectDtl (SubName)Values('JS')


SELECT * 
FROM tblSubjectDtl


------------------------------------------------------------------------------------
CREATE TABLE tblStudentDtl
(StudentID INT PRIMARY KEY IDENTITY(1,1),
StudentName VARCHAR(20) NOT NULL)



INSERT INTO tblStudentDtl (StudentName)Values('pooja')
INSERT INTO tblStudentDtl (StudentName)Values('karishma')
INSERT INTO tblStudentDtl (StudentName)Values('bhoomika')
INSERT INTO tblStudentDtl (StudentName)Values('anjali')
INSERT INTO tblStudentDtl (StudentName)Values('pavithra')


SELECT * 
FROM tblStudentDtl


------------------------------------------------------------------------------------
CREATE TABLE tblStudentSubMarks
( StudentID INT FOREIGN KEY REFERENCES tblStudentDtl(StudentID),
SubID INT FOREIGN KEY REFERENCES tblSubjectDtl(SubID),
Marks DECIMAL
CONSTRAINT UC_COMPOSITE PRIMARY KEY(StudentID,SubID))

INSERT INTO tblStudentSubMarks Values(1,100,98)
INSERT INTO tblStudentSubMarks Values(2,100,97)
INSERT INTO tblStudentSubMarks Values(3,102,96)
INSERT INTO tblStudentSubMarks Values(3,103,95)
INSERT INTO tblStudentSubMarks Values(5,104,94)



  

----------------------------------------------------------------------------
SELECT * FROM tblEmployee


UPDATE tblEmployee set Depid=NULL WHERE Designation='software engineer'

ALTER TABLE tblEmployee ADD Bonus int 

UPDATE tblEmployee SET Bonus=10000 WHERE DATEDIFF(YYYY,JoiningDate,GETDATE()) >=2
UPDATE tblEmployee SET Bonus=0 WHERE DATEDIFF(YYYY,JoiningDate,GETDATE()) <2

select *,Salary+Bonus as [Total Salary] from tblEmployee 
select * from tblEmployee 


alter table tblEmployee drop Bonus


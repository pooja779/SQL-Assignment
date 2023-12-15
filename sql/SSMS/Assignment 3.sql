USE payroll;
SELECT * FROM tblDepartment
SELECT * FROM Employees

--1.Display all the employees data by sorting the date of joining in the ascending order and 
--then by name in descending order. 

SELECT * 
FROM tblEmployee
ORDER BY JoiningDate,EmpName DESC

--2.Modify the column name EmployeeName to Employee_FirstName and also add another 
--column Employee_LastName  

EXEC sp_rename 'tblEmployee.EmpName','Employee_FirstName','COLUMN'

--3.Write a query to change the table name to Employees.

EXEC sp_rename 'tblEmployee','Employees'

SELECT * FROM Employees
SELECT * FROM tblDepartment

--4.Write a query to update the salary of those employees whose location is ‘Mysore’ to 35000. 
update Employees 
set salary='35000'
where location='Mysore'

--5.Write a query to disassociate all trainees from their department  
update Employees
set Depid=null
where designation='software engineer'

--6.Write a query which adds another column ‘Bonus’ to the table Employees where the bonus 
--is equal to the salary multiplied by ten. Update the value only when the experience is two 
--years or above. 

ALTER TABLE Employees ADD Bonus MONEY

ALTER TABLE Employees DROP COLUMN Bonus
SELECT * FROM Employees
UPDATE Employees SET Bonus=Salary*10
WHERE DATEDIFF(YYYY,JoiningDate,GETDATE())>=2

SELECT *,ISNULL(Bonus,0)
FROM Employees




--7.Display name and salary of top 5 salaried employees from Mysore and Hyderabad. 
select Top 5 salary,Employee_firstname
from employees
where location='Mysore' and location='Hyderabad'


--8.Display name and salary of top 3 salaried employees(Include employees with tie)

SELECT TOP 3 WITH TIES Salary,Employee_FirstName
FROM Employees
ORDER BY Salary DESC

--9.Display top 1% salaried employees from Noida and Bangalore 
select TOP 1 PERCENT salary,Employee_Firstname
from employees
where location='Mysore' and location='Banglore'


--10.Find average and total salary for each job. 

SELECT Designation,AVG(Salary) as [Average Salary],SUM(Salary) as [Total Salary]
FROM Employees
GROUP BY(Designation)


--11.Find highest salary of all departments. 

SELECT MAX(Salary) as [Maximum Salary] ,Depid
FROM Employees
GROUP BY Depid

--12. Find minimum salary of all departments. 

SELECT MIN(Salary) as [Minimum Salary] ,Depid
FROM Employees 
GROUP BY Depid


--13. Find difference in highest and lowest salary for all departments. 

SELECT Depid,MAX(Salary)-MIN(Salary) AS ['difference']
FROM Employees
GROUP BY Depid

--14.  Find average and total salary for trainees 

SELECT * FROM Employees

SELECT Designation,AVG(Salary) as [Average Salary],SUM(Salary) AS [Total Salary]
FROM Employees
WHERE Designation='software engineer'
Group BY Designation

--INCORRECT OP

--15.  Count total different jobs held by dept no 30 

SELECT * FROM Employees

SELECT COUNT(DISTINCT Designation) AS [Count of Jobs]
FROM Employees
WHERE Depid=30


--16. Find highest and lowest salary for non-managerial job 

select designation,max(salary),min(salary)
from employees

--17.Count employees and  average annual salary of each department. 

SELECT Depid,Count(EmpId) as [Count employees],AVG(Salary*12)
FROM Employees
GROUP BY Depid

--18.Display the number of employees sharing same joining date. 

SELECT COUNT(EmpId) AS [No.Of Employees],JoiningDate
FROM Employees
Group by JoiningDate
--PENDING


select count(*)
from EMPLOYEES a
where JoiningDate in (select JoiningDate from EMPLOYEES where a.EmpId != EmpId)


--19.Display number of employees with same experience 


SELECT COUNT(EmpId) AS [No.Of Employees],
FROM Employees
Group by JoiningDate

--PENDING
select count(*)
from EMPLOYEES a
where JoiningDate in  (select JoiningDate from EMPLOYEES where a.EmpId != EmpId)



--20.Display total number of employees in each department with same salary 

SELECT COUNT(Empid) as [No.Of Employees],Depid
FROM Employees
GROUP BY Depid,Salary
HAVING COUNT(Salary)>1


SELECT * FROM Employees

--21.Display the  number of Employees above 35 years in each department 

SELECT COUNT(Empid) as [No.Of Employees]
FROM Employees
WHERE DATEDIFF(YYYY,JoiningDate,GETDATE())>35

 --------------------------------------------------------------------------------------------
 select * from Employees
  select * from tblDepartment

  select e.Employee_FirstName,d.Depname
  from Employees e left join tblDepartment d
  on e.Depid=d.Depid
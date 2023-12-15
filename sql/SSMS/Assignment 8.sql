-- 03-11-2023

--ASSIGNMENT 8
DECLARE @COUNT INT
SET @COUNT =1
WHILE @COUNT<20
BEGIN 
	PRINT 'ACQUIRE SKILLS'
	SET @COUNT=@COUNT+1
	IF @COUNT>10
		break
	ELSE
	 CONTINUE
END

--TO CHECK NO IS GIVEN EVEN OR ODD

DECLARE @NUM INT = 2
BEGIN
	IF(@NUM%2=0)
		PRINT 'The Given Number Is Even'
	ELSE
		PRINT 'The Given Number Is ODD'
END 


--FIBONACCI SERIES

DECLARE @NUM1 BIGINT=0, @NUM2 BIGINT =1--@COUNT INT =1 
DECLARE @COUNTER INT =1
PRINT @NUM1
PRINT @NUM2
BEGIN
WHILE (@COUNTER<=48)
	BEGIN
	
		DECLARE @NUM3 BIGINT = @NUM1 + @NUM2
		PRINT @NUM3
	
		SET @NUM1 = @NUM2
		SET @NUM2 = @NUM3
		SET @COUNTER +=1
		--SET @COUNTER = @COUNTER +1
	END

END

DECLARE @NUMBER INT =1
SELECT @NUMBER




--GENERATE FIRST 100 EVEN NUMBERS

DECLARE @NUM INT 

--------------------------------

--display emp with their locations as tier - 1 or tier - 2 with their cities

DECLARE @MARKS INT =10
SELECT @MARKS,
CASE 
	WHEN @MARKS BETWEEN 90 AND 100 THEN '9'
	WHEN @MARKS BETWEEN 80 AND 89 THEN '8'
	WHEN @MARKS BETWEEN 70 AND 79 THEN '7'
	WHEN @MARKS BETWEEN 60 AND 69 THEN '6'
	WHEN @MARKS BETWEEN 50 AND 59 THEN '5'
   
    ELSE 'FAIL'
END

----------------------------------------------------------------------------

DECLARE @TMonth varchar(25)
select @TMonth=DATENAME(MONTH,GETDATE())
IF @TMonth='NOVEMBER'
	SELECT EMPLOYEE_FirstName,Salary,Salary+10000 as SalaryWithBonus
	FROM Employees
ELSE
	PRINT 'NO bonus in this month'
	PRINT @TMonth

--------------------------------------------------------------------------

DECLARE @Month varchar(25)
set @Month=DATENAME(MONTH,GETDATE())
select @Month


--------------------------------------------------------------------------
-- T-SQL ASSIGNMENT

--1.Write T-SQL block to generate Fibonacci series 

DECLARE @NUM1 BIGINT=0, @NUM2 BIGINT =1--@COUNT INT =1 
DECLARE @COUNTER INT =1
PRINT @NUM1
PRINT @NUM2
BEGIN
WHILE (@COUNTER<=48)
	BEGIN
	
		DECLARE @NUM3 BIGINT = @NUM1 + @NUM2
		PRINT @NUM3
	
		SET @NUM1 = @NUM2
		SET @NUM2 = @NUM3
		SET @COUNTER +=1
		--SET @COUNTER = @COUNTER +1
	END

END


--2.Create student and result table and perform the following: 
USE payroll
select * from tblStudentDtl 
select * from tblStudentSubMarks
select * from tblSubjectDtl

--3.Write query to find the grade of a student, if he scores above 90 its 'A’, 
--above 80 'B', above 70 ‘C’, above 60 ‘D’, above 50 ‘F’ or else print 
--failed.(Hint: Use Case ) 

select s.StudentName,s.StudentID,g.marks,
case
When marks >=90 then 'A'
when marks>=80 then 'B'
when marks>=70 then 'c'
when marks >=60 then 'D'
when marks >=50 then 'f'
else 'failed'
end as Grade
from tblStudentSubMarks G,tblStudentDtl S

--4.Display month on which the employee is joined. Use case statement. 
USE payroll;
SELECT * FROM Employees;
 select Employee_FirstName, JoiningDate,
 case
 when DatePart(Month,JoiningDate)=1 then 'january'
 when DatePart(Month,JoiningDate)=2 then 'february'
 when DatePart(Month,JoiningDate)=3 then 'march'
 when DatePart(Month,JoiningDate)=4 then 'april'
 when DatePart(Month,JoiningDate)=5 then 'may'
 when DatePart(Month,JoiningDate)=6 then 'june'
 when DatePart(Month,JoiningDate)=7 then 'july'
 when DatePart(Month,JoiningDate)=8 then 'august'
 when DatePart(Month,JoiningDate)=9 then 'september'
 when DatePart(Month,JoiningDate)=10 then 'october'
 when DatePart(Month,JoiningDate)=11 then 'november'
 else
	  'december'
END AS joindate
from Employees


select datename(MONTH,)
from Employees

--5.Write T-SQL statements to generate 10 prime numbers greater than 1000. 
  DECLARE @i INT = 1
    DECLARE @j INT = 2
    DECLARE @COUNT1 INT
    BEGIN
    WHILE @j <= 10
        BEGIN
            SET @COUNT1 = 0
            WHILE @i <= @j
                BEGIN
                    BEGIN
                        IF((@j % @i) = 0)
                            SET @COUNT1 += 1
                    END
                    SET @i += 1
                END
            BEGIN
                IF (@COUNT1 = 2)
                    PRINT @j
            END
            SET @j += 1
        END
    END
    ;

--6.Consider HR Database and generate bonus to employees as below: 
--A)one month salary  if Experience>10 years  
--B)50% of salary  if experience between 5 and 10 years  
--C)Rs. 5000  if Eexperience less than 5 years 
 
 Update Employees	
SET Bonus =
CASE
WHEN DATEDIFF(YY,GETDATE(),JoiningDate)>10 then salary
WHEN DATEDIFF(YY,GETDATE(),JoiningDate) BETWEEN 5 AND 10 THEN 0.5*SALARY
ELSE 5000
END

--7.Consider Banking database and Create a procedure to list the customers 
--with more than the specified minimum balance as on the given date. 




--8.Based on balance categorize the customers as below: 
--a.if the balance is greater than minimum balance declare them as 
--‘Premium Customer' 
--b.if the balance is less than 0, 'Overdue Customer' 
--c.Else 'NON Premium Customer' 
--ASSIGNMENT 9

--1. What are types of Variables and mention the difference between them

---> There are 2 types of variables local and global variables 
--	local variables scope is within the session or inside the object of the database
--	global variables

--	syntax : 
--	local variable : @var_name
--	global variable : @@var_name



--2. Declare a variable with name [SQLData] which can store a string datatype 
--	and assign a value to using SELECT option and specify an alias name for the same


--	DECLARE @SQLData VARCHAR(10)
--	SELECT @SQLData = 'tblEmployee' 


--3. What is used to define a SQL variable to put a value in a variable?
--	a. SET @id = 6;
--	b. SET id = 6;
--	c. Id = 6;
--	d. SET #id = 6;

--Select the correct option :--> Option a.

--4. Compare Local and Global Temporary tables with an Example

--5. Create a table with an IDENTITY column whose Seed value is 2 and Increment value of 100

--CREATE TABLE tblEmployee(EmpID INT IDENTITY(2,100) PRIMARY KEY,EmpName VARCHAR(15))

--6. What is the difference between SCOPE_IDENTITY() and @@IDENTITY. Explain with an Example.

--The Difference between SCOPE_IDENTITY() and @@IDENTITY is that
--SCOPE_IDENTITY() will return the last value inserted by the identity in the table
--SCOPE_IDENTITY() will keep on changing whenever new rows are inserted
--but SCOPE_IDENTITY() will always take the last inserted value by the identity,
-- and @@IDENTITY is the global variable

--7.	
--Assignment Questions
create database assignment_sp
USE assignment_sp;
CREATE TABLE tblProject
(
   ProjectId BIGINT PRIMARY KEY,
   Name VARCHAR(100) NOT NULL,
   Code NVARCHAR(50) NOT NULL,
   ExamYear SMALLINT NOT NULL
);


CREATE TABLE tblExamCentre 
(
  ExamCentreId BIGINT PRIMARY KEY,
  Code VARCHAR(100) NULL,
  Name VARCHAR(100)  NULL
);

CREATE TABLE tblProjectExamCentre
(
   ProjectExamCentreId BIGINT PRIMARY KEY,
   ExamCentreId BIGINT NOT NULL FOREIGN KEY REFERENCES tblExamCentre(ExamCentreId),
   ProjectId BIGINT FOREIGN KEY REFERENCES tblProject(ProjectId)
);





INSERT INTO tblProject(ProjectId,Name,Code,ExamYear) VALUES
(1,	'8808-01-CW-YE-GCEA-2022',	'PJ0001',	2022),
(2,	'6128-02-CW-YE-GCENT-2022',	'PJ0002',	2022),
(3, '7055-02-CW-YE-GCENA-2022','PJ0003',	2022),
(4,	'8882-01-CW-YE-GCEA-2022','	PJ0004',	2022),
(5,'7062-02-CW-YE-GCENT-2022',	'PJ0005',	2022),
(8,	'6128-02-CW-YE-GCENT-1000',	'PJ0008',	1000),
(9,	'7062-02-CW-YE-GCENT-5000',	'PJ0009',	5000),
(10,'8808-01-CW-YE-GCEA-2023',	'PJ0010',	2023),
(11,'8808-01-CW-YE-GCEA-2196',	'PJ0011',	2196),
(15,'6073-02-CW-YE-GCENA-2022',	'PJ0015',	2022),
(16,'8808-01-CW-YE-GCE0-2022',	'PJ0016',	2022);


INSERT INTO tblExamCentre(ExamCentreId,Name,Code) VALUES
(112,'VICTORIA SCHOOL-GCENA-S','2711'),
(185,'NORTHBROOKS SECONDARY SCHOOL-GCENA-S','2746'),
(227,'YIO CHU KANG SECONDARY SCHOOL-GCENA-S','2721'),
(302,'CATHOLIC JUNIOR COLLEGE','9066'),
(303,'ANGLO-CHINESE JUNIOR COLLEGE','9067'),
(304,'ST. ANDREW''S JUNIOR COLLEGE','9068'),
(305,'NANYANG JUNIOR COLLEGE','9069'),
(306,'HWA CHONG INSTITUTION','9070'),
(1,NULL,'2011'),
(2,'NORTHBROOKS SECONDARY SCHOOL-GCENA-S',NULL);


INSERT INTO tblProjectExamCentre(ProjectExamCentreId,ProjectId,ExamCentreId) VALUES
(44,1,112),
(45,1,227),
(46,1,185),
(47,2,112),
(48,2,227),
(49,2,185),
(50,3,112),
(51,3,227),
(52,3,185),
(69,4,112);

select * from tblProject
select * from tblExamCentre
select * from tblProjectExamCentre



--1.Write a procedure to fetch the ProjectId, ProjectName, ProjectCode, ExamCentreName and ExamCentreCode from the tables tblProject and 
--tblExamCentre based on the ProjectId and ExamCentreId passed as input parameters.
select * from tblProject P
select * from tblExamCentre E
select * from tblProjectExamCentre PE

CREATE PROCEDURE usp_ToFetchDetails 
@ProjectId BIGINT,
@ExamCentreId BIGINT

AS
	BEGIN
		SELECT  PE.ProjectId,P.Name AS ProjectName,P.Code AS ProjectCode,E.Name AS ExamCentreName,E.Code AS ExamCentreCode
		FROM tblProjectExamCentre PE INNER JOIN tblProject P ON PE.ProjectId=P.ProjectId
		INNER JOIN tblExamCentre E ON PE.ExamCentreId=E.ExamCentreId
		WHERE PE.ProjectId=@ProjectId AND PE.ExamCentreId=@ExamCentreId

	END

EXEC usp_ToFetchDetails 5,112


--2.Write a procedure to insert values into the table tblProject when the data for the ProjectId 
--which is being inserted does not exist in the table.
select * from tblProject
select * from tblExamCentre
select * from tblProjectExamCentre


CREATE PROCEDURE usp_Insert
@ProjectId BIGINT,
@Name VARCHAR(100) ,
@Code NVARCHAR(50) ,
@ExamYear SMALLINT 
AS
	BEGIN
		--

		IF(@ProjectId NOT IN(SELECT ProjectId FROM tblProject))
			INSERT INTO tblProject(ProjectId,Name,Code,ExamYear) VALUES(@ProjectId,@Name,@Code,@ExamYear)
		ELSE
			print 'ProjectId already Exists'

	END

EXEC usp_Insert 17,'Saras','PJ1010',2023



--3.Write a procedure to update the columns-Code and Name in tblExamCentre when either of the Code or the Name column is NULL 
--and also delete the records from the table tblProjectExamCentre when ProjectId IS 4.

select * from tblProject
select * from tblExamCentre
select * from tblProjectExamCentre

CREATE PROCEDURE usp_Change

AS
	BEGIN

			UPDATE tblExamCentre SET Code=222,Name='ES' WHERE Code IS NULL OR Name IS NULL
			DELETE FROM tblProjectExamCentre WHERE  ProjectId = 4
	END 


EXEC usp_Change 



--4.Write a procedure to fetch the total count of records present in the table tblProject based on the
--ProjectId AS OUTPUT parameter
--and also sort the records in ascending order based on the ProjectName.

select * from tblProject
select * from tblExamCentre
select * from tblProjectExamCentre

--ALTER PROCEDURE usp_Count
--@COUNT INT OUTPUT
--AS
--	BEGIN
			
--			SELECT @COUNT = (SELECT COUNT(ProjectId) from tblProject)
--			SELECT @COUNT
--			--SET @ProjectId = (SELECT COUNT(ProjectId) from tblProject )
--			SELECT * FROM tblProject ORDER BY Name 

--	END

----DECLARE @COUNT INT
----EXEC usp_Count  @COUNT = @COUNT OUTPUT
----SELECT @COUNT
--EXEC usp_Count

CREATE PROCEDURE usp_Count1

AS
	BEGIN
			
			SELECT COUNT(*) from tblProject
		
			SELECT * FROM tblProject ORDER BY Name 

	END


EXEC usp_Count1




--5.Write a procedure to create a Temp table named Students with columns- StudentId,StudentName and Marks where the 
--column StudentId is generated automatically 
--and insert data into the table and also retrieve the data.

CREATE PROCEDURE usp_CreateTbl 

	AS
		BEGIN

					CREATE TABLE #Students
					(
						StudentId INT IDENTITY(100,1) PRIMARY KEY,
						StudentName VARCHAR(20),
						Marks SMALLINT 
					)

					INSERT INTO #Students (StudentName,Marks)  VALUES ('pooja',99)
					INSERT INTO #Students (StudentName,Marks)  VALUES ('bhoomika',98)
					INSERT INTO #Students (StudentName,Marks)  VALUES ('anjali',97)
					INSERT INTO #Students (StudentName,Marks)  VALUES ('pavithra',96)
					INSERT INTO #Students (StudentName,Marks)  VALUES ('prajwal',95)
					
					SELECT * FROM #Students

		END

EXEC usp_CreateTbl




--6.Write a procedure to perform the following DML operations on the column -
--ProjectName in tblProject table by using a varibale. 
--Declare a local variable and initialize it to value 0, 
--1. When the value of the variable is equal to 2, then insert another record into the table tblProject.
--2. When the value of the variable is equal to 10, then change the ProjectName to 'Project_New' for input @ProjectId


select * from tblProject
select * from tblExamCentre
select * from tblProjectExamCentre

CREATE PROCEDURE usp_insertproject
@VAR INT=0,@ProjectId INT
	AS
		BEGIN
					IF(@VAR=2)
						BEGIN
								PRINT 'Before insert operation'
								select * from tblProject
								INSERT INTO tblProject (ProjectId,Name,Code,ExamYear) VALUES(@ProjectId,'Pegasus','PJ123',2021)
								PRINT 'A new record is inserted in the tblProject'
								select * from tblProject
						END
					ELSE 
						PRINT 'variable value is not 2, so no insert operation' 


					IF(@VAR=10) 
						BEGIN
								UPDATE tblProject SET Name='' where ProjectId=@ProjectId

						END
					ELSE 
						PRINT 'variable value is not 10, so no update operation' 

				
		END


EXEC usp_insertproject 1,8




--In the next part of the stored procedure, return all the fields of the table tblProject(ProjectId,ProjectName,Code and Examyear)
--based on the ProjectId and for the column ExamYear display it as given using CASE statement.
--1.If the ExamYear is greater than or equal to 2022 then display 'New'
--2.If the ExamYear is lesser than or equal to 2022 then display 'Old'

select * from tblProject
select * from tblExamCentre
select * from tblProjectExamCentre

 CREATE PROCEDURE USP_QUESTION13
 @PROJECTID INT
 AS
 BEGIN
 SELECT PROJECTID,Name,Code,
 CASE
 WHEN EXAMYEAR>='2022' THEN 'NEW'
 WHEN EXAMYEAR<='2022' THEN 'OLD'
 END AS EXAMYEAR
 FROM TBLPROJECT
 WHERE PROJECTID=@PROJECTID
 END

 
 execute USP_QUESTION13 @PROJECTID=1
 execute USP_QUESTION13 @PROJECTID=2
  execute USP_QUESTION13 @PROJECTID=8



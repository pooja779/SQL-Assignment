CREATE DATABASE Assignment_12;

USE Assignment_12

CREATE TABLE tblDepartments
(
	DepartmentID INT PRIMARY KEY IDENTITY,
	DepartmentName VARCHAR(20)
)

INSERT INTO tblDepartments (DepartmentName) VALUES('CSE'),('ISE'),('ECE'),('IS')
SELECT * FROM  tblDepartments

CREATE TABLE tblStudentMaster
(
	Id INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(20),
	DateOfJoin DATE,
	DepartmentID INT REFERENCES tblDepartments(DepartmentID)
)
INSERT INTO tblStudentMaster (Name,DateOfJoin,DepartmentID) VALUES('Ravi','2022-05-01',1),('Shanthala','2021-07-03',2),('Sunad','2021-08-09',2)
INSERT INTO tblStudentMaster
VALUES
('Sathish','05-15-2020',1),
('Balraju','10-5-2020',2),
('Chethan','1-15-2020',3),
('Prathibha','10-22-2020',4),
('Vasanth','12-20-2020',1),
('Santhosh','08-15-2020',2),
('Mahesh','07-15-2020',3),
('rani','1-15-2020',4),
('Raju','1-20-2020',1),
('Sangeetha','10-15-2020',2)
SELECT * FROM  tblStudentMaster



CREATE TABLE tblSubjects
(
	SubId INT IDENTITY(101,1) PRIMARY KEY,
	[Subject] VARCHAR(20)
)


INSERT INTO tblSubjects
VALUES
('C Program'),
('Python'),
('Computer Networks'),
('DBMS'),
('Web Technology'),
('Data Mining'),
('Big Data Analytics'),
('Arduino Programming'),
('Digital Electronics'),
('Computer Fundamental'),
('Basic Electronics'),
('Thermodynamics'),
('Kinametics'),
('Dynametics'),
('MOM')
SELECT * FROM  tblSubjects
DELETE FROM tblSubjects WHERE SubId=106

CREATE TABLE tblDepartmentSubjects
(
	SlNo INT IDENTITY PRIMARY KEY,
	DepartmentID INT REFERENCES tblDepartments(DepartmentID),
	SubId INT REFERENCES tblSubjects(SubId)

)

ALTER TABLE tblDepartmentSubjects DROP COLUMN SlNo

INSERT INTO tblDepartmentSubjects
(DepartmentID,SubId)
VALUES
(1,101),(1,102),(1,103),(1,104),(1,105),
(4,106),(4,107),(4,101),(4,102),(4,105),
(3,112),(3,113),(3,114),(3,115),(3,101),
(2,108),(2,109),(2,110),(2,111),(2,101)

SELECT * FROM tblDepartmentSubjects
INSERT INTO tblMarks
(Id,SubId,DoE,Scores)
VALUES
(1,102,'11-19-2023',70),
(1,103,'11-19-2023',20),
(1,104,'11-19-2023',30),

(2,108,'11-19-2023',70),
(2,109,'11-19-2023',40),
(2,110,'11-19-2023',30),
(2,101,'11-19-2023',30),

(3,112,'11-19-2023',70),
(3,113,'11-19-2023',40),
(3,115,'11-19-2023',30),
(3,101,'11-19-2023',30)


--FOR INSERT
--1.Each department has only five Subjects 
--2.Some subjects can be a common subject between the departments 
--3.Student can take test/assessment on the subjects as per his department 
--4.Student can attempt only once in each subject 

--FOR QUERY
------5.The Pass marks is variable, a student must pass in all subjects  to Pass 
------6.Grades are based on the percentage of scores, those above 79% would be graded as distinction 
-----Those with 60 and above percentage would be graded as first class and those who score above 
------50% are graded as second class, the remaining are classified as Just passed 
------Grades are awarded only to those who pass in all subjects 
 
--1, Create a function to List the details as shown below for the students of a given department and 
--given pass marks 




SELECT * FROM tblMarks 
SELECT * FROM  tblStudentMaster ORDER BY tblStudentMaster.DepartmentID
SELECT * FROM  tblDepartmentSubjects 

SELECT * FROM FN_DeptartmentsStudentsReport(1,37)

SELECT * FROM FN_DeptartmentsStudentsReport(2,7)

 CREATE OR ALTER FUNCTION FN_DeptartmentsStudentsReport(@DepartmentId INT, @PassMarks DECIMAL(5,3))
RETURNS @Report TABLE(StudentID INT,StudentName VARCHAR(50),TotalMarks DECIMAL(6,3),Percentage DECIMAL(5,3),PassedSubjects INT,
AttemptedSubjects INT,Result VARCHAR(50),Grade VARCHAR(50))

AS

BEGIN

INSERT INTO @Report(StudentID,StudentName,TotalMarks,Percentage,PassedSubjects,AttemptedSubjects,Result,Grade)
	SELECT DISTINCT
	S.Id,
	S.Name,

	SUM(M.Scores)  AS TotalMarks,

	SUM(M.Scores) /COUNT(DS.SubId)  AS Percentage,

	(SELECT COUNT(*) FROM tblMarks M1 WHERE M1.Id=S.Id AND M1.Scores>=35) AS PassedSubjects,

	COUNT(M.SubId)  AS AttemptedSubjects,

	(CASE

		WHEN COUNT(DS.SubId)<>(SELECT COUNT(*) FROM tblMarks M1 WHERE M1.Id=S.Id AND Scores>=35)
			THEN 'FAIL'
		ELSE 'PASS'

	END) AS Result,

	(CASE

	WHEN COUNT(DS.SubId)<>(SELECT COUNT(*) FROM tblMarks M1 WHERE M1.Id=S.Id AND Scores>=35)
	THEN 'FAIL'

	WHEN SUM(M.Scores) /COUNT(DS.SubId) >79
	THEN 'DISTINCTION'

	WHEN SUM(M.Scores) /COUNT(DS.SubId) >=60
	THEN 'FIRST CLASS'

	WHEN SUM(M.Scores) /COUNT(DS.SubId) >50
	THEN 'SECOND CLASS'

	ELSE 'just pass'

	END) AS Grade

	FROM tblStudentMaster s INNER JOIN tblDepartments D ON D.DepartmentId=s.DepartmentId
	INNER JOIN tblDepartmentSubjects DS ON D.DepartmentId=DS.DepartmentId
	LEFT OUTER JOIN tblMarks M ON s.Id=M.Id AND DS.SubId=M.SubId
	WHERE S.DepartmentID IN (1)
	GROUP BY S.Id, S.Name

RETURN

END


--tblStudentMaster,tblMarks

-- CREATE FUNCTION ufn_Details(@DepartmentID INT,@MARKS INT)
-- RETURNS TABLE AS
-- RETURN 
--    (

--		--SELECT M.Id,S.[Name],SUM(Scores) AS [Total Marks],[Total Marks]/500*100 AS [Percentage],
--		--FROM tblStudentMaster S INNER JOIN tblMarks M ON S.Id=M.Id
		--GROUP BY M.Id

		--Student ID ,
--Name ,
--Total Marks ,
--Percentage ,
--No of Subjects Passed ,
--No of Subjects attempted ,
--Result ,
--Grade ,

--WHILE EXISTS(SELECT * FROM M)
--BEGIN
--END


--SELECT 
--	*,
--	[S].[Name],
--	COALESCE(SUM([M].[Scores]) OVER (PARTITION BY [S].[id]),0) AS [ToalMarks],
--	COALESCE(SUM([M].[Scores]) OVER (PARTITION BY [S].[id]),0)/(COUNT([DS].[SubId]) OVER (PARTITION BY [S].[id])) AS [Percentage]
--	 (PARTITION BY [S].[id])
--FROM [tblStudentMaster] [S]
--	INNER JOIN [tblDepartments] [D]
--		ON [S].[DepartmentID]=[D].[DepartmentID]
--	INNER JOIN [tblDepartmentSubjects] [DS]
--		ON [DS].[DepartmentID]=[D].[DepartmentID]
--	LEFT OUTER JOIN [tblMarks] [M]
--		ON [M].[Id]=[s].[Id]
--			AND [M].[SubId]=[DS].[SubId]
--ORDER BY 
--	[D].[DepartmentID], [S].Id

--SELECT * FROM tblMarks
----SELECT * FROM  tblStudentMaster

----Taking No of Subjects attempted 
--		DECLARE @SubsAttempted INT;
--		SELECT @SubsAttempted =COUNT(*)
--		FROM tblMarks 
--		--WHERE Id=1
--		GROUP BY Id
--		SELECT @SubsAttempted


--		SELECT M.Id,[Name],SUM(M.Scores) AS [Total Marks]
--		FROM tblStudentMaster S INNER JOIN tblMarks M ON S.Id=M.Id
--		--WHERE S.DepartmentID=@DepartmentID
--		GROUP BY M.Id,[Name]
		
--	)



 


-- CREATE OR ALTER FUNCTION ufn_report(@Dept INT ,@Marks INT)
--RETURNS @reports table
--(
--	Id INT,
--	Name VARCHAR(50),
--	TotalMarks INT,
--	Percentage INT,
--	NoOfPassed INT,
--	NoOfSubjectsAttended INT,
--	Result VARCHAR(50),
--	Grade VARCHAR(50))
--AS
--BEGIN
--INSERT INTO @reports(Id,Name,TotalMarks,Percentage,NoOfPassed,NoOfSubjectsAttended,Result,Grade)
  
--SELECT X.id,x.name,SUM(X.marks),SUM(X.MARKS)*100/(COUNT(X.MARKS)*100) AS PERCENTAGE,COUNT(X.MARKS) AS ATTEMPTED,
--      COUNT(X.RESULT) AS PASSED,
--	  CASE WHEN COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'PASS'
--	  ELSE 'FAIL'
--	  END AS RESULTS,
--	  CASE 
--		  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) >80 AND COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'DISTINCTION'
--		  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) BETWEEN 70 AND 80 AND COUNT(X.MARKS)=COUNT(X.RESULT)THEN 'FIRST CLASS'
--		  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) BETWEEN 50 AND 70 AND COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'SECOND CLASS'
--		  ELSE 'just pass'
--	  END AS GRADE

--FROM 

--  (SELECT M.Id AS ID ,S.Name AS NAME ,M.SubId AS SubId,S.DepartmentId as Dept,M.Scores as marks,CASE
--																	WHEN 
--																	m.Scores>@marks THEN 1
--																	ELSE NULL
--																	END as RESULT
--  FROM tblStudentMaster S
--  INNER JOIN tblMarks M
--  ON S.Id=M.Id) X
--WHERE x.Dept=@Dept
--GROUP BY x.id,x.Name
--RETURN
--END

--SELECT * FROM ufn_report(1,7)




--CREATE or ALTER FUNCTION dbo.GetStudentDetailsByDepartment
--(
--    @DepartmentId INT,
--    @PassMarks INT
--)
--RETURNS TABLE
--AS
--RETURN
--(
--    SELECT M.Id AS 'Student ID', SM.Name, SUM(M.Scores) AS 'Total Marks',
--           (SUM(M.Scores) / COUNT(DS.SubId)) AS 'Percentage',
--           COUNT(CASE WHEN M.Scores >= @PassMarks THEN M.Id END) AS 'No of Subjects Passed', 
--           COUNT(M.SubId) AS 'No of Subjects attempted',
--           CASE WHEN COUNT(CASE WHEN M.Scores >= @PassMarks THEN M.Id END) = COUNT(M.SubId) THEN 'Pass' ELSE 'Fail' END AS 'Result',
--           CASE 
--               WHEN  ((SUM(M.Scores) / COUNT(DS.SubId)) > 79 )THEN 'Distinction'
--               WHEN  ((SUM(M.Scores) / COUNT(DS.SubId)) between 60 and 78 )THEN 'First Class'
--               WHEN  ((SUM(M.Scores) / COUNT(DS.SubId)) between 50 and 59 ) THEN 'Second Class'
--               ELSE '--'
--           END AS 'Grade'
--    FROM tblStudentMaster SM
--    INNER JOIN tblMarks M ON SM.Id = M.Id
--    Inner JOIN tblDepartmentSubjects DS ON SM.DepartmentID = DS.DepartmentId AND M.SubId = DS.SubId
--    WHERE SM.DepartmentID = @DepartmentId
--    GROUP BY M.Id, SM.Name
--)



--SELECT * FROM dbo.GetStudentDetailsByDepartment( 1,  35)
--SELECT * FROM dbo.GetStudentDetailsByDepartment( 2,  35)
--SELECT * FROM dbo.GetStudentDetailsByDepartment( 3,  35)
--SELECT * FROM dbo.GetStudentDetailsByDepartment( 4,  35)
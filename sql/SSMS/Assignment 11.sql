---- 16-11-2023
--FUNCTIONS
-- ASSIGNMENT 11


SELECT GETDATE()


SELECT CONVERT(VARCHAR(12),GETDATE(),106)

SELECT FORMAT(GETDATE(),'dd-MM-yy')


CREATE FUNCTION DisplayDate(@IDATE DATETIME)
RETURNS VARCHAR(15)
AS
BEGIN
		RETURN(CONVERT(VARCHAR(12),@IDATE,106))
END


--WRITE A USERDEFINED FUNCTION (UFD) TO DISPLAY WHO HAVE MORE THAN 10 YRS OF EXPERIENCE FOLLOWING FORMAT :
--  Empid,  Empname, JoinedDate , Experience, DepartName ,Location, Salary

CREATE FUNCTION udf_Display()
RETURNS TABLE 
AS
	

		RETURN(			select EmpId,Employee_FirstName,
						JoiningDate,DATEDIFF(YYYY,JoiningDate,GETDATE()) AS Experience,
						Depname,e.Location,Salary
						FROM Employees e INNER JOIN tblDepartment d ON e.Depid=d.Depid
						WHERE DATEDIFF(YYYY,JoiningDate,GETDATE())>10	
					
			  )
--udf_Display() 
select * from udf_Display() --to execute

create FUNCTION udf_Displayloc( @location varchar(12))
RETURNS TABLE 
AS
	

		RETURN(			select EmpId,Employee_FirstName,
						JoiningDate,DATEDIFF(YYYY,JoiningDate,GETDATE()) AS Experience,
						Depname,e.Location,Salary
						FROM Employees e INNER JOIN tblDepartment d ON e.Depid=d.Depid
						WHERE DATEDIFF(YYYY,JoiningDate,GETDATE())>10	
						AND e.Location=@location
					
			  )


--sp_refresh dbo.udf_Displayloc
select * from dbo.udf_Displayloc('chennai')
select * from Employees




--------------------------------------------------------------------------------------------------
--ASSIGNMENT 11 MOVIES

CREATE DATABASE Assignment_11
USE Assignment_11
CREATE TABLE Users
(
	UserId VARCHAR(20) PRIMARY KEY,
	UserName VARCHAR(20) NOT NULL,
	Password VARCHAR(20) NOT NULL,
	Age INT NOT NULL,
	Gender CHAR(1),
	EmailId VARCHAR(20) UNIQUE
)

ALTER TABLE Users ADD PhoneNumber NUMERIC(10) NOT NULL


CREATE TABLE TheatreDetails 
(
	TheatreId  INT PRIMARY KEY IDENTITY(1,1),
	TheatreName  VARCHAR(20) NOT NULL,
	Location  VARCHAR(20) NOT NULL,
	
)

CREATE TABLE ShowDetails  
(
	ShowId   INT PRIMARY KEY IDENTITY(1001,1),
	TheatreId  INT NOT NULL FOREIGN KEY REFERENCES TheatreDetails(TheatreId),
	ShowDate   DATE NOT NULL,
	ShowTime  TIME NOT NULL,
	MovieName VARCHAR(20) NOT NULL,
	TicketCost Decimal(6,2) NOT NULL,
	TicketsAvailable INT NOT NULL
	
)


CREATE TABLE BookingDetails 
(

	BookingId VARCHAR(5) PRIMARY KEY,
	UserId VARCHAR(20) FOREIGN KEY REFERENCES Users(UserId),
	ShowId INT FOREIGN KEY REFERENCES ShowDetails(ShowId),
	NoOfTickets INT NOT NULL,
	TotalAmt DECIMAL(6,2) NOT NULL


)


---------------------------------------------------------------------------------------------------------------------------
--Stored Procedure: usp_BookTheTicket 
--Create a stored procedure named usp_BookTheTicket to insert values into the 
--BookingDetails table. Implement appropriate exception handling. 
--Input Parameters: 
					--UserId 
					--ShowId 
					--NoOfTickets 


--Functionality: 
				--Check if UserId is present in Users table 
				--Check if ShowId is present in ShowDetails table 
				--Check if NoOfTickets is a positive value and is less than or equal to TicketsAvailable 
				--value for the particular ShowId 
				--If all the validations are successful, insert the data by generating the BookingId and 
				--calculate the total amount based on the TicketCost 
--Return Values: 
				--1, in case of successful insertion 
				---1,if UserId is invalid 
				---2,if ShowId is invalid 
				---3,if NoOfTickets is less than zero 
				---4,if NoOfTickets is greater than TicketsAvailable 
				---99,in case of any exception 



CREATE PROCEDURE usp_BookTheTicket
@userid VARCHAR(20),@showid INT,@nooftickets INT 
AS
		BEGIN
			IF(@userid EXISTS (SELECT UserId FROM Users))

			BEGIN
					IF(@showid EXISTS (SELECT ShowId FROM ShowDetails))

						BEGIN
								IF(@nooftickets >0 
										AND 
									@nooftickets <= (SELECT TicketsAvailable FROM ShowDetails WHERE @showid=ShowId) )

									BEGIN
											INSERT INTO BookingDetails(BookingId,UserId,ShowId,NoOfTickets,TotalAmt)
											VALUES ()
					
											-- SELECT * FROM BookingDetails
				
									END
				
					
						END

				
					
			END

		END

--Function: ufn_GetMovieShowtimes 
--Create a function ufn_GetMovieShowtimes to get the show details based on the MovieName 
--and Location 
--Input Parameter: 
--MovieName 
--Location 
--Functionality: 
--Fetch the details of the shows available for a given MovieName in a location 
SELECT * FROM BookingDetails
SELECT * FROM ShowDetails
SELECT * FROM TheatreDetails
SELECT * FROM Users

CREATE FUNCTION ufn_GetMovieShowtimes(
@MovieName VARCHAR (20),
@Location VARCHAR(20))
RETURNS @MOVIETABLE TABLE 

(MovieName VARCHAR(20),
ShowDate DATE,
ShowTime TIME,
TheatreName VARCHAR(20),
TicketCost DECIMAL)
AS
BEGIN
INSERT INTO @MOVIETABLE
SELECT MovieName,ShowDate ,ShowTime,TheatreName ,TicketCost 
FROM TheatreDetails JOIN ShowDetails
ON TheatreDetails.THEATREID=ShowDetails.THEATREID
WHERE MOVIENAME=@MOVIENAME OR LOCATION=@LOCATION
RETURN
END

select * from dbo.ufn_GetMovieShowtimes( 'hit man','bengaluru')

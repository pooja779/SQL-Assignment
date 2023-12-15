--Assignment 10
 
--1.Consider table tblEmployeeDtls and write a stored procedure to generate 
--bonus to employees for the given date  as below: 
--A)One month salary  if Experience>10 years  
--B)50% of salary  if experience between 5 and 10 years  
--C)Rs. 5000  if experience is less than 5 years 
--Also, return the total bonus dispatched for the year as output parameter. 
 



USE payroll


select * from Employees
select * from tblDepartment

CREATE PROCEDURE usp_Bonus
@TotalBonus INT OUTPUT
AS
	BEGIN

		UPDATE Employees SET Bonus=Salary		
		WHERE DATEDIFF(YYYY,JoiningDate,GETDATE())>10

		UPDATE Employees SET Bonus=0.5*Salary
		WHERE DATEDIFF(YYYY,JoiningDate,GETDATE()) BETWEEN 5 AND 10 

		
		UPDATE Employees SET Bonus=5000		
		WHERE DATEDIFF(YYYY,JoiningDate,GETDATE())<5


		SELECT @TotalBonus= SUM(Bonus)FROM Employees


	END 


DECLARE @TotalBonus INT 
EXEC usp_Bonus @TotalBonus OUTPUT
SELECT @TotalBonus AS [Total Bonus]



--2.Create a stored procedure that returns a sales report for a given time period 
--for a given Sales Person. Write commands to invoke the procedure 

USE Assignment_7

CREATE PROCEDURE usp_SalesManDetails
@SaleID INT,@StartDate DATE,@EndDate DATE
AS
	 BEGIN

		 SELECT sl.Sid,s.Sname,sd.Pid,SL.Sldate,SD.Quantity
		 FROM Sale sl INNER JOIN Salesman S on sl.Sid=S.Sid
		 INNER JOIN Saledetail sd ON sl.Saleid=sd.Saleid
		 INNER JOIN Product p ON sd.Pid=p.Pid
 
		 WHERE sl.Sid=@SaleID AND sl.Sldate BETWEEN @StartDate AND @EndDate

	 END

EXEC usp_SalesManDetails 103,'2020-09-23','2023-09-20'

SELECT * FROM Product
SELECT * FROM Sale
SELECT * FROM Saledetail
SELECT * FROM Salesman


--3.Also generate the month and maximum ordervalue booked by the given 
--salesman(use output parameter) 

SELECT * FROM Product
SELECT * FROM Sale
SELECT * FROM Saledetail
SELECT * FROM Salesman

USE Assignment_7


ALTER PROCEDURE usp_MaxOrderValue
@SaleID INT,@StartDate DATE,@EndDate DATE ,@month VARCHAR(15) OUTPUT,@maxvalue INT OUTPUT
AS
	 BEGIN

		 SELECT TOP 1
			@month=DATENAME(MONTH,sl.Sldate) ,@maxvalue=sum(Price) 
		 FROM 
			 Sale sl 
			 INNER JOIN Saledetail sd ON sl.Saleid=sd.Saleid
			 INNER JOIN Product p ON sd.Pid=p.Pid
 		 WHERE 
			sl.Sid=@SaleID AND sl.Sldate BETWEEN @StartDate AND @EndDate
		 GROUP BY 
			Sldate
		ORDER BY sum(Price) DESC

	 END


DECLARE @month VARCHAR(15) ,@maxvalue INT 
EXEC usp_MaxOrderValue @SaleID=103 ,@StartDate='09-23-2020',@EndDate='11-29-2023',@month=@month OUTPUT,@maxvalue=@maxvalue OUTPUT
SELECT @month AS [Month],@maxvalue AS [Maximum Ordervalue]


--4.Consider Toy Centre database 
--Procedure Name : usp_UpdatePrice 
--Description:    This procedure is used to update the price of a given product. 
 
--Input Parameters: 
--∙ProductId 
--∙Price 
--Output Parameter 
--    UpdatedPrice 
--Functionality: 
--∙Check if the product id is valid, i.e., it exists in the Products table 
--∙If all the validations are successful, update the price in the table Products appropriately 
--∙Set the output parameter to the updated price 
--∙If the update is not successful or in case of exception, undo the entire operation and set the 
--output parameter to 0 
--Return Values: 
--∙1 in case of successful update 
--∙-1 in case of any errors or exception 

USE ToyShop;
SELECT * FROM tblToys

CREATE PROCEDURE usp_UpdatePrice
@Pid CHAR(5),
@Price MONEY,
@UpdatedPrice MONEY OUTPUT
AS
BEGIN
BEGIN TRANSACTION
IF EXISTS(SELECT 1
  FROM tblToys
  WHERE ToyID = @Pid)
BEGIN
UPDATE tblToys
SET Price = @Price
WHERE ToyID = @Pid
SET @UpdatedPrice = @Price
COMMIT
RETURN 1
END
ELSE
BEGIN
ROLLBACK
RETURN -1
END
END

DECLARE @Pid CHAR(5), @Price MONEY, @UpdatedPrice MONEY
EXEC usp_UpdatePrice T101, 2000, @UpdatedPrice OUTPUT

PRINT @UpdatedPrice














--5.Procedure Name : usp_InsertPurchaseDetails 

--Description: 
				--This procedure is used to insert the purchase details into the table PurchaseDetails and 
				--update the available quantity of the product in the table Products by performing the 
				--necessary validations based on the business requirements. 

--Input Parameters: 
				--∙CustId
				--∙ToyId 
				--∙QuantityPurchased 


--Output Parameter: 

		--    transactionID 


--Functionality: 
			--∙Check if all the input parameters are not null 
			--∙Check if the Custid is valid, i.e., it exists in the Users table 
			--∙Check if the Toyid is valid, i.e., it exists in the Products table 
			--∙Check if the purchased quantity is greater than 0 
			--∙If all the validations are successful, insert the purchase details into the table 
			--transactions
			--∙Update the available quantity in the table toys appropriately 
			--∙Set the output parameter to the newly generated transactionID .If the insert or update 
			--is not successful, undo the entire operation and set the output parameter to 0 



--Return Values : 
		--∙1 in case of successful insertion and update 
		--∙-1 if EmailId is null 
		--∙-2 if EmailId is not valid 
		--∙-3 if ProductId is null 
		--∙-4 if ProductId is not valid 
		--∙-5 if the QuantityPurchased is not valid or QuantityPurchased is null 
		--∙-99 if there is any exception 
 
 use ToyShop
 select * from tblCategory
  select * from tblCustomers
  select * from tblToys
  select * from tblTransaction


 
 CREATE PROCEDURE uspToyUpdate
 @CustId INT ,@ToyID VARCHAR(10), @Quantity INT ,@TxnId INT OUTPUT

 AS

		BEGIN

			IF @CustId IS NULL 
				BEGIN
					PRINT 'Customer ID Cannot be NULL'
					RETURN -1
				END 
			IF @ToyID IS NULL 
				BEGIN
					PRINT 'Toy ID Cannot be NULL'
					RETURN -3
				END 
			IF @Quantity IS NULL 
				BEGIN
					PRINT 'Quantity Cannot be NULL'
					RETURN -5
				END 
			IF (@CustId EXISTS (SELECT CustID FROM tblCustomers))
				BEGIN
					
				END

		END

 


 
 

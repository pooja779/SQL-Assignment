CREATE DATABASE Postgre;
USE Postgre

CREATE TABLE tblUsers
(
	UserID INT PRIMARY KEY,
	UserName VARCHAR(20),
	Email VARCHAR(20) UNIQUE
)


INSERT INTO tblUsers (UserID,UserName,Email) VALUES (1001,'Akash','akash@gmail.com');


INSERT INTO tblUsers (UserID,UserName,Email) VALUES 
(1002,'Arvind','arvind@gmail.com'),
(1003,'Sakshi','sakshimys@gmail.com'),
(1004,'Kumar','kumar987@gmail.com');

SELECT * FROM tblUsers

CREATE TABLE tblCategory
(
	Category_id INT PRIMARY KEY,
	Category_name VARCHAR(20),
	[Description] VARCHAR(60) 
);

INSERT INTO tblcategory VALUES 
(201,'Electronics','One stop for electronic items'),
(202,'Apparel','Apparel is the next destination for fashion'),
(203,'Grocery','All needs in one place');

 SELECT * FROM tblcategory
 
CREATE TABLE tblProducts
(
	Product_id INT PRIMARY KEY,
	Product_name VARCHAR(20),
	Quantity INT,
	Product_price INT,
	Category_id INT REFERENCES tblCategory(Category_id)
);


INSERT INTO tblProducts VALUES 
(1,'Mobile Phone',1000,15000,201 ),
(2,'Television',500,40000,201 ),
(3,'Denims',2000,700,202 ),
(4,'Vegetables',4000,40,203 ),
(5,'Ethnic Wear',300,1500,202 ),
(6,'Wireless Earphone',5000,2500,201 ),
(7,'Lounge Wear',200,1600,202 ),
(8,'Refrigerator',50,30000,201 ),
(9,'Pulses',60,150,202 ),
(10,'Fruits',100,250,202 );

SELECT * FROM tblProducts

CREATE TABLE tblSales
(
	Sales_id INT PRIMARY KEY,
	Sales_user_id INT REFERENCES tblUsers(UserId),
	Product_id INT REFERENCES tblProducts(Product_id)

);

INSERT INTO tblSales VALUES 
(500,1001,1), 
(501,1002,1), 
(502,1003,2), 
(504,1004,3), 
(505,1004,1), 
(506,1004,1), 
(507,1002,2), 
(508,1003,1), 
(509,1001,7), 
(510,1001,8);

SELECT * FROM tblSales


-- Consider a scenario of an E-Commerce Website where users place orders for different products from 
-- different categories. The database design for the e-commerce website is as given below. 
 
-- Questions 

-- 1.Write a function to fetch the names of the product,category and users along with the cost for each 
-- product sold depending on the sales_id. 
-- Also if the cost for each product is more than 2000, then display a message stating 
-- that 'The product has gained profit'.  
-- If the product cost is between 500 and 1000, then raise a message stating that 
-- 'The product has occured loss'.  
-- If the product cost is less than 500, then raise an exception stating 'No profit no loss'. 
  
SELECT * FROM tblUsers
SELECT * FROM tblcategory
SELECT * FROM tblProducts
SELECT * FROM tblSales


CREATE OR ALTER FUNCTION ufn_sales (@SaleID INT)
RETURNS @Result TABLE(ProductName VARCHAR(100), CategoryName VARCHAR(100), UserName VARCHAR(100), ProductID INT, ProductPrice INT,status varchar(70))
AS
BEGIN
		INSERT INTO @Result
		SELECT 
			P.Product_name, 
			Category_name , 
			UserName , 
			S.Product_id , 
			Product_price,
			(CASE
				wHEN P.Product_Price>2000 THEN 'The product has gained profit'
				WHEN P.Product_Price BETWEEN 500 and 1000 THEN  'The product has occured loss'
				WHEN P.Product_Price<500 THEN 'No profit no loss'
			END) AS Satus
		FROM tblCategory C
		INNER JOIN tblProducts P ON C.Category_ID= P.Category_ID
		INNER JOIN tblSales S ON S.Product_ID= P.Product_id
		INNER JOIN tblUsers U ON U.UserID= S.Sales_user_id
		WHERE S.Sales_id= @SaleID

		RETURN
END

SELECT * FROM ufn_sales(504)

-- 2.Write a procedure to update the name of the category from 'Electronics' to 'Modern Gadgets' and 
-- also  
-- fetch the category and product names when the userid is passed as the input parameter. 
 
SELECT * FROM tblUsers
SELECT * FROM tblcategory
SELECT * FROM tblProducts
SELECT * FROM tblSales

CREATE OR ALTER PROCEDURE uspUpdate
@UserID INT
AS
BEGIN


UPDATE tblCategory
SET Category_name= 'Modern Gadgets'
WHERE Category_name= 'Electronics'

	IF EXISTS (SELECT 1 FROM tblSales WHERE Sales_user_id= @UserID)
		BEGIN
				SELECT C.Category_name, P.Product_name
				FROM tblSales S
				INNER JOIN tblProducts P ON S.Product_id = P.Product_id
				INNER JOIN tblCategory C ON P.Category_id = C.Category_id
				WHERE S.Sales_user_id = @UserID;
		END
	ELSE 
		PRINT ' '
		PRINT 'USER DOES NOT EXISTS'
END

EXEC uspUpdate 100

UPDATE tblCategory
SET Category_name= 'Electronics'
WHERE Category_name= 'Modern Gadgets'



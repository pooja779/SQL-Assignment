CREATE TABLE tblUsers
(
	User_id SERIAL PRIMARY KEY,
	User_name VARCHAR,
	Email VARCHAR UNIQUE
);


INSERT INTO tblUsers (User_id,User_name,Email) VALUES (1001,'Akash','akash@gmail.com');


INSERT INTO tblUsers (User_id,User_name,Email) VALUES 
(1002,'Arvind','arvind@gmail.com'),
(1003,'Sakshi','sakshimys@gmail.com'),
(1004,'Kumar','kumar987@gmail.com');

SELECT * FROM tblUsers

CREATE TABLE tblCategory
(
	Category_id INT PRIMARY KEY,
	Category_name VARCHAR,
	Description VARCHAR 
);

INSERT INTO tblcategory VALUES 
(201,'Electronics','One stop for electronic items'),
(202,'Apparel','Apparel is the next destination for fashion'),
(203,'Grocery','All needs in one place');

 SELECT * FROM tblcategory
 
CREATE TABLE tblProducts
(
	Product_id INT PRIMARY KEY,
	Product_name VARCHAR,
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
	Sales_user_id INT REFERENCES tblUsers(User_id),
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
 
 CREATE OR REPLACE FUNCTION ufn_purchaseDetails (in param_Salesid INT)
 RETURNS TABLE(Product VARCHAR(50),Category VARCHAR(50),UserName VARCHAR(50),Price INT)
 AS
 $$
 DECLARE CostOfProduct INT;
 BEGIN
 	RETURN QUERY
 	SELECT p.Product_name ,c.Category_name ,u.User_name,p.product_price
	 --INTO Product,Category,UserName,Price
	FROM tblSales s 
	INNER JOIN tblUsers u ON s.sales_user_id=u.User_id
	INNER JOIN tblProducts p ON s.product_id=p.product_id
	INNER JOIN tblcategory c ON p.category_id=c.category_id
	WHERE Sales_id=param_Salesid;
	
	--SELECT p.Product_name  into Product,c.Category_name into Category,u.User_name into UserName,
--	p.product_price into Price
	

	--CostOfProduct=
	 	 SELECT product_price into CostOfProduct
		 FROM tblSales s INNER JOIN tblproducts p ON s.product_id=p.product_id
		 where s.Sales_id=param_Salesid;
	 
	 RAISE NOTICE '%',( 	CASE
					   			WHEN CostOfProduct>2000 THEN 'The product has gained profit'
					   			WHEN CostOfProduct BETWEEN 500 and 1000 THEN 'The product has occured loss'
								WHEN CostOfProduct<500 THEN 'No profit no loss'
					   		END
					  	
					  );
	
 END;
 $$
 LANGUAGE PLPGSQL;
 
 SELECT ufn_purchaseDetails(504)
 
 drop function  ufn_purchaseDetails
 
--  DO
--  $$
--  DECLARE
--  CostOfProduct MONEY;
--  BEGIN

--  RAISE NOTICE '%',CostOfProduct;
--  END;
--  $$
--  LANGUAGE PLPGSQL;
 
 
 
-- 2.Write a procedure to update the name of the category from 'Electronics' to 'Modern Gadgets' and 
-- also  
-- fetch the category and product names when the userid is passed as the input parameter. 
 
SELECT * FROM tblUsers
SELECT * FROM tblcategory
SELECT * FROM tblProducts
SELECT * FROM tblsales


CREATE OR REPLACE PROCEDURE usp_Update1(param_Userid INT,INOUT Category VARCHAR(100) DEFAULT NULL,INOUT Product VARCHAR(100) DEFAULT NULL)
AS
$$
BEGIN
		UPDATE tblcategory SET Category_name='Modern Gadgets' WHERE Category_name='Electronics';
		
		--IF EXISTS (SELECT 1 FROM tblUsers WHERE User_id=param_Userid)
			--THEN
				SELECT Category_name,Product_name
				FROM tblsales s INNER JOIN tblProducts p ON s.product_id=p.product_id
				INNER JOIN tblcategory c ON p.Category_id=c.Category_id
				WHERE Sales_user_id=param_Userid 
				into Category,Product;
			--ELSE
				--RAISE NOTICE '% User ID does not exists',param_Userid;
		--END IF;
		


END;
$$
LANGUAGE PLPGSQL;

CALL usp_Update(1001)


		UPDATE tblcategory SET Category_name='Electronics' WHERE Category_name='Modern Gadgets';
		SELECT * FROM tblcategory




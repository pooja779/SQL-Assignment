USE Assessment


--1
SELECT * FROM tblBooking
SELECT * FROM tblCustomer
SELECT * FROM tblFlight

--SELECT Custid,CustName
--FROM tblCustomer  
--WHERE Custid NOT IN (SELECT Custid FROM tblBooking) 

SELECT C.Custid,CustName
FROM tblCustomer C LEFT JOIN tblBooking B ON C.Custid=B.CustId
WHERE  B.Custid IS NULL OR B.TravelClass!='Economy' 
GROUP BY C.Custid,CustName




--SELECT *
--FROM tblCustomer C LEFT JOIN tblBooking B ON C.Custid=B.CustId
----WHERE  B.Custid IS NULL OR B.TravelClass!='Economy' 
----GROUP BY C.Custid,CustName



--2
SELECT * FROM tblBooking
--SELECT * FROM tblCustomer
SELECT * FROM tblFlight


SELECT AVG(F.FlightCharge),F.TravelClass
FROM tblFlight F INNER JOIN tblBooking B ON F.FlightId=B.FlightId
INNER JOIN tblCustomer C ON B.CustId=C.Custid
GROUP BY F.TravelClass
HAVING AVG(F.FlightCharge)<F.FlightCharge








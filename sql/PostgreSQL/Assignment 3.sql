--ASSIGNMENT 3
USE sp_assignment DB
CREATE TABLE departments
(
   department_id INT PRIMARY KEY,
   department_name VARCHAR(100));

CREATE TABLE students
(
  student_id INT PRIMARY KEY,
  student_name VARCHAR(100),
  student_department INT,
  stipend INT,
  CONSTRAINT fk_student FOREIGN KEY(student_department) REFERENCES departments(department_id));
  
INSERT INTO departments VALUES
(1,'Science'),
(2,'Commerce'),
(3,'Bio-Chemistry'),
(4,'Bio-Medical'),
(5,'Fine Arts'),
(6,'Literature'),
(7,'Animation'),
(8,'Marketing');

select student_id, student_name,student_department,stipend
from students order by student_id limit 20

INSERT INTO students VALUES
(1,'Hadria',7,2000),
(2,'Trumann',2,2000),
(3,'Earlie',3,2000),
(4,'Monika',4,2000),
(5,'Aila',5,2000),
(6,'Trina',5,2000),
(7,'Esteban',3,2000),
(8,'Camilla',1,2000),
(9,'Georgina',4,2000),
(10,'Reed',6,16000),
(11,'Northrup',7,2000),
(12,'Tina',2,2000),
(13,'Jonathan',	2,2000),
(14,'Renae',7,2000),
(15,'Sophi',6,16000),
(16,'Rayner',3,2000),
(17,'Mona',6,16000),
(18,'Aloin',5,2000),
(19,'Florance',5,2000),
(20,'Elsie',5,2000);


-- --stored procedures
-- 1.Write a stored procedure to insert values into the student table ans also update the student_department to 7 when the student_id
-- is between 400 and 700.

create or replace procedure sp_insert( sid int,
						   sname varchar(20),
						   stdept int,
						   stipend int)
AS $$
BEGIN 
    insert into students(student_id,student_name,student_department,stipend)
    values(sid,sname,stdept,stipend);
	
	if sid between 400 and 700 then
	update students
	set student_department = 7
	where student_id=sid;
	end if;
END;
$$ language plpgsql

CALL sp_insert(405,'pavithra',6,3000);



-- 2.Write a procedure to update the department name to 'Animation' when the department id is 7. This command has to be committed.
-- Write another statement to delete the record from the students table based on the studentid passed as the input parameter.This statement should not be committed.

   create OR REPLACE procedure sp_updatedept(Inout SID int)
AS $$
BEGIN 
   update departments
   set department_name = 'Animation'
   where department_id = 7;
   commit;
   
   begin
   delete from students where student_id =SID;
   ROLLBACK;
   END;
   
END;
$$ language plpgsql

CALL sp_updatedept(1);

-- 3.Write a procedure to display the sum,average,minimum and maximum values of the column stipend from the students table.

create or replace procedure sp_stipend(
 INOUT "sum" int =0 ,
  INOUT "avg" int =0,
 INOUT "min" int=0,
  INOUT "max" int=0)
AS $$
BEGIN 
   select sum(stipend),avg(stipend),min(stipend), max(stipend)
    into "sum","avg","min","max"
  from students;
END;
$$
language plpgsql;

CALL sp_stipend();

-- --subqueries
-- 1.Fetch all the records from the table students where the stipend is more than 'Florence'

select * 
	  from students
	  where stipend>(select stipend
					from students
					where student_name ='Florance');

select * 
	  from students
	  where stipend>(select stipend
					from students
					where student_name like 'Florance');



-- 2.Return all the records from the students table who get more than the minimum stipend for the department 'FineArts'.

 select * 
  from students
  where stipend > (select min(stipend) 
				  from students
				  where student_department = (select department_id 
											 from departments
											 where department_name = 'Fine Arts'));

select * from students
select * from departments

-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- Questions based on the employee table 
-- 1.Using a subquery, list the name of the employees, paid more than 'Fred Costner' from employees.
 select * 
  from students
  where stipend > (select min(stipend) 
				  from students
				  where student_department = (select department_id 
											 from departments
											 where department_name = 'Fine Arts'));


-- 2.Find all employees who earn more than the average salary in their department.

select * from employees where salary >(select avg(salary) from employees);


-- 3.Write a query to select those employees who does not work in those department where the managers of ID between 100 and 200 works.
  select first_name||last_name
   from employees
   where manager_id not between 100 and 200;


-- 4.Find employees who have at least one person reporting to them.
   select E.employee_id,E.first_name
   From employees E JOIN employees M
   on E.manager_id = M.employee_id
   group by E.employee_id
   having count(M.employee_id)>=1

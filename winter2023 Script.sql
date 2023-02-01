-------01/17/2023------
-----DDL - Data Definition Language
--CREATE - Used to create a new database object such as a table, view, index, or procedure
--ALTER - Used to modify an existing database object
--DROP - Used to delete an existing database object
--TRUNCATE - Used to remove all data from a table, but keep the table structure

--SYNTAX
--CREATE DATABASE DATABASE_NAME

--CREATING  HOSPITAL DATABASE
CREATE DATABASE HOSPITAL_DB;

-----SQL DATATYPES
--INTEGER/ INT 
--FLOAT 
--VARCHAR() 
--CHAR()
--NVARCHAR()
--NCHAR()
--DATE 
--BOOLEAN 

----SQL CONSTRAINTS
--NOT NULL - Ensures that a column cannot have a null value
--PRIMARY KEY - Uniquely identifies each row in a table and cannot have null values.
--FOREIGN KEY - Enforces a link OR relationship between the data in two tables
--UNIQUE - Ensures that all values in a column are distinct
--CHECK - Ensures that the value in a column meets a specific condition
--DEFAULT - Provides a default value for a column when no value is specified 


--PATIENTS
--APPOINTMENTS
--THERAPISTS

--SYNTAX
CREATE TABLE TABLE_NAME
(
COLUMN1  DATATYPE CONSTRAINT,
COULUMN2 DATATYPE CONSTRAINT,
COLUMN3  DATATYPE CONSTRAINT,
COULUMN4 DATATYPE CONSTRAINT,
COLUMN5  DATATYPE CONSTRAINT
);

---CREATING PATIENTS TABLE
CREATE TABLE PATIENTS
(
PATIENT_ID INTEGER IDENTITY(1000, 1),
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
DOB DATE NOT NULL,
PHONE CHAR(10) NOT NULL,
EMAIL VARCHAR(100) NULL,
STATE CHAR(2) NULL
);

--SYNTAX
--ALTER TABLE TABLE_NAME
--ADD CONSTRAINT CONSTRAINT_NAME PRIMARY KEY(COULUMN);

---ADDING PK CONSTRAINT
ALTER TABLE PATIENTS
ADD CONSTRAINT PK_PATIENTS_PATIENT_ID PRIMARY KEY (PATIENT_ID);

--CREATING APPOINTMENTS TABLE
CREATE TABLE APPOINTMENTS
(
APPOINTMENT_ID INTEGER IDENTITY(100, 3),
PATIENT_ID INTEGER NOT NULL,
THERAPIST_ID INTEGER NOT NULL,
APPOINTMENT_DATE DATE NOT NULL
);

--- ADDING PK CONSTRAINT
ALTER TABLE APPOINTMENTS
ADD CONSTRAINT PK_APPOINTMENTS_APPOINTMENT_ID PRIMARY KEY(APPOINTMENT_ID)

USE HOSPITAL_DB;

--CREATING THERAPIST TABLE
CREATE TABLE THERAPISTS
(
THERAPIST_ID INTEGER IDENTITY(1,1),
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
PHONE CHAR(10) NOT NULL,
EMAIL VARCHAR(100) NOT NULL
);

ALTER TABLE THERAPISTS
ADD CONSTRAINT PK_THERAPISTS_THERAPIST_ID PRIMARY KEY(THERAPIST_ID);


--------01/18/2023-------
--SYTAX
--ALTER TABLE CHILD_TABLE_NAME
--ADD CONSTRAINT CONSTRAINT_NAME FOREIGN KEY(COLUMN)
--REFERENCES PARENT_TABLE_NAME(COLUMN);

--ADDING FK CONSTRAINTS TO APPOINTMENTS TABLE
ALTER TABLE APPOINTMENTS
ADD CONSTRAINT FK_APPOINTMENTS_PATIENT_ID FOREIGN KEY(PATIENT_ID)
REFERENCES PATIENTS(PATIENT_ID);

ALTER TABLE APPOINTMENTS
ADD CONSTRAINT FK_APPOINTMENTS_THERAPIST_ID FOREIGN KEY(THERAPIST_ID)
REFERENCES THERAPISTS(THERAPIST_ID);

---ADDING A UNIQUE CONSTRAINT TO PHONE
ALTER TABLE PATIENTS
ADD CONSTRAINT UQ_PATIENTS_PHONE UNIQUE(PHONE);

--- ADDING A CHECK CONSTRAINT TO PHONE TO VERIFY PHONE NUMBER LENGHT
ALTER TABLE PATIENTS
ADD CONSTRAINT CK_PATIENTS_PHONE CHECK (LEN(PHONE) = 10);

--ADDING SSN COLUMN TO PATIENT TABLE
ALTER TABLE PATIENTS
ADD SSN CHAR(9) NOT NULL;

-- MODIFYING SSN DATATYPE A
ALTER TABLE PATIENTS
ALTER COLUMN SSN VARCHAR(9) NULL;

---DROP
CREATE TABLE THERAPISTS1
(
THERAPIST_ID INTEGER IDENTITY(1,1),
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
PHONE CHAR(10) NOT NULL,
EMAIL VARCHAR(100) NOT NULL
);

---SYNTAX
--DROP TABLE
--DROP TABLE TABLE_NAME;

----DROP COLUMN
--ALTER TABLE TABLE_NAME
--DROP COLUMN COLUMN_NAME;

-- DROPPING FIRST NAME COLUMN
ALTER TABLE THERAPISTS1
DROP COLUMN FIRST_NAME, LAST_NAME;

--DROPPING THERAPISTS1 TABLE
DROP TABLE THERAPISTS1;

-- DROPPING PATIENT ID FK
ALTER TABLE APPOINTMENTS
DROP CONSTRAINT FK_APPOINTMENTS_PATIENT_ID;

--RENAMING OBJECTS
--SP_RENAME

--RENAMING PATIENTS TO PATIENT
EXEC SP_RENAME 'PATIENTS', 'PATIENT';

--RENAMING PHONE TO PHONE_NUMBER
EXEC SP_RENAME 'PATIENT.PHONE', 'PHONE_NUMBER', 'COLUMN';

--REMOVING UNIQUE CONSTRAINT FROM PHONE
ALTER TABLE PATIENT
DROP CONSTRAINT UQ_PATIENTS_PHONE;

ALTER TABLE PATIENT
DROP CONSTRAINT CK_PATIENTS_PHONE;

---INDEXES
---INDEXES ARE USED TO RETRIEVE DATA FROM DATABASES MORE QUICK, THEY HELP SPEED UP QUERIES.
----CLUSTERED 
--Whenever you apply clustered indexing in a table, it will perform sorting 
--in that table only. You can create only one clustered index in a table like primary key.
--Clustered index is as same as dictionary where the data is arranged by alphabetical order. 
--If you apply primary key to any column, then automatically it will become clustered index. 

----NONCLUSTERED
--is similar to the index of a book. The index of a book consists of a chapter name and page number, 
--if you want to read any topic or chapter then you can directly go to that page by using index of
-- that book. No need to go through each and every page of a book. 

--SYNTAX
--CREATE <CLUSTERED / NONCLUSTERED> INDEX_NAME
--ON TABLE_NAME(COLUMN);

---CREATING CLUSTERED INDEX ON FIRSTNAME COLUMN
CREATE CLUSTERED INDEX IDX_PATIENT_FIRST_NAME
ON PATIENT(FIRST_NAME);


---CREATING NONCLUSTERED INDEX ON FIRSTNAME COLUMN
CREATE NONCLUSTERED INDEX IDX_PATIENT_FIRST_NAME
ON PATIENT(FIRST_NAME);

--- DROPPING INDEX ON PATIENT TABLE
DROP INDEX PATIENT.IDX_PATIENT_FIRST_NAME;

DROP INDEX IDX_PATIENT_FIRST_NAME
ON PATIENT;


--------01/19/2023------------
---DML - DATA MANIPULATION LANGUAGE
--INSERT -- POPULATE RECORDS INTO THE TABLE
--UPDATE -- MODIFY AN EXISTING RECORD BASED ON A GIVEN CONDITION
--DELETE -- REMOVE EXISTING RECORDS BASED ON A GIVEN CONDITION..
		-- WHEN NO CONDITION IS SPECIFIED ALL RECORDS ARE REMOVED
--SELECT --RETRIEVE RECORDS FROM TABLES

----INSERT
--SYNTAX
INSERT INTO TABLE_NAME(COLUMN1, COLUMN2, COLUMN3, COLUMN4,...)
VALUES
('VALUE1', 'VALUE2', 'VALUE3', NULL),
('VALUE1', 'VALUE2', 'VALUE3', 'VALUE4'),
('VALUE1', 'VALUE2', 'VALUE3', 'vALUES'),
('VALUE1', 'VALUE2', 'VALUE3', 'vALUES');

---INSERTING PATIENT TABLE
INSERT INTO PATIENT(FIRST_NAME, LAST_NAME, DOB, PHONE_NUMBER, EMAIL,
					STATE, SSN)
VALUES
('JOHN', 'DOE', '05-18- 2002', '4107892345', 'JOHND@GMAIL.COM','MD', '000119999'),
('JANE', 'SMITH', '02-01-1997', '8650041234', 'JDOE@GMAIL.COM', 'OK', '086279730'),
('PAUL', 'THOMAS', '09-20-2000', '8659041234', 'PT2000@GMAIL.COM', 'VA', '206279730');

INSERT INTO PATIENT(FIRST_NAME, LAST_NAME, DOB, PHONE_NUMBER, EMAIL,
					STATE, SSN)
VALUES
('KEVIN', 'JONES', '05-18- 2002', '4109875643', 'KAYJAY@GMAIL.COM','FL', '660119999')

SELECT *
FROM PATIENT;

----INSERTING THERAPISTS TABLE
INSERT INTO THERAPISTS(FIRST_NAME, LAST_NAME, PHONE, EMAIL)
VALUES
('MARY', 'JONES' , '6168970987', 'MJONES@CELTIC.COM'),
('SARA', 'JOHNSON', '9853720974', 'SJOHNSON@CELTIC.COM'),
('COLE', 'PHIPHER', '9730987652', 'CPHIPHER@CELTIC.COM');


SELECT * 
FROM THERAPISTS

--INSERTING APPOINTMENTS TABLE
INSERT INTO APPOINTMENTS(PATIENT_ID, APPOINTMENT_DATE, THERAPIST_ID)
VALUES
(1001, '01-19-2023', 3),
(1005, '01-20-2023', 1),
(1002, '01-30-2023', 1),
(1001, '03-01-2023', 2),
(1003, '02-29-2024', 3);


SELECT * 
FROM APPOINTMENTS


---UPDATE 
--SYNTAX
--UPDATE TABLE_NAME
--SET COLUMNNAME = 'NEWVALUE'
--WHERE <CONDITION GOES HERE>

---UPDATING PATIENT 1005 LAST NAME
UPDATE PATIENT
SET LAST_NAME = 'SINGH'
WHERE PATIENT_ID = 1005;


---UPDATING PATIENT 1008 SATE OF RESIDENCE
UPDATE PATIENT
SET STATE = 'NY'
WHERE PATIENT_ID = 1008


---ADDING EMAIL COLUMN
ALTER TABLE  APPOINTMENTS
ADD THERAPIST_EMAIL VARCHAR(100);

--UPDATING THERAPIST EMAIL IN APPOINTMENTS TABLE
UPDATE APPOINTMENTS
SET THERAPIST_EMAIL = THERAPISTS.EMAIL
FROM APPOINTMENTS, THERAPISTS
WHERE APPOINTMENTS.THERAPIST_ID = THERAPISTS.THERAPIST_ID

SELECT * 
FROM APPOINTMENTS;

SELECT * 
FROM THERAPISTS


----- DELETE
--SYNTAX 
--DELETE
--FROM TABLE_NAME
--WHERE <CONDITION HERE>

---REMOVING THERAPIST 3 INFO
DELETE
FROM THERAPISTS1
WHERE THERAPIST_ID = 3;

---REMOVE ALL RECORDS FROM TABLE
DELETE
FROM THERAPISTS1


SELECT *  
FROM THERAPISTS1


------01/23/2023----
--TRUNCATE
SELECT *  
FROM PATIENT

TRUNCATE TABLE THERAPISTS1;

-- KEYED IN ORDER
--SELECT --  RETRIEVE THE DATA/ COLUMNS
--FROM  --  SPECIFIES THE TABLE WHERE DATA IS SITS
--WHERE -- USED TO FILTER OR LIMIT DATA BASED ON A GIVEN CONDITION.
--GROUP BY -- GROUP NON-AGGREGATED COLUMNS WHENEVER AN AGGREGATE FUNCTION
--			--IS INTRODUCED IN THE SELECT
--HAVING -- USED TO FILTER ON AGGREGATED COLUMNS BASED ON A GIVEN CONDITION.
--ORDER BY -- USED TO SORT OR ORDER RECORDS IN ASCENDING(ASC) OR 
--			--DESCENDING(DESC). BY DEFAULT DATA WILL BE SORTED IN ASC


---LOGICAL QUERY ORDER
--FROM 
--WHERE
--GROUP BY
--HAVING
--SELECT 
--ORDER BY 

-----AGGREGATE FUNCTIONS-----
--AGGREGATE FUNCTIONS ARE SQL FUNCTIONS THAT PERFORM A CALCULATION ON A
--SET OF VALUES AND RETURN A SINGLE VALUE

--COUNT()
--SUM()
--AVG()
--MIN()
--MAX()

SELECT * 
FROM  SALES.SHIPPERS

-- RETRIEVE THE NUMBER OF SHIPPERS WE HAVE IN OUR COMPANY
SELECT COUNT(SHIPPERID) AS NUMOFSHIPPERS
FROM SALES.SHIPPERS;

-- RETRIEVE CUSTOMERS AND THE NUMEBR OF ORDERS THEY PLACED 
SELECT CUSTID, COUNT(ORDERID) AS ORDERS
FROM SALES.ORDERS
GROUP BY CUSTID;

--- WHAT IS OUR MOST EXPEMSICE UNITPRICE?
SELECT MAX(UNITPRICE) AS MOSTEXPENSIVE
FROM PRODUCTION.PRODUCTS;

--- WHAT IS OUR LEAST EXPEMSICE UNITPRICE?
SELECT MIN(UNITPRICE) AS LEASTEXPENSIVE
FROM PRODUCTION.PRODUCTS;

--WHAT IS THE TOTAL UNIT PRICE PER CATEGORY?
SELECT CATEGORYID, SUM(UNITPRICE) AS TOTAL
FROM PRODUCTION.PRODUCTS 
GROUP BY CATEGORYID
ORDER BY TOTAL DESC;

----- DISTINCT -- ALLOWS RETRIEVAL ON NON DUPLICATED RECORDS
SELECT DISTINCT CATEGORYID
FROM PRODUCTION.PRODUCTS;

----SQL OPERATORS---
--AND --  ALL CONDITIONS MUST BE TRUE
--OR -- AT LEAST ONE CONDITION MUST BE TRUE
--BETWEEN -- USED AS A PREDICATE FOR A RANGE OF ITEMS.USED WITH THE AND)
--IN -- ALLOWS TO CREATE A SEARCH PREDICATE FOR A SET OF ITEMS
--NOT IN ---
--LIKE --- ALLOWS TO PERFORM  A PATTERN SEARCH. 
		-- MUST ALWAYS BE USED IN CONJUNCTION WITH A WILDCARD(_, %)
--NOT LIKE
--= -- EQUAL TO
--<> OR != -- NOT EQUAL TO
--< -- LESS THAN
-->  -- GREATER THAN

-- RETRIEVE CUSTOMERS AND THE NUMBER OF ORDERS THEY PLACED 
--09/2006 AND 09/2007
SELECT CUSTID, COUNT(ORDERID) AS ORDERS
FROM SALES.ORDERS
WHERE ORDERDATE  BETWEEN '09-01-2006' AND '09-01-2007' 
GROUP BY CUSTID
ORDER BY ORDERS DESC;

SELECT CUSTID,  COUNT(ORDERID) AS ORDERS
FROM SALES.ORDERS
WHERE ORDERDATE  >= '09-01-2006' AND ORDERDATE <='09-01-2007' 
GROUP BY CUSTID
ORDER BY ORDERS DESC;


-- RETRIEVE ORDERS SHIPPED TO FRANCE, USA, BRAZIL, ITALY, SPAIN, GHANA
SELECT ORDERID, CUSTID, ORDERDATE, FREIGHT, SHIPCOUNTRY
FROM SALES.ORDERS
WHERE SHIPCOUNTRY IN ('FRANCE', 'USA', 'BRAZIL', 'ITALY', 'SPAIN', 'GHANA');

SELECT ORDERID, CUSTID, ORDERDATE, FREIGHT, SHIPCOUNTRY
FROM SALES.ORDERS
WHERE SHIPCOUNTRY = 'FRANCE'
OR  SHIPCOUNTRY ='USA'
OR  SHIPCOUNTRY ='BRAZIL'
OR  SHIPCOUNTRY ='ITALY'
OR  SHIPCOUNTRY ='SPAIN'
OR  SHIPCOUNTRY ='GHANA';


-----01/24/2023----
-- RETRIEVE ORDERS NOT SHIPPED TO ARGENTINA, FRANCE, USA, BRAZIL, ITALY, SPAIN, GHANA
SELECT ORDERID, CUSTID, ORDERDATE, FREIGHT, SHIPCOUNTRY
FROM SALES.ORDERS
WHERE SHIPCOUNTRY NOT IN ('ARGENTINA','FRANCE', 'USA', 'BRAZIL', 'ITALY', 'SPAIN', 'GHANA')
ORDER BY SHIPCOUNTRY;

----<> / !=
-- RETIEVE ORDERS NOT SHIPPED TO THE USA
SELECT ORDERID, CUSTID, ORDERDATE, FREIGHT, SHIPCOUNTRY
FROM SALES.ORDERS 
WHERE SHIPCOUNTRY <> 'USA';

SELECT ORDERID, CUSTID, ORDERDATE, FREIGHT, SHIPCOUNTRY
FROM SALES.ORDERS 
WHERE SHIPCOUNTRY != 'USA';

---LIKE 
-----WILDCARDS(_, %)
-------- _  REPRESENTS A SINGLE CHARACTER
-------- %  REPRESENTS MULTIPLE CHARACTERS

SELECT DISTINCT SHIPCOUNTRY 
FROM SALES.ORDERS

--RETRIEVE ALL SHIPCOUNTRIES THAT HAVE THE LETTER D IN THEIR SPELLING.
SELECT DISTINCT SHIPCOUNTRY 
FROM SALES.ORDERS
WHERE SHIPCOUNTRY LIKE '%D%';

--RETRIEVE ALL SHIPCOUNTRIES THAT BEGIN WITH THE LETTER P IN THEIR SPELLING.
SELECT DISTINCT SHIPCOUNTRY 
FROM SALES.ORDERS
WHERE SHIPCOUNTRY LIKE 'P%'

--RETRIEVE ALL SHIPCOUNTRIES THAT HAVE THE LETTER A IN THE THIRD 
--POSITION OF THEIR SPELLING.
SELECT DISTINCT SHIPCOUNTRY 
FROM SALES.ORDERS
WHERE SHIPCOUNTRY LIKE '__A%';

--RETRIEVE ALL SHIPCOUNTRIES THAT END WITH THE LETTER A IN THEIR SPELLING.
SELECT DISTINCT SHIPCOUNTRY 
FROM SALES.ORDERS
WHERE SHIPCOUNTRY LIKE '%A'


SELECT DISTINCT SHIPCOUNTRY 
FROM SALES.ORDERS
WHERE SHIPCOUNTRY LIKE '%LAND%'

----STRING FUNCTIONS
---CAST() 
--CONCAT() 
--LEFT() 
--RIGHT()
--SUBSTRING()
--ISNULL() 
--COALESCE() 
--LTRIM()
--RTRIM() 
--CHARINDEX() 
-- LEN()

---CAST()
DECLARE @NUM INT = 125
DECLARE @NAME VARCHAR(10) = 'JAY'
SELECT CAST(@NUM AS VARCHAR) + @NAME;

-- COMBINE EMPLOYEEID AND EMPLOYEE LAST NAME
SELECT CAST(EMPID AS VARCHAR) + LASTNAME AS USERID
FROM HR.EMPLOYEES;

---CONCAT()
DECLARE @VAL1 VARCHAR(10)  = 'SWIFT'
DECLARE @VAL2 VARCHAR(10) = 'LEARN'
SELECT CONCAT(@VAL1, @VAL2) AS NAME

--- COMBINE EMPLOYEE FULL NAME
SELECT CONCAT(TITLEOFCOURTESY,' ', FIRSTNAME,' ', LASTNAME) AS EMPNAME
FROM HR.EMPLOYEES;

---LTRIM()
DECLARE @VAL1 VARCHAR(10) = '   JUSTIN'
SELECT LTRIM(@VAL1)

---RTRIM()
DECLARE @VAL1 VARCHAR(10) = 'JUSTIN   '
SELECT RTRIM(@VAL1)

--LEFT()
DECLARE @VAL1 VARCHAR(10) = 'JUSTIN'
SELECT LEFT(@VAL1, 4), @VAL1;

--RETIREVE THE FIRST 3 CHARACTERS FROM EMPLOYEE CITY AS ABBREVIATED CITY
SELECT DISTINCT  CITY, LEFT(CITY, 3) AS ABBREVIATED_CITY
FROM HR.EMPLOYEES

---RIGHT()
DECLARE @VAL1 VARCHAR(10) = 'JUSTIN'
SELECT RIGHT(@VAL1, 2)

--RETIREVE THE LAST 3 CHARACTERS FROM EMPLOYEE CITY AS ABBREVIATED CITY
SELECT DISTINCT  CITY, RIGHT(CITY, 3) AS ABBREVIATED_CITY
FROM HR.EMPLOYEES;

---SUBSTRING
DECLARE @VAL1 VARCHAR(10) = 'JUSTIN'
SELECT SUBSTRING(@VAL1, 2, 4)


---- RETRIEVE THE NEXT 3 CHARACTERS FROM THE THIRD POSITION IN EMPLOYEE CITY
SELECT DISTINCT CITY, SUBSTRING(CITY, 3, 3) 
FROM HR.EMPLOYEES

--HOW LONG IS AN EMPLOYEES LASTNAME?
---LEN()
SELECT LASTNAME, LEN(LASTNAME) AS LENGHT
FROM HR.EMPLOYEES

--CHARINDEX()
SELECT EMAIL , LEFT(EMAIL,(CHARINDEX('@', EMAIL))-1)
FROM THERAPISTS

--ISNULL()
--- REPLACE ALL CUSTOMER NULL REGIONS WITH NA
SELECT CUSTID, COMPANYNAME, CITY, ISNULL(REGION, 'NA') AS REGION1, REGION
FROM SALES.CUSTOMERS;

---COALESCE
--REPLACE ALL CUSTOMER NULL REGIONS WITH FAX IF FAX IS ALSO NULL THEN POSTALCODE
SELECT CUSTID, COMPANYNAME, CITY, COALESCE(REGION, FAX, POSTALCODE) REGION1
	, REGION, FAX, POSTALCODE
FROM SALES.CUSTOMERS


-----01/25/2023-------
--- MATH FUNCTIONS
--ABS() -- RETURNS THE ABSOLUTE  VALUE OF A NUMBER
--FLOOR() ---  RETURNS THE LARGEST INTEGER THAT IS <= A GIVEN DECIMAL VALUE
--CEILING() -- RETURN THE SMALLEST INTEGER THAT IS >= A GIVEN DECIMAL VALUE.
--ROUND()-- USED TO ROUND TO THE NEAREST WHOLE NUMBER
--POWER() -- USED TO FIND THE POWER OF A GIVEN NUMBER
--SQRT() -- USED TO FIND THE SQUARE ROOT OF A NUMBER

---ABS()
DECLARE @NUM INT = -10
SELECT ABS(@NUM)

--FLOOR()
DECLARE @NUM FLOAT = 2.9999
SELECT FLOOR(@NUM) AS VAL1, @NUM AS VAL2;

DECLARE @NUM FLOAT = 32.6726
SELECT FLOOR(@NUM) AS VAL1, @NUM AS VAL2;

---CEILING ()
DECLARE @NUM FLOAT = 7.41
SELECT CEILING(@NUM) VAL1, @NUM VAL2

--- ROUND()
DECLARE @NUM FLOAT = 7.546
SELECT ROUND(@NUM, 2) VAL1, @NUM VAL2

---POWER()
SELECT POWER(2,2) PWR;

SELECT CAST(POWER(2,14) AS FLOAT) PWR;

--SQRT()
SELECT SQRT(64) SQUAREROOT

SELECT SQRT(121) SQUAREROOT

SELECT SQRT(60) SQUAREROOT

---DATE FUNCTIONS
--GETDATE()
--DATEDIFF()
-- DATEPART()
--DATENAME()
--DATEADD()
-- MONTH()
--YEAR()
--DAY()
--CURRENT_TIMESTAMP

---GETDATE()
SELECT GETDATE();

-- DATEDIFF()
--HOW MANY DAYS HAS IT BEEN SINCE 09/29/2006
SELECT DATEDIFF(DAY, '09-29-2006', GETDATE()) NUMOFDAYS;

--HOW MANY MONTHS HAS IT BEEN SINCE 09/29/2006
SELECT DATEDIFF(MONTH, '09-29-2006', GETDATE()) NUMOFMONTHS;

--HOW MANY YEARS HAS IT BEEN SINCE 09/29/2006
SELECT DATEDIFF(YEAR, '09-29-2006', GETDATE()) NUMOFYEARS;

SELECT DATEDIFF(YEAR, '09-29-2006', '09-10-2015') NUMOFYEARS;

---DATEADD
--WHAT WILL BE THE DATE 5 DAYS FROM TODAY
SELECT DATEADD(DAY, 5, GETDATE());

--WHAT WILL BE THE DATE 5 MONTHS FROM TODAY
SELECT DATEADD(MONTH, 5, GETDATE());

--WHAT WILL BE THE DATE 5 YEARS FROM TODAY
SELECT DATEADD(YEAR, 5, GETDATE());

---DATEPART()
---EXTRACT THE MONTH PART FROM TODAYS DATE
SELECT DATEPART(MONTH, GETDATE());

---EXTRACT THE DAY PART FROM TODAYS DATE
SELECT DATEPART(DAY, GETDATE());

---EXTRACT THE YEAR PART FROM TODAYS DATE
SELECT DATEPART(YEAR, GETDATE());

---DATENAME()
---WHAT IS THE WEEKDAY OF TODAY'S DATE
SELECT DATENAME(WEEKDAY, GETDATE())

--WHAT IS THE MONTH NAME OF TODAY'S DATE
SELECT DATENAME(MONTH, GETDATE())
 
 --03-31-1994
SELECT FLOOR(DATEDIFF(DAY, '03-31-1994', GETDATE())/ 365.25) AGE;

--CURRENT_TIMESTAMP
SELECT CURRENT_TIMESTAMP

----JOINS--
--INNER JOIN/ JOIN
--LEFT JOIN/ LEFT OUTER JOIN
--RIGHT JOIN/ RIGHT OUTER JOIN
--FULL JOIN/ FULL OUTER JOIN
--CROSS JOIN
--**SELF JOIN**

--SYNTAX
--SELECT A.COLUMN1, B.COLUMN2
--FROM TABLE1 AS A
--JOIN TABLE2 AS B
--ON A.COLUMNNAME = A.COLUMNNAME;
--JOIN TABLE3 AS C
--ON C.COLUMNNAME = A.COLUMNNAME;

--Table 1 Query:
Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

--Table 2 Query:
Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)


---TABLES USED IN JOIN SCENERIOS
--Table 1 Insert:
Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male'),
(NULL, 'Joe', 'Hallow', 20, NULL),
(NULL, 'Timmy', 'Toms', NULL, NULL),
(NULL, 'Gigi', 'Buffon', 34, 'Male');


--Table 2 Insert:
Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000),
(NULL, NULL, 49000),
(NULL, 'Receptionist', 55000);

---JOIN
SELECT * 
FROM EMPLOYEEDEMOGRAPHICS ED
JOIN EMPLOYEESALARY ES
ON ED.EMPLOYEEID = ES.EMPLOYEEID;

--LEFT JOIN
SELECT * 
FROM EMPLOYEEDEMOGRAPHICS ED
LEFT JOIN EMPLOYEESALARY ES
ON ED.EMPLOYEEID = ES.EMPLOYEEID;

--RIGHT JOIN
SELECT * 
FROM EMPLOYEEDEMOGRAPHICS ED
RIGHT JOIN EMPLOYEESALARY ES
ON ED.EMPLOYEEID = ES.EMPLOYEEID;

--FULL JOIN
SELECT * 
FROM EMPLOYEEDEMOGRAPHICS ED
FULL JOIN EMPLOYEESALARY ES
ON ED.EMPLOYEEID = ES.EMPLOYEEID;


----01/26/2023-----
--JOIN
---RETRIEVE INFORMATION OF EMPLOYEES BORN AFTER 1975
SELECT PP.BUSINESSENTITYID, PP.FIRSTNAME, PP.LASTNAME, HRE.JOBTITLE,
		HRE.BIRTHDATE
FROM PERSON.PERSON PP
JOIN HUMANRESOURCES.EMPLOYEE HRE
ON PP.BUSINESSENTITYID = HRE.BUSINESSENTITYID
WHERE HRE.BIRTHDATE >= '1975'
ORDER BY HRE.BIRTHDATE;

SELECT PP.BUSINESSENTITYID, PP.FIRSTNAME, PP.LASTNAME, HRE.JOBTITLE,
		HRE.BIRTHDATE
FROM PERSON.PERSON PP
JOIN HUMANRESOURCES.EMPLOYEE HRE
ON PP.BUSINESSENTITYID = HRE.BUSINESSENTITYID
WHERE YEAR(HRE.BIRTHDATE) >= '1975'
ORDER BY HRE.BIRTHDATE;

---- LEFT JOIN
-- RETRIEVE ALL CUSTOMERS AND THEIR ORDRS. 
--INCLUDE CUSTOMERS WHO DO NOT HAVE ANY ORDERS
SELECT SC.CUSTID, SC.COMPANYNAME, SC.CONTACTNAME, SO.ORDERID, SO.ORDERDATE
FROM SALES.CUSTOMERS SC
LEFT JOIN SALES.ORDERS SO
ON SC.CUSTID = SO.CUSTID
ORDER BY SO.ORDERID;

---- RIGHT JOIN
-- RETRIEVE ALL CUSTOMERS AND THEIR ORDRS. 
--INCLUDE CUSTOMERS WHO DO NOT HAVE ANY ORDERS
--FLAG CUSTOMERS WITH NO ORDERS AS "NO ORDERS PLACED"
SELECT SC.CUSTID, SC.COMPANYNAME, SC.CONTACTNAME, 
		ISNULL(CAST(SO.ORDERID AS VARCHAR), 'NO ORDERS PLACED') ORDERID
FROM SALES.ORDERS SO
RIGHT JOIN SALES.CUSTOMERS SC
ON SC.CUSTID = SO.CUSTID
ORDER BY SO.ORDERID;

----CROSS JOIN
SELECT FIRSTNAME, DESCRIPTION 
FROM HR.EMPLOYEES
CROSS JOIN PRODUCTION.CATEGORIES
ORDER BY FIRSTNAME


SELECT D.N WEEK_DAY, S.N SHIFTS
FROM NUMS D 
CROSS JOIN NUMS S
WHERE D.N<= 7 AND S.N <=3
ORDER BY WEEK_DAY;

--SET OPERATORS
--UNION 
--UNION ALL
--INTERSECT
--EXCEPT

--UNION
---RETREIVE FIRSTNAMES THAT ARE BOTH CUSTOMERS AND EMPLOYEES WITHOUT DUPS
SELECT DISTINCT FIRSTNAME
FROM PERSON.PERSON PP
JOIN SALES.CUSTOMER SC
ON PP.BUSINESSENTITYID = SC.PERSONID ---871

UNION  ---936

SELECT DISTINCT FIRSTNAME
FROM PERSON.PERSON PP
JOIN HUMANRESOURCES.EMPLOYEE HRE
ON PP.BUSINESSENTITYID = HRE.BUSINESSENTITYID  ---224

--UNION ALL
---RETREIVE FIRSTNAMES THAT ARE BOTH CUSTOMERS AND EMPLOYEES WITH DUPS
SELECT DISTINCT FIRSTNAME
FROM PERSON.PERSON PP
JOIN SALES.CUSTOMER SC
ON PP.BUSINESSENTITYID = SC.PERSONID ---871

UNION ALL ---1095

SELECT DISTINCT FIRSTNAME
FROM PERSON.PERSON PP
JOIN HUMANRESOURCES.EMPLOYEE HRE
ON PP.BUSINESSENTITYID = HRE.BUSINESSENTITYID  ---224

--INTERSECT
---RETREIVE FIRSTNAMES THAT ARE COMMON CUSTOMERS AND EMPLOYEES NAMES
SELECT DISTINCT FIRSTNAME
FROM PERSON.PERSON PP
JOIN SALES.CUSTOMER SC
ON PP.BUSINESSENTITYID = SC.PERSONID ---871

INTERSECT ---159

SELECT DISTINCT FIRSTNAME
FROM PERSON.PERSON PP
JOIN HUMANRESOURCES.EMPLOYEE HRE
ON PP.BUSINESSENTITYID = HRE.BUSINESSENTITYID  ---224

--EXCEPT
---RETREIVE FIRSTNAMES THAT ARE JUST CUSTOMERS BUT NOT EMPLOYEES
SELECT DISTINCT FIRSTNAME
FROM PERSON.PERSON PP
JOIN SALES.CUSTOMER SC
ON PP.BUSINESSENTITYID = SC.PERSONID ---871

EXCEPT ---712

SELECT DISTINCT FIRSTNAME
FROM PERSON.PERSON PP
JOIN HUMANRESOURCES.EMPLOYEE HRE
ON PP.BUSINESSENTITYID = HRE.BUSINESSENTITYID  ---224


---TESTING
SELECT *
FROM PERSON.PERSON PP
JOIN HUMANRESOURCES.EMPLOYEE HRE
ON PP.BUSINESSENTITYID = HRE.BUSINESSENTITYID  
WHERE FIRSTNAME IN('Alexandre'
,'Alexandria'
,'Alexia'
,'Alexis'
,'Alfredo')

---SAMPLE REFERENTIAL INTEGRITY TEST
SELECT PERSONID
FROM SALES.CUSTOMER

EXCEPT

SELECT BUSINESSENTITYID
FROM PERSON .PERSON

-----01//30/2023-----
---CASE EXPRESSIONS
-- SEARCH FORM 
-- SIMPLE FORM

--SYNTAX
CASE <column_name > (if simple case expression)
	WHEN CONDITION_1 THEN OUTPUT_1
	WHEN CONDITION_2 THEN OUTPUT_2
	WHEN CONDITION_3 THEN OUTPUT_3
	....
	ELSE COUTPUT_4
END AS <DERIVED_COLUMN>

-- SEARCG FORM
-- IF UNITPRICE IS LESS THAN 30 THEN CATEGORIZE AS LOW
-- IF UNITPRICE IS BETWEEN 30 AND 75 THEN CATEGORIZE AS MEDIUM
-- IF UNITPRICE IS ABOVE 75 THEN CATEGORIZE AS HIGH
SELECT P.PRODUCTID, P.PRODUCTNAME, S.COMPANYNAME, P.UNITPRICE,  
		CASE 
			WHEN P.UNITPRICE < 30 THEN 'LOW'
			WHEN P.UNITPRICE < 75 THEN 'MEDIUM'
			WHEN P.UNITPRICE >= 75 THEN 'HIGH'
			ELSE 'NO UNIT PRICE'
		END AS PRICECATEGORY
FROM PRODUCTION.PRODUCTS P
JOIN PRODUCTION.SUPPLIERS S
ON P.SUPPLIERID = S.SUPPLIERID

---SIMPLE FORM
SELECT  CASE D.N 
				WHEN 1 THEN 'SUNDAY'
				WHEN 2 THEN 'MONDAY'
				WHEN 3 THEN 'TUESDAY'
				WHEN 4 THEN 'WEDNESDAY'
				WHEN 5 THEN 'THURSDAY'
				WHEN 6 THEN 'FRIDAY'
				ELSE 'SATURDAY'
		END AS WEEK_DAY,
		CASE S.N
				WHEN 1 THEN 'MORNING SHIFT'
				WHEN 2 THEN 'DAY SHIFT'
				ELSE 'EVENING SHIFT'
		END AS SHIFTOFDAY
FROM NUMS D 
CROSS JOIN NUMS S
WHERE D.N<= 7 AND S.N <=3
ORDER BY WEEK_DAY,SHIFTOFDAY ;

---SUBQUERIES
--IT IS A QUERY FOUND AT THE WHERE OR HAVING CLAUSE OF A SELECT STATEMENT.

--SELF CONTAINED SUBQUERY
-- THE EVALUATION OF THE INNER QUERY  DOES NOT DEPEND ON THE OUTER QUERY

--CORRELATED SUBQUERY
--EVALUATION OF THE INNER QUERY DEPENDS ON THE OUTER QUERY

--SYNTAX
--SELECT COLUMN1, COLUMN2
--FROM TABLE1
--WHERE COLUMN1 (=, >, <>, IN) (SELECT COLUMN1 FROM TABLE1)
--HAVING AGGREGATED_COLUMN (=, >, <>, IN) (SELECT COLUMN1 FROM TABLE1)

-- RETRIEVE PRODUCTS WITH THE MINIMUM UNIT PRICE PER CATEGORY AND 
--THEIR DISCONTINUED FLAG ( 1 = NOT IN PROD / 0 IN PROD)
SELECT CATEGORYID, PRODUCTNAME,UNITPRICE, 
		CASE 
			WHEN DISCONTINUED = 1 THEN 'NOT IN PROD'
			ELSE 'IN PROD'
		END AS PRODUCTIONSTATUS
FROM PRODUCTION.PRODUCTS P
WHERE UNITPRICE = (SELECT MIN(UNITPRICE)
					FROM PRODUCTION.PRODUCTS P2
					WHERE P.CATEGORYID = P2.CATEGORYID)

SELECT * FROM PRODUCTION.PRODUCTS ORDER BY UNITPRICE 

----SELF CONTAINED / INDEPENDENT.
--RETRIEVE THE EMPLOYEES WHO ARE OLDER THAN THE AVERAGE AGE
SELECT  EMPID , FIRSTNAME, LASTNAME, CITY, REGION,
	FLOOR(DATEDIFF(DAY, BIRTHDATE, GETDATE()) / 365.25) AS AGE
FROM HR.EMPLOYEES
WHERE FLOOR(DATEDIFF(DAY, BIRTHDATE, GETDATE()) / 365.25) > 
			(SELECT  AVG(FLOOR(DATEDIFF(DAY, BIRTHDATE, GETDATE()) / 365.25))
			FROM HR.EMPLOYEES)

------01/31/2023-------
----TABLE EXPRESSIONS
--DERIVED TABLES
--COMMON TABLE EXPRESSIONS(CTE)
--VIEWS
--INLINE TABLE-VALUED FUNCTION
--SCALAR-VALUED FUNCTION

--DERIVED TABLES
-- WINDOWING/ ANALYTICAL FUNCTIONS
--1. ROW_NUMBER() -- GIVES A SEQUENTIAL ROW NUMBERING OVER A PARTITION
--2. RANK() -- SKIPS RANKING ORDER WHEN THERE IS A TIE OVER A PARTITION
--3. DENSE_RANK() -- ORDERS SEQUENTIALLY EVEN WHEN THERE IS A TIE OVER A PARTITION.
--4. NTILE() -- GIVES THE PERCENTILE OVER A PARTITION.

---- HOW THE RANKING WORK
--COLUMN	ROW_NUMBER()	RANK()		DENSE_RANK()
100				1				1			1
100				2				1			1
101				3				3			2
102				4				4			3
103				5				5			4
103				6				5			4
103				7				5			4
104				8				8			5
105				9				9			6


---DERIVED TABLE SYNTAX
---SELECT COLUMN(S)
--FROM ( SELECT COLUMN(S)
--		FROM TABLE1) AS DERIVED_TABLE

---RETIREVE CUSTOMERS AND THEIR MOST RECENT ORDERS.(ADVENTUREWORKS)
SELECT CUSTOMERID,  FIRSTNAME, LASTNAME, ORDERDATE, TOTALDUE
FROM(
		SELECT B.CUSTOMERID,  A.FIRSTNAME, A.LASTNAME, 
			CAST(C.ORDERDATE AS DATE) ORDERDATE, C.TOTALDUE
			,DENSE_RANK() OVER(PARTITION BY B.CUSTOMERID ORDER BY C.ORDERDATE DESC) RANKING
		FROM PERSON.PERSON A
		JOIN SALES.CUSTOMER B
		ON A.BUSINESSENTITYID = B.PERSONID
		JOIN SALES.SALESORDERHEADER C
		ON B.CUSTOMERID = C.CUSTOMERID
	) AS T
WHERE RANKING = 1
ORDER BY CUSTOMERID

---CTE
--SYNTAX
--WITH CTE_NAME AS
--( 
--	SQL SELECT STATEMENT(S)
--)

--SELECT * FROM CTE_NAME

---RETIREVE CUSTOMERS AND THEIR MOST RECENT ORDERS.(ADVENTUREWORKS)

WITH T AS
(
SELECT B.CUSTOMERID,  A.FIRSTNAME, A.LASTNAME, 
			CAST(C.ORDERDATE AS DATE) ORDERDATE, C.TOTALDUE
			,DENSE_RANK() OVER(PARTITION BY B.CUSTOMERID ORDER BY C.ORDERDATE DESC) RANKING
		FROM PERSON.PERSON A
		JOIN SALES.CUSTOMER B
		ON A.BUSINESSENTITYID = B.PERSONID
		JOIN SALES.SALESORDERHEADER C
		ON B.CUSTOMERID = C.CUSTOMERID
)

SELECT CUSTOMERID,  FIRSTNAME, LASTNAME, ORDERDATE, TOTALDUE
FROM T
WHERE RANKING = 1;

SELECT * FROM SALES.SALESORDERDETAIL

--REIREIVE ALL PRODUCTS AND THEIR TOTAL SALE IN 2013 
--THIS ORDERS TABLE IS RETRIEVING ALL ORDER IDS AND ORDER DATES FOR SALES
--PLACED IN 2013
WITH ORDERS AS 
(
SELECT  SALESORDERID, ORDERDATE
FROM SALES.SALESORDERHEADER 
WHERE YEAR(ORDERDATE) = '2013'
),

--THIS ORDERDETAILS TABLE WILL RETRIEVE THE ORDER ID, PRODUCTID AND THE TOTAL
--PER ORDER. IT IS JOINED TO THE ORDERS TABLE BASED ON THE ORDER ID TO 
--FILTER ON THE ORDERS TO LIMIT THE DATA TO JUST 2013 ORDERS
ORDERDETAILS AS
(SELECT A.SALESORDERID, PRODUCTID, LINETOTAL
FROM SALES.SALESORDERDETAIL A
JOIN ORDERS B
ON A.SALESORDERID = B.SALESORDERID
),

-- THIS PRODUCT TABLE RETRIEVES PRODUCT INFORMATION.
PRODUCT AS
(SELECT PRODUCTID, NAME, LISTPRICE
FROM PRODUCTION.PRODUCT
)

---THIS SELECT STATEMENT RETRIEVES OUR FINAL RESULT BY JOINING THE PRODUCT 
--TABLE AND THE ORDERDETAILS TABLE. SUM IS USED ON THE LINETOTAL TO DERIVE 
--THE TOTAL SALE PER PRODUCT.
SELECT A.PRODUCTID, A.NAME, A.LISTPRICE, SUM(B.LINETOTAL) TOTALSALES
FROM PRODUCT A
JOIN ORDERDETAILS B
ON A.PRODUCTID = B.PRODUCTID
GROUP BY A.PRODUCTID, A.NAME, A.LISTPRICE
ORDER BY A.PRODUCTID


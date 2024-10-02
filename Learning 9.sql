--------------------------Data Conversion---------------------------
-- Here we have 2 Types 
-- Implicit --- Automatically done by  postgres
-- Explicit --- done by us


-----------------------------------Implicit--------------------------
--- Integer to Integer
Select * From movies;
Where movie_id =1; -- no conversion needed

--- Integer to String
Select * From movies;
Where movie_id ='1'; -- conversion to integer automatically done by postgres

-----------------------------------Explicit--------------------------
--- Integer to Integer
Select * From movies;
Where movie_id = integer '1'; -- done by us


----------------------------------------CAST-----------------------------------------
--- Cast(expression As data_type)
--expression can be constant , expression , column_name

--- String to Integer
Select Cast('10' As Integer);
Select Cast('10n' As Integer);

-- String to Date
Select
	Cast('2020-02-02' As Date),
	Cast('02-May-2020' As Date);

-- String to Boolean
Select 
	Cast('false' As Boolean),
	Cast('1' As Boolean);
-- string to float
Select 
	Cast('12.2222' As double precision);

--- Instead of Cast we can use expression::Data_type

-- String to timestamp
Select
	'2020-02-02 10:11:11.111'::TimeStamp,
	'2020-02-02 10:11:11.111'::TimeStamptz;

-- String to interval;

Select
	'10 minute'::interval,
	'10 hours'::interval,
	'10 days'::interval;

---------------------------Implicit to explicit conversion------------------------
SELECT factorial(10);
Select factorial(Cast(10 As bigint));
Select 
	Round(10,4) As Implicit,
	Round(Cast(10 As Numeric),4) As Explicit;
Select 
	SubStr('2121331',4) As Implicit,
	SubStr(Cast('2121331' As Text),4) As Explicit;

----------------------Converting table column---------------
Create table ratings(
	rating_id Serial Primary Key,
	rating varchar(1)
);

Insert Into ratings(rating)
Values ('A'),
	   ('B'),
	   (1),
	   (2);
Select * From ratings;
-- if integer then represent in integer else 0
Select rating_id,
	Case
		When rating~E'^//d+$' Then
			Cast(rating As Integer)
		Else
			0
	End As rating
From ratings;





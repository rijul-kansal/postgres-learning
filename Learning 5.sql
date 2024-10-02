-- table name are not case sensitive
-- SQL keywords are not case sensitive
-- Select all records from movie table
Select * from movies;

-- Order of query -------- From|Select

-- Select only few column
Select first_name , last_name From actors;

-- Alias -- change any column name temporary
-- By DEFAULT alias name are in lower_case

Select first_name As firstName From actors;

-- Here Alias Names are acc to us
-- Use double quotes
-- we can not use single quotes
Select first_name As "firstName" From actors;

-- We can use space as well
Select first_name As "First Name" From actors;

-- As keyword is optional
Select 
	first_name  "First Name"
From actors;


-- Combining 2 column together 
Select first_name || ' ' || last_name As "Full Name" From actors;

--Basic maths
Select 2*10 As Multiple;

-- Sorting
-- By default we have ascending order only

-- Sort movies based on release date in ascending order
Select * from movies 
Order By release_date;

-- Sort movies based on release date in descending order
Select * from movies 
Order By release_date Desc;


-- Order by multiple column
Select * 
From movies
Order By
	movie_lang ASC,
	release_date Desc;

-- We can use alias name as column name in order by clause but now in where class
Select 
	first_name,
	last_name As surname
From actors
Order By surname Desc ;



-- Sort first name and last name based on len of first and last name
Select
	first_name,
	last_name,
	Length(first_name || ' '|| last_name) As len
From actors
Order By 
	len Desc;

-- using column number instead of column name in order by
-- the column we will define in * statement that only col we can refer
-- column no will start from 1
Select 
	first_name,
	last_name,
	date_of_birth
From actors
Order By
	1 Asc,
	3 Desc;


-- Null-------------
-- lets if some column contains null value

-- when we do order by in ascending order then null come at last
Select first_name from actors Order By first_name ASC;

-- when we do order by in descending order then null come first
Select first_name from actors Order By first_name Desc;

-- so if we want to change order of null then we can change that also
-- meaning that in ascending order we want null value in starting 
Select first_name from actors Order By first_name ASC Nulls First;

-- meaning that in descending order we want null value in ending 
Select first_name from actors Order By first_name DESC Nulls Last;



-- Getting only Distinct Values
Select
	Distinct movie_lang
From movies
Order By 1;


-- Getting multiple columns As distinct
Select 
	Distinct  director_id ,movie_lang
From movies
Order By movie_lang;

-- Getting all Distinct values
Select 
	Distinct *
From movies;
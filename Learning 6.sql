-- Operators

-- ###  1 Comparison Operators
-- Equal to      =
-- Greater then  >
-- less then     <
-- Greater then and equal to >=
-- less then and equal to <=
-- not equal   <> or !=

-- ### 2 Logical
-- And
-- Or
-- Like 
-- In
-- Between

--  ###  3 Arithmetic Operators
-- Addition    +
-- Subtraction -
-- Division /
-- Multiple *
-- Module %

---------------------------------------AND-----------------------------------
-- Get all english movies from movie table
-- single quotes should be there when we are using strings
-- Case sensitive
Select * From movies
Where
     movie_lang = 'English';

-- using multiple conditions
-- get all movies where language is english and age_certificate is  equal to 18
Select * From movies
Where
	movie_lang = 'English' And age_certificate = '18';


--------------------------------OR----------------------------------
-- get all English or Chinese movies and sorted in movie lang
Select * From movies
Where
	movie_lang = 'English' Or movie_lang = 'Chinese'
Order By movie_lang;


----------------------------And Or ------------------------
-- Get english or chinese movies where age equals to 12 and  in descending order
-- Use parentheses
Select * from movies
Where
	(movie_lang='English' Or movie_lang = 'Chinese') And age_certificate ='15'
Order By  movie_lang DESC;


-- And operator process first then Or process second
-- When we are using multiple operator then always use parentheses

-- we can change column name using As keyword
-- Wrong syntax
Select 
	first_name,
	last_name As surname
From actors
Where surname = 'Allen';

-- right syntax
Select 
	first_name,
	last_name As surname
From actors
Where last_name = 'Allen';

-- Order of Execution -- From|Where|Select|order By

------------------------------------------------Logical Operator--------------------------------
-- Get all movies where length is greater then 100
Select * From movies
Where
	movie_length >100;

-- Postgres will store date in YYYY-MM-DD format by default

-- Get all movies where release date is greater then 2000
-- Use quotes for dates as well
Select * from movies
Where release_date > '2000-12-31'
Order By  release_date ASC;

-- We can omit the quotes in numeric data
-- but if we have quotes then also same result

------------------------------------Limit--------------------------------
-- Get top 5 movies by movie length
Select * from movies
Order By movie_length Desc
Limit 5;

-- Get top 10 youngest female actors
Select * From actors
Where 
	gender = 'F'
Order By
	date_of_birth Desc
Limit 
	10;

---------------------------Offset -------------------------------------------

-- List 5 movie starting from 4th one sorted by movie id
Select * From movies
Order By movie_id
Limit 5 Offset 3;

-- List all top 5 movies after the top 5 highest domestic profitable movies

Select * From movies_revenues
Order By revenue_domestic Desc Nulls Last
Limit 5 OffSet 5;



---------------------------------------------Fetch------------------------------------
-- Fetch work similarly like limit
-- Syntax   Fetch {First | Next}  {count} {Row | Rows} Only
-- Get first row from movie table
Select * From movies
Fetch First 1 Row Only;
-- Get first 5 rows from movie table
Select * From movies
Fetch First 5 Row Only; 

-- Get top 5 biggest movies  by movie length starting from 5
Select * from movies
Order By movie_length Desc
Fetch First 5 Row Only
Offset 5;

-------------------------In Not In-----------------------------
-- we use these keyword to check if certain thing is present in list or not
-- it always return true or false only

-- Get all movies in english japanese and chinese
Select * from movies
Where
	movie_lang = 'English' or
	movie_lang = 'Japanese' or
	movie_lang = 'Chinese'
Order By movie_lang;

-- using In operator
Select 
*
From movies
Where
	movie_lang  In ('English','Chinese','Japanese')
Order BY
	movie_lang;

-- Get all movies where age certificate is 12 and PG Type
Select 
* 
From movies
Where
	age_certificate In ('12' , 'PG')
Order BY age_certificate;

-- Get all movies where directors Id is not 10 or 13
Select 
* 
From movies
Where director_id Not In (10,13)
Order By director_id;

-----------------------Between or Not Between------------------------
-- help us to matching range b/w 2 values
-- return actors whose birth_date is b/w 1991 1995
-- Inclusive in range
Select * From actors
Where date_of_birth Between '1991-01-01' And '1995-12-31'
Order By date_of_birth;


-- get all english movies where movie length in b/w 100 to 200 
Select * from movies
Where 
	movie_lang = 'English' And 
	movie_length Between 100 And 200
Order By
	movie_length;
	
-- get all english movies where movie length in not b/w 100 to 200 
Select * from movies
Where 
	movie_lang = 'English' And 
	movie_length Not Between 100 And 200
Order By
	movie_length;



--------------------Like ILike -------------------
-- used for patterns matching
-- always return true
-- % match 0 or more characters
-- _ matches 1 characters

Select 'hello' Like 'hello';

-- using %
Select 'hello' Like 'h%';
Select 'hello' Like '%e%';
Select 'hello' Like 'hell%';
Select 'hello' Like '%ll';

-- using _
Select 'hello' Like '_ello';
Select 'hello' Like '__ll_';

-- Get actors name starting with 'A'
Select * From actors
Where first_name Like 'A%'
Order By first_name;

-- Get all actors name where first_name is only 5 char
Select * From actors
Where Length(first_name) = 5;
Select * from actors
Where first_name Like '_____';

-- Like is case sensitive
-- ILike is not case sensitive

-----------------------Is Null Is Not Null-------------------------------
-- Is Null is used to final all null values
-- Is Not Null used to find all null values


-- Get all actors date of birth which are null
Select * From actors
Where date_of_birth Is Null;


-- Find list of actors with missing date of birth or name
Select * from actors
Where first_name Is Null Or date_of_birth Is Null;

-- find movies where domestic revenue is not null
Select * From movies_revenues
Where revenue_domestic Is Not Null;


---------------------------------Concatenation--------------------------------

-- we can use || this symbol for concat 2 string
-- we can use Concat(col1, col2) to concat 2 column
-- we can use Concat_Ws('|',col1, col2) to concat 2 column with | this symbol in B/w



-- concat 2 string Hello World
Select 'Hello' || ' ' || 'World' as "firstProg";

-- concat first_name and last_name
Select Concat(first_name,' ',last_name) from actors;


-- concat first_name , last_name , date of birth by comma
Select Concat_Ws(' , ',first_name,last_name,date_of_birth) from actors;


-- handling Null values
-- using  || 
Select 'Hello' || Null || 'World';
Select 'Hello' || 'Null' || 'World';

-- using concat
-- if both values are null then it will show | this symbol coz we are using this as delimiter
Select 
Concat(revenue_domestic , ' | ',revenue_international) 
From movies_revenues;


-- using concat_ws
-- if both values are null then it will show null
Select 
Concat_ws(' | ',revenue_domestic  ,revenue_international) 
From movies_revenues;
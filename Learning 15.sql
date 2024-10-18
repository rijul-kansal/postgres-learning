------------------------------------------Count---------------------------
-- count all records
Select Count(*) From movies;

-- count any particular column
Select Count(movie_lang) From movies;

-- count distinct rows only
Select Count(Distinct(movie_lang)) From movies;

-- count all Japanese movies
Select Count(*) from movies
where movie_lang = 'Japanese';

--------------------------------------Sum-------------------------
-- only numbers are allowed
-- sum of length of all english movies
Select Sum(movie_length) From movies
Where movie_lang ='English';

-- only distinct
-- Sum(Distinct(column name))

-----------------------------------------Min Max -------------------------------
-- longest and shortest length  of movies
Select Max(movie_length) , Min(movie_length) From movies;

-- latest movie
Select Max(release_date )From movies;
-- max work on varchar also
Select Max(movie_name) From movies;


-------------------------------Greatest and Least----------------------------
-- find max or min from list 
-- all list value must be same data type
Select Greatest(10,20,30);
Select Least('A','B');

----------------------------------Average---------------------------
-- get avg movie length
-- avg ignore null values
Select Avg(movie_length) From movies;


------------------------Operators-------------------------------
--- + - / % *
--- if one col is ull final res is null
-- get all revenue 
Select Movie_id ,
	revenue_domestic,
	revenue_international,
	(revenue_domestic + revenue_international)
From movies_revenues;
-- Avg(Distinct(col name));
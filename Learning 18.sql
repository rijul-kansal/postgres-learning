-------------------------Inner Join-----------------------------------
-- Here col 1 of table 1 must match col 1 of table 2

-- join movies and directors
Select 
	movies.movie_name,
	directors.first_name || ' ' || directors.last_name AS "Full Name"
From movies
Inner Join directors
On
	movies.director_id = directors.director_id
Order By movies.director_id;

-- using alias for tables
Select 
	mv.movie_name,
	dr.first_name || ' ' || dr.last_name AS "Full Name"
From movies mv
Inner Join directors dr
On
	mv.director_id = dr.director_id;
	
---- filter data
---- only english movies and dir id 3

Select 
	mv.movie_name,
	dr.first_name || ' ' || dr.last_name AS "Full Name"
From movies mv
Inner Join directors dr
On
	mv.director_id = dr.director_id
Where
	mv.movie_lang='English' And dr.director_id = 3;

-- getting all data
Select 
	mv.*,
	dr.*
From movies mv
Inner Join directors dr
On
	mv.director_id = dr.director_id;


-- if both table name common then we can use using col1 instead on
Select *
From movies mv
Inner Join directors dr
 Using(director_id);

--- combining multiple tables
Select *
From movies
Inner Join directors using (director_id)
Inner Join movies_revenues using (movie_id);

--- Select movie name director name and domestic revenue where movies is japanese
Select movies.movie_name , directors.first_name , movies_revenues.revenue_domestic
From movies
Inner Join directors using (director_id)
Inner Join movies_revenues using (movie_id)
Where movies.movie_lang = 'Japanese';


--- Select movies name director name from all english chinese and japanese movies where domestic revenue is  greater then 100

Select 
	m.movie_name,
	d.first_name,
	r.revenue_domestic
From movies m
Inner Join directors d using (director_id)
Inner Join movies_revenues  r using (movie_id)
Where m.movie_lang In ('Japanese', 'Chinese','English') And r.revenue_domestic > 100;


--- movie name directors name and movie lang , total revenue for all top 5 movies

Select 
	m.movie_name,
	d.first_name,
	m.movie_lang,
	(r.revenue_domestic + r.revenue_international) AS "total Revenue"
From movies m
Inner Join directors d using (director_id)
Inner Join movies_revenues  r using (movie_id)
Order By 4 Desc Nulls Last
Limit 5;

-- most top 10 profitable movies b/w years 2005 to 2008 print movie name directors name movie lang , total revenues

Select 
	m.movie_name,
	d.first_name,
	m.movie_lang,
	(r.revenue_domestic + r.revenue_international) AS "total Revenue"
From movies m
Inner Join directors d using (director_id)
Inner Join movies_revenues  r using (movie_id)
Where m.release_date Between '2005-01-01' And '2008-12-31'
Order By 4 Desc Nulls Last
Limit 10;

-- we cant join table with different data type
-- we can use cast in order to join tables
--------------------------------Left Join----------------------------------------
-- return all rows from lft side and if no row matches on right side then return null col values from right side column

Create table left_p(
	p_id Serial Primary key,
	p_name Varchar(100)
);

Create table right_p(
	p_id Serial Primary key,
	p_name Varchar(100)
);

Insert Into left_p(p_id,p_name)
Values
(1,'a'),
(2,'b'),
(3,'c'),
(5,'d');

Insert Into right_p(p_id,p_name)
Values
(1,'a'),
(2,'b'),
(3,'c'),
(4,'e'),
(7,'f');

Select *
From left_p
Left Join right_p using(p_id);

--Count all movies for each director

Select d.first_name,d.last_name,Count(*) From movies mv
Left Join Directors d Using(director_id)
Group By d.first_name,d.last_name;


-- get the total revenue done by each film for each directors

Select d.first_name, d.last_name,SUM(r.revenue_domestic + r.revenue_international) From directors d
Left Join movies m Using(director_id)
Left Join movies_revenues r Using(movie_id)
Group By d.first_name , d.last_name
Having SUM(r.revenue_domestic + r.revenue_international) >0
Order By 3 Desc Nulls Last;

-------------------------------------Right Join-----------------------------
-- instead lf left we will use right
---------------------------------------Full joins--------------------------
-- here we will get all match as well as un match records
Select * From left_p Full Join right_p Using(p_id);

---------------------------------------Self Join------------------------------
-- allow you to compare rows  of same table
Select * From left_p l1
Inner Join left_p l2 Using(p_id);

-- Get 2 movies name where movie len is equal 

Select t1.movie_name , t2.movie_name
From movies t1
Inner Join movies t2 On t1.movie_length = t2.movie_length And t1.movie_name != t2.movie_name;

------------------------------------Cross Product-----------------------------------
-- if t1 have 4 rows and t2 have 3 rows then final res if 4*3=12

Select * From left_p Cross Join right_p;

-----------------------------------------Natural Join -----------------------------
-- this will join all same column together
-- let table 1 have id name age
-- let table 2 have id name color
-- result have id name age color

Select * From left_p
Natural Inner Join right_p;

Select * From left_p
Natural Left Join right_p;

Select * From left_p
Natural Right Join right_p;

------Coalesce(a,b) -- always give first value
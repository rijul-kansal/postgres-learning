-------------------------------------------Group By-----------------------------------
-- Get count of all movies by movie length
Select movie_lang , Count(movie_lang) From movies
Group By movie_lang;

-- Get avg movie length group by movie language
Select movie_lang, Avg(movie_length)
From movies
Group By movie_lang
Order By movie_lang;

-- Get sum of total movie length as per age certificate
Select Age_certificate, Sum(movie_length)
From movies
Group By age_certificate;

--- List min max movie length group by movie length
Select 
	movie_lang,Min(movie_length), Max(movie_length) 
From movies
Group By movie_lang
Order By 3 Desc;


--- Group by eliminate duplicate value from result
Select movie_length From movies
Group By movie_length;

--- Avg movie_length group by 	movie language and age certificate
Select 
	age_certificate,movie_lang,Avg(movie_length) 
From movies
Group By movie_lang, age_certificate;


--- Avg movie_length group by 	movie language and age certificate where movie_length is greater then 100
Select 
	age_certificate,movie_lang,Avg(movie_length) 
From movies
Where movie_length > 100
Group By movie_lang, age_certificate;

-- AGGREGATE fn are not allowed in Groups
Select 
	age_certificate,movie_lang,Avg(movie_length) 
From movies
Where movie_length > 100
Group By movie_lang, age_certificate,Avg(movie_length);

--- order
From Where Group By Having Select Distinct Order By Limit 

------------------------------------Having----------------------------------
-- no alias in having clause
-- only work in AGGREGATE fn
-- List movie lang where total length of movies greater then 200
Select 
	movie_lang,
	Sum(movie_length)
From movies
Group By movie_lang
Having Sum(movie_length) > 200
Order By 2;

-- Having work on result group
-- Where not work on result group

------------------------Null values ---------------------------
Create Table sample(
	dept varchar(200),
	sal Int
);

Insert Into sample(dept,sal) 
Values('f',2),(null,2);

-- change null value col name to something else 
Select 
	Coalesce(dept,'* No Dept *'),
	Count(dept)
From Sample
Group By Dept;
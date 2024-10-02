-- Create table 
-- create actor table 
-- SERIAL is used for initializing value with +1
-- not null constrains are used so that the col will not contain null values
Create Table If Not Exists actors (
	actor_id Serial Primary Key,
	first_name varchar(150),
	last_name varchar(150) Not Null,
	gender char(1),
	date_of_birth Date,
	added_at Date,
	updated_at Date
);
-- create directors table 
Create Table If Not Exists directors (
	director_id Serial Primary Key,
	first_name varchar(150),
	last_name varchar(150) Not Null,
	date_of_birth Date,
	nationality varchar(20),
	added_at Date,
	updated_at Date
);
-- creating movies table 
-- foreign key syntax
-- column_name dataType Reference tale_name_of_foreign_key(column_name_from_that_table)
Create Table If Not Exists movies(
	movie_id Serial Primary Key,
	movie_name varchar(100),
	movie_length Int,
	movie_lang varchar(20),
	age_certificate varchar(10),
	release_date Date,
	director_id INT References directors(director_id)
);
-- creating movies revenue table
-- Numeric(10,2) // contain 2 decimal precision
Create Table If Not Exists movies_revenues(
	revenue_id Serial Primary Key,
	movie_id Int References movies(movie_id),
	revenue_domestic Numeric(10,2),
	revenue_international Numeric(10,2)
);
-- junction table for movie and actors 
-- this is an example where we can make multiple column as primary key
Create Table If Not Exists movies_actors(
	movie_id Int References movies(movie_id),
	actor_id Int References actors(actor_id),
	Primary Key(movie_id , actor_id)
);
Select * From movies_actors;
-- Delete entire table
-- Drop Table table_name
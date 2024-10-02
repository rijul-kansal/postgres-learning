-- Lecture 4
-- Inserting values into table
Create Table If Not Exists customers(
	cust_id Serial Primary Key,
	first_name varchar(50),
	last_name varchar(50),
	age Int
);

-- Inserting data 
-- multiple data 
Insert Into customers(first_name , last_name,age)
Values 
 ('Rahul' ,'kansal',31),
 ('Ronak' ,'kansal',22),
 ('Rijul' ,'Bansal',22);
 
-- if we want to add data like Rijul's Kansal then we will use additional single quote 
Insert Into customers(first_name , last_name,age)
Values 
 ('Rahul''s' ,'kansal',31);

--  we want to  return all the added rows 
-- we can achieve this using returning statement
Insert Into customers(first_name,last_name)
Values
	('Karan','Yadav') Returning *;
	
-- we only want to see any particular column of newly inserted row	
Insert Into customers(first_name,last_name)
Values
	('Karan','Yadav') Returning cust_id;

-- Update single column of single row
Update customers
Set 
first_name ='Ananya'
Where cust_id=1;

-- Update multiple column of single row
Update customers
Set
first_name = 'Soumil',
last_name  = 'Aggarwal'
Where cust_id=2	;

-- Returning only affected rows
Update customers
Set
first_name = 'Harshitha'
Where cust_id = 4
Returning *;

-- if we want to update all rows at once then just simply remove where clause

-- Delete single row
Delete From customers
Where cust_id=1;

-- Delete all the data -- by removing where clause

-- Upsert 
--   Idea is when postgres will find similar value of any particular col then it will update 
--   else insert new row

Create Table t_tags(
	id serial Primary Key,
	tag varchar(30) Unique,
	update_date timestamp Default Now()
);

Insert Into t_tags(tag)
Values
('Pen'),
('Pencil')


-- if we find matching row then do nothing 
Insert Into t_tags(tag)
Values ('Pen')
On Conflict (tag)
Do
	nothing;

-- if we find same row then update latest data
Insert Into t_tags(tag)
Values
('Pen')
On Conflict (tag)
Do
	Update Set
	update_date = Now();
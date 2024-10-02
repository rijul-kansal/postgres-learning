---------------------------------------Sequence----------------------------------------
--- Increment 
Create Sequence text;

-- get next value
Select nextval('text');

-- get current val
Select currval('text');

-- set particular value to seq
-- next value = 101
Select setval('text',100); -- current value = 100
-- next value = 200
Select setval('text',200, false); -- current value = 103

--- adding start with when create sequence
Create Sequence text1 Start With 100;

-- Alter sequence
Alter Sequence text Restart With  5; 
Alter Sequence text Rename To my_test;

-- Create seq with params
Create Sequence text2
Increment 50
MinValue 100
MaxValue 1000
Start With 200;

-- default max value is bigint
-- we can have smallint int bigint
Create Sequence text3 As int;

-- by default sequence is ascending
-- with cycle when comes to 1 then again go back to 3 
Create Sequence test4
Increment -1
MinValue 1
MaxValue 3
Cycle;
Select nextval('test4');

-- attaching seq to table
Create table users(
	id Int Primary key,
	name varchar(22)
);

Create Sequence seq start with 100 owned by users.id;

Alter Table users
Alter Column id Set Default nextval('seq');

-- list all seq
Select relname sequence_name
From pg_class
where relkind = 'S';

--- share single seq to multiple seq
Create Sequence fruit start with 100;
Create table apples(
	f_id Int Default nextval('fruit'),
	f_name varchar(100)
);
Create table mangoes(
	f_id Int Default nextval('fruit'),
	f_name varchar(100)
);

Insert Into apples(f_name) Values('a1');
Insert Into mangoes(f_name) Values('m1');
Select * from apples;
Select * from mangoes;

--- create alphanumeric seq

Create Sequence tt ;
Create Table test(
	idd Text Default ('id_' || nextval('tt')),
	namee varchar(100)
);

Insert Into test(namee) values('rk');
Select * From test;
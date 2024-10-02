------------------------------Creating custom Domain----------------------------
-- These help to use our own define data types to reuse may times
-- valid in same scope only
-- contain single type

-- create data type addr which is always not null and max len is 100 char
Create Domain addr Varchar(100) Not Null; 
Create Table general(
	address addr
);

-- crate positive_numeric which contain only +ve value
Create Domain positive_numeric Int Not Null Check(Value >0);

-- create email_validator
Create Domain email_validator VarChar(150)
Check(Value ~*'^[A-Za-z0-9._%-]+@[A-Za-z0-9._%-]+[.][A-Za-z]+$');

-- create enum of red blue
Create Domain check_color Varchar(10)
Check(Value In ('red','blue'));

--list all domains
Select typname
From pg_catalog.pg_type
Join pg_catalog.pg_namespace
On pg_namespace.oid = pg_type.typnamespace
Where
typtype='d' And nspname = 'public';


-- drop domain
-- here we are using cascade coz if domain is used some where in table at that time this will throw error 
-- so we are using CASCADE this will help us to run below line without error and remove the corresponding 
-- column from table
Drop Domain check_color Cascade ;

----------------------------User Define Composite data type--------------------------------------
-- here we can create our own data type which contains multiple values

Create Type address AS(
	city varchar(100) ,
	country varchar(100));


Create Table comp(
	comp_id Serial,
	comp_add address
);

Insert Into comp(comp_add) 
Values
	(Row('Mumbai','India')),
	(Row('Bangalore','India')),
	(Row('Sydney','Australia'));

Select * From comp;
-- Select any particular field only
Select (comp.comp_add).country From comp Where (comp_add).city = 'Mumbai';

--Creating ENUM
Create Type currency As ENUM ('USD','INR');

Select 'INR'::currency;
-- alter type
Alter Type currency Add Value 'AAA' After 'USD';

-- delete type
Drop Type currency;

--- alter type name
Alter Type address Rename To my_address;

-- change type owner
Alter Type my_address Owner To postgres;

-- change schema 
Alter Type my_address Set Schema test;

-- add new attribute 
-- we are using test...
-- coz my add is present in test schema
Alter Type test.my_address Add Attribute street_add varchar(50);

-- alter enum value
Create Type currency As ENUM ('USD','INR');
Alter  Type currency Rename Value 'USD' To 'GRP';

-- alter enum to add new value
Alter Type currency Add Value 'USD';

-- get all type on enum
Select enum_range(NULL::currency);



----- How to change remove values from enum in production
create Type status_enum AS ENUM('waiting','running','done');
Create Table jobs(
	job_id Serial primary key,
	status status_enum
);

Insert Into jobs(status)
Values
	('running'),
	('done'),
	('waiting'),
	('waiting');
Select * From jobs;


-- first make waiting to running
Update jobs 
Set status = 'running'
Where status = 'waiting';

-- change enum name
Alter Type status_enum  Rename To status_enum_old;

-- create new enum 
create Type status_enum AS ENUM('running','done');

-- alter table with new enu type
Alter Table jobs
Alter column status
Type status_enum USING status::text::status_enum;

-- how to ser default value 
Create Table jobs1(
	job_id Serial primary key,
	status status_enum Default 'running'
);
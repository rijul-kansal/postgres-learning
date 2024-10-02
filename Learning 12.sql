----------------------Constraints----------------------
-- not allow to enter invalid data
-- we have to type of constraints
-- table level  --- primary ,foreign key
-- column level -- not null unique check default

-----------------------------Not NUll-------------------------
-- accepted value '' , 'NULL' , '0'
-- not accepted value NULL

----------------------------UNIQUE-------------------------
--adding unique constraint to multiple column
Create Table unique_table(
	id Serial Primary key,
	unique_id varchar(100),
	unique_name varchar(100),
	Unique(unique_id, unique_name)
);

-- this will combine 2 or more column and then check 
Insert Into unique_table(unique_id, unique_name) Values('A','Apple');
Insert Into unique_table(unique_id, unique_name) Values('A','Apple11');
Insert Into unique_table(unique_id, unique_name) Values('A1','Apple');
-- error
Insert Into unique_table(unique_id, unique_name) Values('A','Apple');
Select * From unique_Table;

-- another way to add constraint
Alter Table unique_table 
Add Constraint uniquecont Unique(unique_id, unique_name);


---------------------------------------------------Default------------------------------------------------------
--- Drop Constrain
Alter Table unique_table
Alter Column Drop Default;

---------------------------------------Primary Key-----------------------
-- only single primary key in single table
-- primary key contain on single column or multiple column
-- if multiple column then primary key  == composite key
-- if multiple column then postgres see as col1col2 as string similar as unique defined above
-- creating composite key order is important

Drop Table items;
Drop Table unique_table;
----------------------Foreign Key----------------------------

-- without foreign key
Create Table products(
	prod_id Int Primary Key,
	prod_name varchar(100) Not Null,
	supplier_id Int Not Null
);
Create Table suppliers(
	supplier_id Int Primary Key,
	supplier_name varchar(100) Not Null
);

Insert Into suppliers(supplier_id,supplier_name) Values
(1,'s1'),
(2,'s2');
Select * From suppliers;

Insert Into products(prod_id,prod_name, supplier_id) Values
(1,'p1',1),
(2,'p2',2),
(3,'p3',22);
Select * From products;

-- here supplier id 22 is missing -- no integrity 
-- so we use foreign key to main integrity
Drop Table products;
Drop Table suppliers;

Create Table suppliers(
	supplier_id Int Primary Key,
	supplier_name varchar(100) Not Null
);

Create Table products(
	prod_id Int Primary Key,
	prod_name varchar(100) Not Null,
	supplier_id Int Not Null,
	Foreign Key (supplier_id) References Suppliers(supplier_id)
);


Insert Into suppliers(supplier_id,supplier_name) Values
(1,'s1'),
(2,'s2');
Select * From suppliers;

Insert Into products(prod_id,prod_name, supplier_id) Values
(1,'p1',1),
(2,'p2',2);
Select * From products;

-- error coz 22 is not present in supplier table
Insert Into products(prod_id,prod_name, supplier_id) Values
(3,'p3',22);

Insert Into suppliers(supplier_id,supplier_name) Values
(22,'s2');
Select * From suppliers;

-- error
Delete from suppliers Where supplier_id=22;
Delete from products Where prod_id=3;

-- error
Update products
Set supplier_id=12
Where prod_id=1;


-- Drop foreign key
Alter Table table_name
Drop Constraint cname;

-- Add constraint
Alter table tablename
Add Constraint cname Foreign key colName References tableName(colName);


-----------------------------CHECKS-----------------------------------
Create Table staff(
	first_name varchar(50),
	date_of_birth Date Check (date_of_birth > '1900-01-01'),
	joined_date Date Check (joined_date > date_of_birth),
	salary numeric Check(salary >100)
);

Insert Into staff(first_name,date_of_birth,joined_date,salary)
Values('Rijul','2002-10-07','2022-01-13','1500000');

--error
Insert Into staff(first_name,date_of_birth,joined_date,salary)
Values('Rijul','2002-10-07','2002-01-13','1500000');

Select * From staff;

-- error
Update staff
Set salary  = -100
Where first_name = 'Rijul';


-- add check constrain later
Alter Table staff
Add Constraint check_cons 
Check(
	date_of_birth >'1900-01-01' 
	And joined_date > date_of_birth
	And salary >0
);
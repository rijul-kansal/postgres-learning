-- create a schema
Create schema a;

-- Rename Schema
Alter Schema a Rename To b;

-- drop a schema
Drop Schema b;

---  If we have multiple schema then how to access table of that schema
-- Select * From database_name.schema_name.table_name

-- how to movie table from one schema to another 
Create Schema b;
Alter Table sample Set Schema b;


-- here we directly use Select * From emp no need to use above syntax coz by default current schema is public
Select current_schema();

-- first it will check in users define schema then public
show Search_path; --"""$user"", public"

-- how to add Schema in search path 
Set search_path To "$user",a,"public";

-- now we don't need this syntax
-- specifically for b as we added b schema in search path 
-- first it will check with user if not found then go to b if found then stop else go to public if found return else error
-- this is based on our own define search path
-- Select * From database_name.b.table_name

-- alter schema owner ship
-- Alter Schema schema_name Owner To new_owner

-- how to copy schema with same data -- check video 

--- ---------------------------privilege----------------------------------
-- if schema owner is a then b can't access that schema 
-- we need to grant usage permission -- for read
-- or create permission -- for read and write

-- this will give permission to schema not table
-- Grant Usage On Schema schema_name To user_name

-- this will grant only select statement to user
-- Grant Select On All Tables  In Schema schema_name To user_name

-- grant create permission 
-- Grant Create On Schema schema_name To user_name

-- how to login using terminal 
 --in terminal write

 -- psql -h hostname -U user_name -d database name
 
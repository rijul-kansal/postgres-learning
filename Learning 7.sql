-------------Boolean ----------------
--True -- TRUE, 'true','t','y','yes','1'
--False -- FALSE, 'false','f','n','no','0'

Create Table If Not Exists table_boolean(
	bool_id Serial Primary Key,
	is_available Boolean Not Null
);

Insert Into table_boolean(is_available)
Values (True), ('true') , ('t'), ('y') ,('yes') , ('1'),
 (False), ('false') , ('F'), ('n') ,('no') , ('0');

Select * From table_boolean; 

-- where condition
Select * from table_boolean
-- where is_available = 'true';
-- where is_available = 'false';
-- where is_available = True;
-- where is_available = FALSE;
-- where is_available = '1';
-- where is_available = 'true';
-- where is_available ; -- RETURN  all TRUE
-- where Not is_available ; -- RETURN all fALSE

-------------------------storing string-------------------------------
-- 3 types 
-- Character(n) , Char(n) -----    fixed length blank padded
---Character varying(n) , varchar(n) -- variable length but upper limit
---Text , varchar ----variable length no limit

-- if n is not define then default is 1
-- if length exceed and all are spaces then postgres will truncate all spaces to fit in n

--Cast()-- this fn help us to change data type
--space is wasted
Select Cast('Rijul' As Character(10)) As Name1;
Select 'Rijul'::Char(10) As Name2;


--- in Character Varying(n) or varchar(n) no space is wasted
Select 'Rijul'::varchar(10);
Select 'Rijul is good boy + 123325356%^5'::varchar(30);

-- Text is variable length
Select 'Rijul kansal is a good boy'::text;
Select 'Rijul kansal is a good boy'::varchar;


----------------------------------Number--------------------------
-- Number can not contain null values
-- Math operation perform on number data only
-------------                  Integers                    --------------
-- can contain whole number both +ve -ve
--                                       3 Main types
--                         smallint -----2 bytes--- -32768  - 32767 
--                         integer -----4 bytes--- -2147483648  - 2147483647
--                         bigint  -----8 bytes----  -9223372036854775808 - 9223372036854775807


--					       Auto increment : Serial
--	    			       smallserial  2 Bytes   1 to 32767
--   				       serial  4 Bytes   1 to 2147483647
--					       bigserial  8 Bytes   1 to 9223372036854775807


-----------------------------------Decimal------------------------------
-- contain whole number plus a fraction of whole number


----------Fixed-point number----------
-- numeric(precision,scale)
-- decimal(precision,scale)
-- it contains 131027 on left and 16383 on right side
-- precision -- total digit 
-- scale -- no of digit to right of fraction 

--------Floating point number----------
--real    4 bytes -- precision to 6 digit on right side
--double precision  8 bytes  -- precision to 15 digit on right side

Create table random(
	col_1 numeric(20,5),
	col_2 real,
	col_3 double precision
);

Insert Into random(col_1,col_2,col_3)
Values
(.9,.9,.9),
(3.13579,3.13579,3.13579),
(4.1357987645,4.1357987645,4.1357987645);

Select * From random;
drop Table random;

-------------------------------------Date----------------------------
-- use 4 bytes
-- default format YYYY-MM-DD
-- key word Current_date -- store current date

Create table date_table(
	_id Serial,
	name varchar,
	add_date_1 Date,
	add_date_2 Date Default Current_Date
);

Insert into date_table(name,add_date_1)
Values
('Rijul1','2020-01-01'),
('Rijul2','2022-01-01');

Select * From date_table;
drop Table date_table;


-- Current Date
Select Current_date;

--current date and time
Select Now();

-----------------------------------Time--------------------------------------
-- used 8 bytes to store
-- column_name Time(precision)
-- precision represent no of fractional digit store in second space 
-- max value will be 6
--                      Different Format
--                           HH:MM
--                           HH:MM:SS
--                           HHMMSS
--                           MM:SS.pppppp
--                           HH:MM:SS.pppppp
--                           HHMMSS.pppppp


Create table time_table(
	_id Serial ,
	class_name varchar,
	start_time Time,
	end_time Time
);

Insert Into time_table(class_name,start_time,end_time) values
('Maths','08:01:00','09:00:00'),
('Physics','09:01:00','10:00:00');

Select * From time_table;
Drop Table time_table;

-- Get current time
Select  Current_Time;
Select  Current_Time(2);

-- Local time
Select LocalTime;
Select LocalTime(2);

-- Arithmetic Operation 
Select time '12:00' - time '04:00';


-- using Interval
-- Adding or subtracting values
-- interval(n type)
-- n can be any number
-- type can by second minute hours day month year 
Select
Current_time,
Current_time +interval'2 hour',
Current_time +interval'-2 hour';



---------------------------------------------Timestamp----------------------------------------
-- timestamp store date and time without timezone
-- timestamptz store date and time with timezone -- internally stored value in UTC
Create Table timezone_table(
	tg Timestamp,
	tgtz Timestamptz
);
--  Here we are storing value in 01 time zone and internally store in utc 
--  and when we see data then it will convert into  local time zone
Insert Into timezone_table(tg,tgtz)
Values ('2024-09-22 09:17:58.82989-05','2024-09-22 09:17:58.82989-01');
Select * From timezone_table;
Drop Table timezone_table;


-- show current timezone
Show Timezone;

-- change current timezone
Set TIMEZONE = 'America/New_York';
Set TIMEZONE = 'Asia/Calcutta';

-- current timestamp
Select Current_Timestamp; 
Select TimeOfDay();

-- i want to see some time to some other timezone
Select timezone('Asia/Singapore','2020-01-01 09:30:01');


----------------------------------------------------UUID------------------------------------------
--128 bit value
-- postgres does not have its own uuid system

-- create uuid-ossp extension first
Create  Extension  If Not Exists "uuid-ossp";

-- random uuid take timezone comp mac acc in consideration
Select uuid_generate_v1();
-- pure random number
Select uuid_generate_v4();


Create table uuid_table(
	product_id uuid Default uuid_generate_v1(),
	name varchar
);

Insert Into uuid_table(name)
values('ABC');
Select * from uuid_table;

-- change to V4

Alter table uuid_table
Alter column product_id
Set default uuid_generate_v4();

drop table uuid_table;
drop table t_tags;
drop table table_boolean;

-----------------------------------Array----------------------------------
-- store multiple values of same data type in single record

Create Table array_table(
	id Serial Primary Key,
	name varchar(100),
	phones Text[]
);

Insert Into array_table(name , phones)
Values('Rijul',Array['1234','5678']),
       ('Rijul1',Array['12345','56789']);

Select * From array_table;

Select 
	name ,
	phones [1]
From 
	array_table;
Select 
	name ,
	phones [1]
From 
	array_table
Where
	phones[2] = '56789'

Drop table array_table;
---------------------------------------------------hstore--------------------------------------------
-- store value in key-pair format
-- only text string is store
-- import module before use


-- Importing
Create Extension If Not exists hstore;

Create table hstore_table(
	id Serial primary key,
	title varchar(100),
	book_info hstore
);

Insert Into hstore_table(title,book_info)
values(
	'ABC',
	'
		"publisher"=>"ABC",
		"cost"=>"1.22",
		"printer_cost"=>"1"
	'
);

Select * from hstore_table;

-- getting any particular key 
Select book_info -> 'publisher' From hstore_table;



--------------------------------------JSON-------------------------------------
-- postgres store  in json 
-- store in format of text
-- jsonB is binary version of json
-- jsonB is more powerful as compared to normal json --- coz it includes pre procession indexing etc

Create table table_json(
id Serial ,
docs Json
);
-- here 2 is key and 3 is corresponding value
Insert Into table_json(docs)
Values
('[2,3,4,5,6,7]'),
('[2,3,4,5,7,8,8,9]'),
('{"key":"value","key1":"value2"}');

Select * From table_json;
-- with json we can not use operators
--find records with key 2
Select * from table_json
Where docs @> '2';

-- we can use with jsonB
Alter table table_json
Alter column docs Type JsonB;


---------------------------Network Address---------------------
-- postgres offer to store IPV4 IPV6 Mac address

------------------------------types----------------------------
--  cidr   -------7 to 19 bytes---------  store IPV4 IPV6 network 
--  inet   -------7 to 19 bytes---------  store IPV4 IPV6 host and network 
--  macaadr   -------6 bytes---------  store mac address 
--  macaadr8   -------8 bytes---------  store mac address (EUI Format) 

-- avoid store data into plain text coz this will help in type checking as well as special fn and operators
-- While sorting cidr and inet then IPV4 come first then IPV6 
-- also IPV4 mapped to IPV6
-- Indexing also support

Create table netadd_table(
 id Serial,
 ip inet
);

Insert into netadd_table(ip)
Values
('4.38.221.243'),
('4.152.207.126');

Select * from netadd_table;


-- Get subnet mask /24;
Select 
	ip,
	set_masklen(ip,24),
	set_masklen(ip::cidr,24)
From netadd_table;
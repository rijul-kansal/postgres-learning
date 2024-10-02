Create Table persons(
	person_id Serial Primary Key,
	first_name varchar(30) Not Null,
	last_name varchar(30) Not Null
);

-----------------------------------------Adding new column----------------------------------
Alter Table persons
Add Column age Int Not Null,
Add Column nationality Varchar(100) Not Null,
Add Column email Varchar(100) Unique;

Select * from persons;

----------------------------Rename a Table---------------------
Alter Table persons
Rename  To users;

Alter Table users
Rename  To persons;

---------------------------Rename a Column----------------------
Alter Table persons
Rename Column age To persons_age;

----------------------------Drop a Column----------------------------
Alter Table persons
Drop Column age;

Alter Table persons
Add Column age varchar(10);
Select * from persons;

----------------------------Change DataType Of Column ---------------------
-- this will work but changing char to int we need using keyword
Alter Table persons
Alter Column age Type Int
USING age::integer;

---------------------Set Default value for column
Alter Table persons
Add Column is_enables varchar(1);
Select * from persons;

Alter Table persons
Alter Column is_enables
Set Default 'Y';

Drop Table persons;

-------------------------------Adding constraints------------------------
Create Table web_links(
	link_id Serial primary Key,
	link_url Varchar(255) Not Null,
	link_target varchar(100) Not Null
);

Insert Into web_links(link_url,link_target) Values('www.amazon.com','_blank');
Select * From web_links;

Alter Table web_links
Add Constraint web_link_unique Unique(link_url);

Drop table web_links;

----------------------Add check data-------------------
Alter Table web_links
Add Column is_enables varchar(1);
Alter Table web_links
Add Check(is_enables In ('Y','N'));
Insert Into web_links(link_url,link_target,is_enables) Values('www.netlify2.com','_blank','Q');
Select * from web_links;
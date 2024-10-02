------------------------------To_Char()----------------------------------------------
--convert into string
--- in order to represent numeric value we use 9
Select To_Char(10012,'99999');

--- convert date to text
Select 
	release_date,
	To_Char(release_date , 'DD-MM-YYYY'),
	To_Char(release_date , 'Dy-MM-YYYY')
From movies;

-- extract timeStamp
Select To_Char(TimeStamp '2020-11-11 10:30:50','HH24:MI:SS');

-- adding dollar symbol 
Select 
	To_Char(revenue_domestic , '$9999D9999')
From movies_revenues;

--------------------------------------To_Number()--------------------------------
-- convert string to numeric
Select To_Number('123.33','999D99');
-- S represent Sign
Select To_Number('123.33-','999D99S');
-- L represent currency
Select To_Number('$123.33','L999D99');
-- G used to group
Select To_Number('1,2333','9G9999');

------------------------------------To_Date()-------------------------
-- convert string to date
Select To_Date('2020/12/12','YYYY/MM/DD');
Select To_Date('201212','YYMMDD');
Select To_Date('March 07, 2011 ','Month DD, YYYY');

----------------------------------To_TimeStamp()------------------------
-- convert string to time Stamp with time zone
Select To_TimeStamp('2020-11-11 10:20:20' ,'YYYY-MM-DD HH:MI:SS');
-- remove extra space and add default value also
Select To_TimeStamp('2020          11' ,'YYYY          DD');
-- error checking
Select To_TimeStamp('2020-13-11 10:20:20' ,'YYYY-MM-DD HH:MI:SS');


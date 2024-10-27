--------------------------------------Date---------------------------------
---  Date          Date only               YYYY-MM-DD

--------------------------------------Time---------------------------------
--- Time    Time only  HH:MM:SS
--- internally store as 24 hours format only in utc
--  02:10:10.ppp 
--  second can be extended to  SS.ppp  

-----------------------------------Time Stamp -----------------------------
--- TimeStamp    Date and Time only       YYYY-MM-DD HH:MM:SS.p	

--show dateStyle
Show DateStyle; -- "ISO, DMY"

--- change date style
-- Set DateStyle(type, format)
--   type      -IOS,Postgres, SQL, or German
--   format    -  MDY ,DMY,YMD 
--             - M--Month D--Day Y--Year

Set DateStyle= 'ISO, MDY';
Set DateStyle= 'ISO, DMY';

----------------------------To_Date()------------------------------
-- convert string to date

--------------------------Format----------------------------------- 
-- YYYY
-- Y,YYY
-- MONTH -- full month name in upper case
-- Month -- fun month name with first letter capital
-- month -- fun month name in lower case
-- MON -- abb month name in upper case
-- Mon -- abb month name with first letter capital
-- mon -- abb month name in lower case
-- MM -- 01 to 12
-- DAY  -- full day name in upper case
-- Day
-- day
-- DY
-- Dy
---dy
-- DD   -- value b/w 1 to 31
-- W value b/w 1 to 5
-- WW value b/w 1 to 53


Select to_date('2020-01-01' , 'YYYY-MM-DD');
Select to_date('01-01-2002' , 'MM-DD-YYYY');
Select to_date('Jan 01, 2001' , 'Mon DD, YYYY');


-------------------To_Timestamp()--------------------
Select To_TimeStamp('2020-01-01 10:01:01' ,'YYYY-MM-DD HH:MI:SS');
Select To_TimeStamp('2020-01-01 10:01:01' ,'YYYY-MM-DD HH:MI');
Select To_TimeStamp('2020-01-01 10:01:01' ,'YYYY-MM-DD HH');
Select To_TimeStamp('2020-01-01 10:01:01.4' ,'YYYY-MM-DD HH:MI:SS.MS'); -- 400 millisecond
Select To_TimeStamp('2020-01-01 10:01:01.004' ,'YYYY-MM-DD HH:MI:SS.MS'); -- 5 millisecond

Select Current_Timestamp;
------------------To_Char()------------------------------
Select To_Char('2020-01-01 10:00:12'::TimeStamp , 'YYYY Month Day');
Select To_Char('2020-01-01 10:00:12'::TimeStamp , 'YYYY Month Dy');
Select To_Char('2020-01-01 10:00:12+01:30'::TimeStamp , 'YYYY Month Dy HH:MI:SS tz');


-------------------Make Date fn----------------
-- Make_Date(YYYY,MM,DD);
Select Make_Date(2000,01,1);

------------------Make Time Fn-------------
-- Make_Time(HH,MM,SS);
select Make_Time(12,1,11);

----------------Make TimeStamp fn------------
-- Make_TimeStamp(YYYY,MM,DD, HH,MM,SS)
Select Make_TimeStamp(2020,10,01,10,1,01);

------------------------Interval--------------------------
-- Make_Interval(years,month,weeks,days,hours,minutes,second);
Select Make_Interval(2024,10,02,2,11,11,11);
Select Make_Interval(months => 10,days => 2,mins => 11);

----------------------------TimeStamptz----------------------
-- Make_TimeStamptz(years,months,days,hours,minutes,second);
-- time zone is optional
-- if no time zone then local time zone
Select Make_TimeStampTz(2020,12,11,11,11,11);

-- to view available time zone
Select * From pg_timezone_names;
Select * From pg_timezone_abbrevs;

-- convert value acc to ist
Select Make_TimeStampTz(2020,12,11,11,11,11,'IST');
Select Make_TimeStampTz(2020,12,11,11,11,11,'+05:30');
Select Make_TimeStampTz(2020,12,11,11,11,11,'EST');

--------------------Date Extraction------------------
-- Extract(field from source)
-- Date_Part(field , source)

-- Field 
-- Day -- from 1 to 31
-- Hour -- From 0 to 23
-- Minute  -- From 0 to 59
-- Second  -- From 0 to 59
-- Year


Select Extract('Day' From Current_TimeStamp),
	Extract('Month' From Current_TimeStamp),
	Extract('Year' From Current_TimeStamp),
	Extract('Epoch' From Current_TimeStamp);

Select Extract('Century' From Interval '500 years 11 month');


--------------------------Arithmetic operators----------------------------

-- add 10 days
Select '20200101'::date + 100;

Select '20200101'::date + Interval '10 years';

Select '202001'::time + '10 Seconds'::interval;

Select Current_TimeStamp,
	Current_TimeStamp + '32:01:01';
	
Select '20200101'::date - '1 Hour'::interval;

Select '30 minutes'::interval + '30 minutes'::interval;


---------------------------Overlap fn -------------------------
-- check if certain date or certain range date overlap with other or not
Select ('2020-01-01'::date , '2020-12-31') Overlaps ('2020-03-01'::date , '2020-09-30');
Select ('2020-01-01'::date , '2020-12-31') Overlaps ('2019-03-01'::date , '2020-09-30');
Select ('2020-01-01'::date , '100 days'::interval) Overlaps ('2020-03-01'::date , '2020-09-30'::date);


-----------------------------------------General Fns--------------------------------
-- here (2) is precision  
Select 
	Current_Date,
	Current_Time(2),
	Current_Time,
	Current_TimeStamp,
	Current_TimeStamp(2),
	localTime(2),
	localTime,
	localTimeStamp(4),
	localTimeStamp;

Select 
	Now(),
	Transaction_TimeStamp(),--similar to now only
	Statement_TimeStamp(), -- current time when statement is executing
	Clock_TimeStamp(); --shows current date and time changes during execution

-- give time stamp in text format
Select TimeOfDay();

-------------------------------Age----------------------------------
-- date1-date2
Select age('2020-01-01'::timestamp,'2010-10-12'::timestamp);
Select age('2020-01-01'::timestamp,'2020-10-12'::timestamp);
Select age('2020-01-01'::timestamp);

-------------------------------Epoch-----------------------------
-- ans in seconds
Select Extract(epoch From '2020-12-20'::timestamp) - Extract(epoch From '2020-10-20'::timestamp);

Create Table sample(
	id Serial Primary Key,
	date_ Date ,
	time_ Time,
	timeStamp_ TimeStamp
);

---- name         applicable to            notes
---  allballs      time                  00:00:00
---  now           date, time , timestamp
---  today         date, time stamp
--- tomorrow
--- epoch
--- infinity
--- -infinity

Insert Into sample(date_,time_,timeStamp_) Values
('now','allballs','infinity');
Select * From sample;


--- show current timezone
Show TimeZone;

----------------------------Date Truncate Fn ---------------------------------
-- this fn will truncate till we define
Select
	Date_Trunc('hour','2020-10-10 12:01:01'::timestamp);
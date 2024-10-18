 ---------------------------Upper---------------------------
Select Upper('amazing');
Select Upper(first_name) From directors;

-------------------------Lower-----------------------------
Select Lower('Amazing');
Select Lower(first_name) From directors;

---------------------------InitCap-------------------
-- make first char upper rest lower
Select InitCap('aMazing');
Select InitCap(first_name || ' ' || last_name) As "Full Name"
From directors;

---------------------left-------------------------
-- return Left(string,n) return n char from starting
-- return Left(string,m) return n-m char from starting

Select Left('abcde',2);
Select Left('abcde',-2);

---------------------Right----------------------------
-- return Right(string,n) return n char from ending
-- return Right(string,m) return n-m char from ending

Select Right('abcde',2);
Select right('abcde',-2);

--find all directors where last name ends with on
Select last_name
From directors
Where Right(last_name,2) = 'on'; 

------------------------Reverse---------------------
Select Reverse('Rijul kansal');

--------------------Split Part -------------------------------
Select Split_Part('A,B,C,D',',',2);
--Get release year for all movies
Select Split_Part(release_date::text,'-',1) As ReleaseYear From movies;


-------------------------------------Trim------------------------------------------
-- TRIM(Leading | Trailing | Both  [character] from String)
-- remove white spacing from front back or both
Select Trim( leading From '    Amazon    '); --  "Amazon    "
Select Trim( Trailing From '    Amazon    '); -- "    Amazon"
Select Trim( From '    Amazon    '); --          "Amazon"

-- remove any char from starting end and both
Select Trim(Leading 'A' From 'AAMAZONNN');


-------------------------------LTrim RTrim BTrim-----------------------------------
-- LTrim -- from left
-- RTrim -- from right
-- BTrim -- from both
Select LTrim('     Amazon      ');  -- "Amazon      "
Select RTrim('     Amazon      ');  -- "      Amazon"
Select BTrim('     Amazon      ');  -- "Amazon"
Select LTrim('Amazon','A');

-----------------------LPad RPad---------------------------------
-- Add any char or empty space

Select LPad('abcde',11,'*'); -- adding 6 * in starting
Select RPad('abcde',11,'*'); -- adding 6 * in ending
Select LPad('abcde',11); -- adding 6 space in starting
Select RPad('abcde',11); -- adding 6 space in ending "abcde      "

--------------------------Length-------------------------------
Select Length('rijul kansal');
Select Length('');
Select Length(' ');
Select Length(null);

---------------------------Position--------------------------
--- this fn help us to identify substring  in a string
--  return only first occurrence 
---  case sensitive
-- value start with 1
Select Position('Amazon' in 'Amazon branch');
Select Position('is' in 'this is a banana');


----------------------STRPOS()---------------------------
-- same as position fn 
-- but syntax is different
Select StrPos('world Bank','Bank');

-----------------------------------Substring----------------
-- index start from 1
Select Substring('what is wonderful course it is',1,10);


------------------Repeat---------------
Select Repeat('abc ',4);

----------------------Replace-----------------------------
--- case sensitive
-- replace all occupance

Select Replace('what a wonderful substring','a wonderful','an amazing');
Select Replace('XXYYZZXX','X','1');
------------------------------------Union------------------------------------------
-- combine same column from multiple tables
--- distinct records only
-- must have same column name 
Select p_id, p_name From left_p
Union
Select p_id, p_name From right_p;

-- only distinct records
Select  p_name From left_p
Union
Select  p_name From right_p;

-- get all records
Select  p_name From left_p
Union All
Select  p_name From right_p;

-- combine first name and last name from directors and actors
Select first_name, last_name From directors
Union
Select first_name,last_name From actors;

-- all params should be of same column name
-- Select gender From directors
-- Union
-- Select first_name From actors;

---- order by
Select first_name, last_name From directors
Union
Select first_name,last_name From actors
Order By first_name ;

--- combine all directors with nationality japanese with all female actors

Select first_name From directors Where nationality = 'Japanese'
Union
Select first_name From actors Where gender = 'F'

-- how to combine table with one less no of col
-- Select c1 ,c2 From t1
-- Union
-- Select null as c1 ,c3 from t2;

----------------------------------Intersect------------------------
Select first_name, last_name From directors
Intersect
Select first_name,last_name From actors
Order By first_name ;

-------------------------------------------Except---------------------------------------
--- A-B
Select first_name, last_name From directors
Except
Select first_name,last_name From actors
Order By first_name ;
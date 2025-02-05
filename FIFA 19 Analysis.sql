use FIFA_19; -- Selecting the dataset

-- Displaying the entire dataset
select * from FIFA19;





-- Cleaning the dataset by removing 'â‚¬' from each currency columns
-- And replacing it with $
Update FIFA19
set Wage = REPLACE(wage, 'â‚¬', '');

update FIFA19
set Value = REPLACE(value, 'â‚¬', '$');

update FIFA19
set [Release Clause] = REPLACE([Release Clause], 'â‚¬', '$');





-- Upadting A Few PLayers Name
UPDATE FIFA19
SET Name = CASE 
              WHEN Name = 'K. MbappÃ©' THEN 'K. Mbappé'
              WHEN Name = 'O. DembÃ©lÃ©' THEN 'O. Dembele'
			  WHEN Name = 'VinÃ­cius JÃºnior' Then 'Vinicius jr '
           END
WHERE Name IN ('K. MbappÃ©', 'O. DembÃ©lÃ©', 'VinÃ­cius JÃºnior');

-- And much more can be done!



-- Selecting all players from argentina 

select name, nationality from FIFA19
where Nationality = 'Argentina'





-- Retrieving All Man City Players
select * from FIFA19
where club = 'Manchester City';





--All Players That Overall Highre Than 90
select * from FIFA19
where Overall >= 90;





-- Selecting All portuguese players from Manchester City
select Name, Nationality, Club 
from FIFA19
where Nationality = 'Portugal' 
and Club = 'Manchester City';





-- Retrieving the Average Age in this dataframe 
Select Avg(Cast(Age AS Float)) as Avg_Age
from FIFA19;


-- Counting The Players In Real Madrid

Select Club, COUNT(*) as player_count
from FIFA19
where club = 'Real Madrid'
group by Club
order by player_count desc;

--Total Players

SELECT COUNT(*) AS Total_Players
FROM FIFA19;
  
;

-- Average Wage

SELECT DISTINCT Wage --Inspecting the Column
FROM FIFA19
WHERE Club = 'Manchester United';

-- Final Query after replacing the characters 
SELECT CEILING(
    AVG(
        CASE
            WHEN RIGHT(Wage, 1) = 'K' THEN CAST(REPLACE(REPLACE(Wage, 'â‚¬', ''), 'K', '') AS FLOAT) * 1000 
            WHEN RIGHT(Wage, 1) = 'M' THEN CAST(REPLACE(REPLACE(Wage, 'â‚¬', ''), 'M', '') AS FLOAT) * 1000000
            ELSE CAST(REPLACE(Wage, 'â‚¬', '') AS FLOAT)
        END
    )
) AS Rounded_Avg_Wage -- Rounding the average value
FROM FIFA19
WHERE Club = 'Manchester United'; -- This Query was before i cleaned and update the dataset!!













-- Retrieving the Players with the highest composure
Select Club,Name,Composure
from FIFA19 f1
where composure = (
select max(composure)
from FIFA19 f2
where f1.Club = f2.club
)
order by Composure desc;




-- Scouting the players under 21 with the most potiential
Select name, age, potential, rank
from (
	Select name, potential,age,
				RANK() over (order by potential desc) as Rank
				from FIFA19
				)ranked 
	where age <= 21 and rank <= 5
	;




-- Top 3 Player In The DATASET  

SELECT name, overall, age, rank
FROM (
    SELECT name, overall, age,
           RANK() OVER (ORDER BY overall DESC) AS rank
    FROM FIFA19
) ranked
WHERE rank <= 3;

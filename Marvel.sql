
select * from marvels limit 20;

-- Filter out some conditions
select name,energy_Projection, max(height_m), min(weight_kg), avg(intelligence), avg(strength), avg(speed), 
        avg(fighting_Skills), avg(durability)
from marvels
where alignment != 'bad' and gender = 'Male'
group by name,energy_Projection
having energy_Projection > 4 ;


-- Rank name of characters in each hometown by weight
select hometown,name, weight_kg,
       RANK() OVER (PARTITION BY hometown ORDER BY weight_kg DESC) AS weight_kg_rank
from marvels;


-- Compare average difference between male marvels and female marvels.
select (select avg(intelligence)
		from marvels
        where gender = 'Male') as M_avg,
         
         (select avg(intelligence)
		  from marvels
          where gender = 'Female') as F_avg,
          
          ((select avg(intelligence)
		   from marvels
           where gender = 'Male') - (select avg(intelligence)
		                             from marvels
                                      where gender = 'Female')) as diff

from marvels;



-- Check the distribution of weight
select min(weight_kg), max(weight_kg), avg(weight_kg)
from marvels;

-- Conditionally derive new variables
select *, 
       case
	   when round(weight_kg,1) between 50 and 100 then "light"
       when round(weight_kg,1) between 101 and 169 then "medium"
       when round(weight_kg,1) between 170 and 862 then "heavy"
       else "other"
       end as "weight_level"
from marvels ;

-- Get the relationahop between intelligence and strength of each character
SELECT name, intelligence, strength,
       intelligence/strength AS ratio
FROM marvels
WHERE fighting_Skills >= 3
ORDER BY ratio DESC
LIMIT 10;









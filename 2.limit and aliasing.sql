# having  and group by

select gender,avg(age)
from employee_demographics
where avg(age) > 40
group by gender;

-- where avg(age) occur only when avg(age) of selecte ecuted after group by gender so having clause comes

select gender,avg(age)
from employee_demographics
group by gender
having avg(age) >40;

select occupation, avg(salary)
from employee_salary
group by occupation;
-- i cannot say where occupation like officer maneger b/c 

select occupation, avg(salary)
from employee_salary
where occupation liken'%manegers%'
group by occupation
having avg(salary) > 75000; -- this having only run if group by executed first


select occupation, avg(salary)
from employee_salary
group by occupation
having avg(salary) > 75000; 

# limit and aliasing

select * 
from employee_demographics
order by age desc
limit 3;

select * 
from employee_demographics
order by age desc
limit 2, 1; -- its mean we start from row 2 and pick the 1 row


select gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40;

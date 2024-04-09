-- Group by 
when you group rows you actually do aggregate function on those column
select *
from employee_demographics;

select gender
from employee_demographics
group by gender;

select first_name
from employee_demographics
group by gender; -- if we are not using aggregate function in select it should come in group by statement

select gender, avg(age)
from employee_demographics
group by gender;

select *
from employee_salary;

select gender, avg(age), max(age)
from employee_demographics
group by gender;

select gender, avg(age), max(age), min(age)
from employee_demographics
group by gender;

select gender, avg(age), max(age), min(age), count(age) 
from employee_demographics
group by gender;

-- ORDER BY

select * 
from employee_demographics
order by first_name;

select * 
from employee_demographics
order by first_name desc;

select * 
from employee_demographics
order by gender;

select * 
from employee_demographics
order by gender, age;

select * 
from employee_demographics
order by gender, age desc;
-- lets say we use age first then gender then 

select * 
from employee_demographics
order by age, gender; -- order by is useless for gender b/c they all become uniqe values
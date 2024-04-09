# WHERE CLAUSE

select *
from employee_salary
where first_name = 'leslie';   
# = , > , <  called comperison operator

select *
from employee_salary
where salary > 50000;

select *
from employee_salary
where salary >= 50000;


select *
from employee_salary
where salary < 50000;

select *
from employee_salary
where salary <= 50000;

# demograohic table

select *
from employee_demographics;

select *
from employee_demographics
where gender = 'FEMALE'

--- AND NOT OR LOgical operators
select  *
from employee_demographics
where birth_date > '1985-01-01'
and gender = 'male';

# OR either one is true

select  *
from employee_demographics
where birth_date > '1985-01-01'
OR gender = 'male';

select  *
from employee_demographics
where birth_date > '1985-01-01'
OR NOT gender = 'male';
-- if we being very specific we say name is lesli age 44 or age>55
select  *
from employee_demographics
where (first_name='leslie' and age = 44) OR age >55;

# we look at like statement
--% and _
select  *
from employee_demographics
where first_name = 'jerry'; 
-- if we write jer instead of jerry we could find any results here's like come in

select  *
from employee_demographics
where first_name like 'jer%';

# if we use %er% it means any thing comes fisrt any thing comes after but midle is er

select  *
from employee_demographics
where first_name like '%er%';

# if we want to if someone name startfrom a 

select  *
from employee_demographics
where first_name like 'a%';

# if want to know two character after a we use a__ 
select  *
from employee_demographics
where first_name like 'a__';

select  *
from employee_demographics
where birth_date like '1989%';

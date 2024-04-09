# joins
select *
from employee_demographics;

select *
from employee_salary;

select *
from employee_demographics As dem 
inner join employee_salary As sal
    on dem.employee_id = sal.employee_id;

select employee_id, age, occupation
from employee_demographics As dem 
inner join employee_salary As sal
    on dem.employee_id = sal.employee_id;  -- this give an error b/c it dont know what table employee.id to pull  
    
    
select dem.employee_id, age, occupation
from employee_demographics As dem 
inner join employee_salary As sal
    on dem.employee_id = sal.employee_id; 

-- outer join left and right    

select *
from employee_demographics As dem 
 left join employee_salary As sal
    on dem.employee_id = sal.employee_id;  

select *
from employee_demographics As dem 
right join employee_salary As sal
    on dem.employee_id = sal.employee_id;        

-- self join
select * 
from employee_salary As emp1
join  employee_salary As emp2
  on emp1.employee_id + 1 = emp2.employee_id;
  
-- to find out secreat santa
select emp1.employee_id As emp_santa,
emp1.first_name As first_name_santa,
emp1.last_name As last_name_santa,
emp2.employee_id As emp_name,
emp2.first_name As first_name_emp,
emp2.last_name As last_name_emp
from employee_salary As emp1
join  employee_salary As emp2
  on emp1.employee_id + 1 = emp2.employee_id;

-- joining multiple table
 
 select *
from employee_demographics As dem 
inner join employee_salary As sal
    on dem.employee_id = sal.employee_id; 

select * 
from parks_departments;    
    
 -- we gonna join this parks dept_id to department_id to salary table
 
  select *
from employee_demographics As dem 
inner join employee_salary As sal
    on dem.employee_id = sal.employee_id 
inner join parks_departments As pd
     on sal.dept_id = pd.department_id;    
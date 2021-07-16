create database employee;
use employee;

CREATE TABLE Departments (
  Code INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  Budget decimal NOT NULL 
);

CREATE TABLE Employees (
  SSN INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  Department INTEGER NOT NULL , 
  foreign key (department) references Departments(Code) 
);


INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);

select * from departments;
select * from employees;

-- 2.1 Select the last name of all employees.
select LastName from Employees;

-- 2.2 Select the last name of all employees, without duplicates.
select distinct LastName from employees;


-- 2.3 Select all the data of employees whose last name is "Smith".
select * from employees where lastname = 'Smith';

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select * from Employees where lastname in ('Smith', 'Doe');
select * from Employees where lastname = 'Smith' or lastname = 'Doe';


-- 2.5 Select all the data of employees that work in department 14.
select * from Employees where department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
select * from employees where department = 37 or department = 77;
select * from employees where department in (37, 77);


-- 2.7 Select all the data of employees whose last name begins with an "S".
select * from employees where LastName like 'S%';

-- 2.8 Select the sum of all the departments' budgets.
select name, budget from Departments;
select name, sum(budget) from departments group by name;


-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
select Department, count(*) from employees group by department;


-- 2.10 Select all the data of employees, including each employee's department's data.
select a.*, b.* from employees a join departments b on a.department = b.code;

SELECT SSN, E.Name AS Name_E, LastName, D.Name AS Name_D, Department, Code, Budget
 FROM Employees E INNER JOIN Departments D
 ON E.Department = D.Code;
 
  -- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select a.name, a.lastname, b.name dept_name, b.budget
from employees a join departments b 
on a.department=b.code;
 
-- without labels
select employees.name, lastname , departments.name as deptname, budget 
from employees inner join departments
on employees.department=departments.code;

/* With labels */
select e.name, lastname, d.name as deptname, budget
from employees e inner join departments d
on e.department=d.code;

select name, lastname
from employees
where department in (
select code from departments where budget>60000
);

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
select name, lastname
from employees 
where department in (
select code from departments where Budget>60000
);

-- without subquery
select e.name,lastname
from employees e inner join departments d
on e.department=d.code
and d.budget>60000;

/* With subquery */
SELECT Name, LastName FROM Employees
  WHERE Department IN
  (SELECT Code FROM Departments WHERE Budget > 60000);

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select *
from departments 
where budget > (
select avg(budget) from departments
);

SELECT *
  FROM Departments
  WHERE Budget >
  (
    SELECT AVG(Budget)
    FROM Departments
  );

-- 2.14 Select the names of departments with more than two employees.
select b.name from departments b
where code in (
select department from employees group by department
having count(*)>2
);

/* With subquery */
SELECT Name FROM Departments
  WHERE Code IN
  (
    SELECT Department
      FROM Employees
      GROUP BY Department
      HAVING COUNT(*) > 2
  );

-- 2.15
-- Very Important
-- Select the name and last name of employees working for departments with second lowest budget.
select name, lastname from employees
where department = (
select temp.code
from (select * from departments order by budget limit 2) temp
order by temp.budget desc limit 1
);

-- 2.16
-- Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert into departments values(11,'Quality assurance', 40000);
insert into employees values(847219811, 'Mary', 'Moore', 11);

-- 2.17
-- Reduce the budget of all departments by 10%.
update departments
set budget = 0.9*budget;


update departments 
set budget = 0.9 * budget;


-- 2.18
-- Reassign all employees from the Research department (code 77) to the IT department (code 14).
update employees
set department = 14
where department = 77;

-- 2.19
-- Delete from the table all employees in the IT department (code 14).

delete from employees
where department =14;

-- 2.20
-- Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from employees
where department in (
select code
from departments
where budget>=60000
);



-- 2.21
-- Delete from the table all employees.
delete from employees;






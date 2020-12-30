------- SELCECT ----------
SELECT firstname, lastname, salary  
FROM employee
WHERE salary > 200000 order by salary desc, lastname;


SELECT firstname, lastname, Salary  
FROM employee
WHERE (salary > 250000) OR firstname = 'John';


SELECT firstname, lastname, Salary  
FROM employee
WHERE (salary > 250000) AND firstname = 'Keith';


SELECT firstname, lastname, Salary  
FROM employee
WHERE salary BETWEEN 80000 AND 125000;


SELECT medicinename  
FROM inventoryrecord
WHERE code in ('ogl4xpin1' , 'N20') order by code;


SELECT firstname, lastname  
FROM patient
WHERE firstname like 'Kat%';


SELECT firstname, lastname  
FROM patient
WHERE firstname not like 'Kat%';

SELECT firstname, lastname  
FROM patient
WHERE birthdate > TO_DATE('20/09/1989', 'DD/MM/YYYY');


-- Old Join
-- Find firstname, lastname and specialization of doctors
SELECT e.firstname, e.lastname, d.specialization from employee e
inner join doctor d
on e.employeeid = d.employeeid;


-- Find number of employees who are doctor
SELECT count(*) from employee e
inner join doctor d
on e.employeeid = d.employeeid;

-- Find sum of salaries of all employees under department d001
SELECT sum(e.salary) from department d
inner join employee e
on d.deptid = e.deptid
and d.deptid = 'd001';


-- Find minimum, maximum and average of salaries of all employees under department d002
SELECT 
    AVG(salary) AS AvgSal,
	MIN(salary) AS MinSal, 
	MAX(salary) as MaxSal
from department d
inner join employee e
on d.deptid = e.deptid
and d.deptid = 'd002';



-- Find number of employees under each department
SELECT
    d.deptid,
    Count(e.employeeid) AS StaffTotal,
    AVG(e.salary) AS AverageSal
from department d
left join employee e
on d.deptid = e.deptid
group by d.deptid;


-- Find number of employees under each department where total employees are greater than 2
SELECT
    d.deptid,
    Count(e.employeeid) AS StaffTotal,
    AVG(e.salary) AS AverageSal
from department d
left join employee e
on d.deptid = e.deptid
group by d.deptid having Count(e.employeeid) > 2 order by StaffTotal desc;


-- New Join
-- Find number of employees under each department where total employees are greater than 2
SELECT
    d.deptid,
    Count(e.employeeid) AS StaffTotal,
    AVG(e.salary) AS AverageSal
from department d, employee e
where d.deptid = e.deptid
group by d.deptid having Count(e.employeeid) > 2 order by StaffTotal desc;


-- Multi Join
-- Find patient, his doctor and treatment name
SELECT
    p.firstname patient_firstname,
    p.lastname patient_lastname,
    e.firstname doctor_firstname,
    e.lastname doctor_firstname,
    t.name treatment_received
from patient p, patientrecord pr, employee e, treatment t
where 
    p.patientid = pr.patientid and
    pr.treatmentid = t.treatmentid and
    t.employeeid = e.employeeid;
    
------- UPDATE ----------
insert into department(deptId, name) values('d004', 'Emergency');

select * from DEPARTMENT;

Update department set name = 'Orthopedics' where deptId = 'd004';

select * from DEPARTMENT;

Delete from department where deptId = 'd004';

select * from DEPARTMENT;


----- DDL -----
-- Add column department head in the department table
ALTER Table department 
ADD deptHead char(9);

select * from DEPARTMENT;



ALTER Table department 
ADD CONSTRAINT department_fk_employee
FOREIGN KEY (deptHead) REFERENCES employee(employeeid);

select * from DEPARTMENT;


ALTER TABLE department
DROP CONSTRAINT department_fk_employee;

ALTER TABLE department
DROP column deptHead;

select * from DEPARTMENT;

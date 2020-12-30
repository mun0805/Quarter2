insert into patient(patientid, firstname, lastname, mailingAddress, birthdate, phoneNumber, gender, roomId) 
values('p001', 'John', 'Doe', '12 Main Street, Boston, MA, 04010', TO_DATE('17/12/2015', 'DD/MM/YYYY'), '123456789', 'M', 'r001');
insert into patient(patientid, firstname, lastname, mailingAddress, birthdate, phoneNumber, gender, roomId) 
values('p002', 'Kathlyn', 'Marie', '24 Malden Street, Boston, MA, 02140', TO_DATE('20/10/1989', 'DD/MM/YYYY'), '4657894759', 'F', 'r002');
insert into patient(patientid, firstname, lastname, mailingAddress, birthdate, phoneNumber, gender, roomId) 
values('p003', 'Meera', 'Smith', '55 Hill Road, Boston, MA, 02478', TO_DATE('08/12/1988', 'DD/MM/YYYY'), '8574364859', 'F', 'r003');


insert into department(deptId, name) values('d001', 'Dental');
insert into department(deptId, name) values('d002', 'Pediatrics');
insert into department(deptId, name) values('d003', 'Maternity');


insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e001', 'Keith', 'Simpsons', '34 Newbury Street, Boston, MA, 03456', TO_DATE('10/08/1982', 'DD/MM/YYYY'), '6753458976', 'M', 300000, 'd001');
insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e002', 'William', 'Ferrel', '53 Brooks Parkway, Cambridge, MA, 02140', TO_DATE('10/08/1980', 'DD/MM/YYYY'), '9759458976', 'M', 300000, 'd002');
insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e003', 'Julie', 'Wong', '10 Center Street, Malden, MA, 02148', TO_DATE('10/08/1984', 'DD/MM/YYYY'), '6753458976', 'F', 250000, 'd003');
insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e004', 'Nisha', 'Collins', '24 Salem Street, Salem, MA, 02358', TO_DATE('10/08/1981', 'DD/MM/YYYY'), '9753458976', 'F', 110000, 'd002');
insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e005', 'Chad', 'Jugger', '24 Parks Street, Boston, MA, 02148', TO_DATE('10/08/1978', 'DD/MM/YYYY'), '8752458976', 'M', 130000, 'd001');
insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e006', 'Nilam', 'George', '56 Salem Street, Salem, MA, 02358', TO_DATE('10/08/1981', 'DD/MM/YYYY'), '9753458976', 'F', 110000, 'd002');
insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e007', 'Bhavesh', 'Patel', '55 Roots Street, Boston, MA, 02148', TO_DATE('10/08/1983', 'DD/MM/YYYY'), '8752858976', 'M', 130000, 'd003');
insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e008', 'John', 'Keneddy', '44 Business Street, Boston, MA, 02158', TO_DATE('10/08/1981', 'DD/MM/YYYY'), '9756458976', 'M', 125000, 'd002');
insert into employee(employeeId, firstName, lastName, address, birthDate, phoneNumber, gender, salary, deptId) 
values('e009', 'George', 'Bush', '76 Parks Street, Medford, MA, 02168', TO_DATE('10/08/1985', 'DD/MM/YYYY'), '8952458976', 'M', 110000, 'd001');
    


insert into doctor(employeeid, specialization, degree) values('e001', 'Dentistry', 'M.S Surgeon');
insert into doctor(employeeid, specialization, degree) values('e002', 'Pediatrician surgery', 'M.S in pediatrics');
insert into doctor(employeeid, specialization, degree) values('e003', 'Gynaecologist', 'M.S. in Gynaecology');

insert into nurse(employeeid, specialization) values('e004', 'Dentistry');
insert into nurse(employeeid, specialization) values('e005', 'Pediatrician');
insert into nurse(employeeid, specialization) values('e006', 'Gynaecologist');



insert into receptionist(employeeid, floor) values('e007', 0);
insert into receptionist(employeeid, floor) values('e008', 1);
insert into receptionist(employeeid, floor) values('e009', 2);



insert into treatment(treatmentid, name, timespent, outcome, employeeid) 
values('t001', 'Dental transplant', 4, 'Performed root canal with success', 'e001');
insert into treatment(treatmentid, name, timespent, outcome, employeeid) 
values('t002', 'Cold and Cough', 1, 'Gave medicines to reduce the symptoms', 'e002');
insert into treatment(treatmentid, name, timespent, outcome, employeeid) 
values('t003', 'Child birth', 24, 'Performed child delivery no issues', 'e003');




insert into patientrecord(recordid, description, appointment, treatmentid, patientid) 
values('r001', 'Tooth Pain', 'Morning 08/15/2020 8:00 AM', 't001', 'p001');
insert into patientrecord(recordid, description, appointment, treatmentid, patientid) 
values('r002', 'Cold and Cough', 'Morning 08/20/2020 12:00 PM', 't002', 'p002');
insert into patientrecord(recordid, description, appointment, treatmentid, patientid) 
values('r003', 'Water Broke', 'Morning 08/21/2020 8:00 PM', 't003', 'p003');



insert into inventoryrecord(medicinename, price, quantity, code) values('Oragel 4X', 7.49, 50, 'ogl4xpin1');
insert into inventoryrecord(medicinename, price, quantity, code) values('Alka Seltzer', 4.99, 24, 'alkStz24ct');
insert into inventoryrecord(medicinename, price, quantity, code) values('Nitrous Oxide', 50, 24, 'N20');


insert into treatmentmedicine(treatmentid, medicinename, quantity) values('t001', 'Oragel 4X', 1);
insert into treatmentmedicine(treatmentid, medicinename, quantity) values('t002', 'Alka Seltzer', 1);
insert into treatmentmedicine(treatmentid, medicinename, quantity) values('t003', 'Nitrous Oxide', 1);



insert into rooms(roomid, roomname, type, floorlocation) values('r001', 'R1F1', 'Dental', 1);
insert into rooms(roomid, roomname, type, floorlocation) values('r002', 'R3F2', 'Pediatrics', 1);
insert into rooms(roomid, roomname, type, floorlocation) values('r003', 'R8F6', 'Emergency', 6);


insert into schedule(scheduleid, timespan, scheduledate, scheduledescription, employeeid) 
values('sc001', 4, TO_DATE('24/08/2020', 'DD/MM/YYYY'), 'Day Time', 'e001');
insert into schedule(scheduleid, timespan, scheduledate, scheduledescription, employeeid)  
values('sc002', 4, TO_DATE('24/08/2020', 'DD/MM/YYYY'), 'Day Time', 'e002');
insert into schedule(scheduleid, timespan, scheduledate, scheduledescription, employeeid)
values('sc003', 8, TO_DATE('24/08/2020', 'DD/MM/YYYY'), 'Night Time', 'e003');





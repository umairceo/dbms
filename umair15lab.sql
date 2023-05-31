Alter:
create table testing(
    testing_id integer not null,
    testing_name varchar(55) not null
);
insert into testing values(2,'Testing');
alter table testing add testing_area varchar(23);
alter table testing drop column testing_area ;
alter table testing rename column testing_name to testing_first;
alter table testing rename to testing2;

select * from testing;


SubQueries:
create table emp(
    emp_id integer primary key,
    emp_name varchar(55) not null,
    emp_salary integer not null
);
insert into emp values(1,'Omair', 31423);
insert into emp values(2,'Imair', 32423);
insert into emp values(3,'Hmair', 63423);
insert into emp values(4,'Wmair', 36423);
insert into emp values(5,'Emair', 23423);
insert into emp values(6,'Fmair', 34423);
-- Find Highest Salary
select emp_name from emp where emp_salary = (select max(emp_salary) from emp);
-- Find Second Highest Salary
select max(emp_salary) from emp where emp_salary != (select max(emp_salary) from emp);
select emp_name from emp where emp_salary = (select max(emp_salary) from emp where emp_salary != (select max(emp_salary) from emp));
-- Adding Department Column
alter table emp add department varchar(50);
select * from emp;
-- Deleting Specific Row
delete from emp where emp_id = 6;
-- Adding in specific column
update emp set department = 'IT' where emp_id = 1;
update emp set department = 'HR' where emp_id = 2;
update emp set department = 'HR' where emp_id = 3;
update emp set department = 'MAR' where emp_id = 4;
update emp set department = 'MAR' where emp_id = 5;
select count(department),department from emp group by department;
select department from emp group by department having count(department) < 2;
select emp_name from emp where department IN (select department from emp group by department having count(department) < 2);


Procedure:

-- Insert Procedure
create or replace procedure insertEmp(
    ID IN integer,
    Name IN varchar,
    Salary IN integer,
    Department IN varchar
)
IS
BEGIN
    insert into emp values(Id,name,salary,department);
END;

execute insertEmp(7,'Kabir',30000,'IT');
execute insertEmp(8,'Afaaq',2000,'MR');
execute insertEmp(9,'Hamza',7000,'HR');

select * from emp;

-- Delete Procedure
create or replace procedure delEmp(
    ID IN integer
)
IS 
BEGIN
delete from emp where emp_id = Id;
END;

execute delEmp(8);

-- Read Procedure
create or replace procedure readEmployee(
    ID OUT integer,
    Name OUT varchar,
    salary OUT integer,
    department OUT varchar
    
)
IS
BEGIN
select emp_id into id from emp where emp_id = id;
select emp_name into name from emp where emp_id = id;
select emp_salary into salary from emp where emp_id = id;
select department into department from emp where emp_id = id;
DBMS_OUT.PUT_LINE('ID is : ' || id);
DBMS_OUT.PUT_LINE('Full Name Is : ' ||  Name);
DBMS_OUT.PUT_LINE('Salary Is: ' || salary);
DBMS_OUT.PUT_LINE('Department IS : '  || department);
    END;

SET SERVEROUTPUT ON;

VARIABLE A VARCHAR2;
VARIABLE B VARCHAR2;
VARIABLE C NUMBER;
VARIABLE D NUMBER;
VARIABLE E VARCHAR2;

EXECUTE READ_EMP(170,:A,:B,:C,:D,:E);


















CREATE OR REPLACE PROCEDURE UP_SAL(
ID IN NUMBER,
AMOUNT IN NUMBER,
G_SAL OUT NUMBER
)
IS
BEGIN
UPDATE EMPLOYEES SET SALARY=SALARY+AMOUNT WHERE EMPLOYEE_ID=ID;
SELECT SALARY INTO G_SAL FROM EMPLOYEES WHERE EMPLOYEE_ID=ID;
DBMS_OUTPUT.PUT_LINE('UPDATE SALARY IS : '||G_SAL);
END;

***********************READ*************************************
CREATE OR REPLACE PROCEDURE READ_EMP(
ID IN NUMBER,
FNAME OUT VARCHAR2,
LNAME OUT VARCHAR2,
DPT_ID OUT NUMBER,
SAL OUT NUMBER,
J_ID OUT VARCHAR2
)
IS
BEGIN
SELECT FIRST_NAME INTO FNAME FROM EMPLOYEES WHERE EMPLOYEE_ID=ID;
SELECT LAST_NAME INTO LNAME FROM EMPLOYEES WHERE EMPLOYEE_ID=ID;
SELECT SALARY INTO SAL FROM EMPLOYEES WHERE EMPLOYEE_ID=ID;
SELECT DEPARTMENT_ID INTO DPT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=ID;
SELECT JOB_ID INTO J_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=ID;
DBMS_OUTPUT.PUT_LINE('FULL NAME IS : '||FNAME||' '||LNAME);
DBMS_OUTPUT.PUT_LINE('SALARY IS : '||SAL);
DBMS_OUTPUT.PUT_LINE('DEPARTMENT ID IS : '||DPT_ID);
DBMS_OUTPUT.PUT_LINE('JOB ID IS : '||J_ID);
END;

SET SERVEROUTPUT ON;


VARIABLE A VARCHAR2;
VARIABLE B VARCHAR2;
VARIABLE C NUMBER;
VARIABLE D NUMBER;
VARIABLE E VARCHAR2;

EXECUTE READ_EMP(170,:A,:B,:C,:D,:E);


*****************************************************************************************

CREATE OR REPLACE PROCEDURE IS_SENIOR(ID IN VARCHAR2,MSG OUT VARCHAR2)
IS 
JDATE DATE;
YEARS NUMBER;
BEGIN
SELECT HIRE_DATE INTO JDATE FROM EMPLOYEES WHERE EMPLOYEE_ID=ID;
YEARS := (MONTHS_BETWEEN(SYSDATE,JDATE)/12);

IF YEARS >= 10 THEN
	MSG := 'THE EMPLOYEE WORKED 10 YEARS OR MORE';
ELSE
	MSG := 'THE EMPLOYEE WORKED LESS THAN 10 YEARS';
END IF;


EXCEPTION 
WHEN NO_DATA_FOUND THEN
	MSG := 'NO EMPLOYEE FOUND';
WHEN TOO_MANY_ROWS THEN
	MSG := 'MORE THAN ONE ROW FOUND';
WHEN OTHERS THEN
	MSG := 'SOME UNKNOWN ERROR FOUND';

END;



DECLARE 
K VARCHAR2(100);
BEGIN

IS_SENIOR(220,:K);
DBMS_OUPUT.PUT_LINE(K);

IS_SENIOR(110,:K);
DBMS_OUPUT.PUT_LINE(K);

END;


***********************************************
CREATE OR REPLACE FUNCTION ADD_NUM(N1 IN NUMBER,N2 IN NUMBER)
RETURN NUMBER
IS
N3 NUMBER;
BEGIN
N3 := N1+N2;
RETURN N3;
END;
**********************************************************************************************
CREATE OR REPLACE  FUNCTION SENIOR(ID IN VARCHAR2)
RETURN VARCHAR2
IS 
MSG VARCHAR2(100);
JDATE DATE;
YEARS NUMBER;
BEGIN
SELECT HIRE_DATE INTO JDATE FROM EMPLOYEES WHERE EMPLOYEE_ID=ID;
YEARS := (MONTHS_BETWEEN(SYSDATE,JDATE)/12);

IF YEARS >= 10 THEN
	MSG := 'THE EMPLOYEE WORKED 10 YEARS OR MORE';
ELSE
	MSG := 'THE EMPLOYEE WORKED LESS THAN 10 YEARS';
END IF;
RETURN MSG;

EXCEPTION 
WHEN NO_DATA_FOUND THEN
	RETURN 'NO EMPLOYEE FOUND';
WHEN TOO_MANY_ROWS THEN
	RETURN 'MORE THAN ONE ROW FOUND';
WHEN OTHERS THEN
	RETURN 'SOME UNKNOWN ERROR FOUND';
END;








create table mobile(
m_id integer primary key,
m_name varchar2(20)
);

insert into mobile values(01,'Redme');
insert into mobile values(02,'Samsungs');
insert into mobile values(03,'Apple');
select * from mobile;

describe user_sequences

--how to create sequences?
create sequence seq_mobile
    start with 100
    increment by 1
    maxvalue 1000
    nocycle
    cache 5;
    
    delete mobile;
    
    
insert into mobile values(seq_mobile.nextval,'&M');


--IndexingIndexingIndexingIndexingIndexingIndexing
--create index index-name on table(column);
--we dont use index on primary key we use where dublication is possbile like first_name & last_name;

create index emp_lastname_ind
on employees(last_name);
select * from employees;
insert into employees values(208,'&M','&P','&Q',0311233452,'24-May-23','IT_PROG',12300,null,null,60);
select * from employees where last_name='Solangi';
select * from employees where last_name='Jawed';

--ViewViewViewViewViewViewViewViewViewViewViewViewViewViewViewView
--create or replace view view_name 
--as select coll , col2,col3
--from table_name;
create view empdpt80
as select employee_id,first_name,salary
from employees 
where department_id = 80;

select * from empdpt80;

create or replace view emp_dep_sum(
Name,anual_sal,dept_name) as select e.first_name || ' ' || e.last_name, e.salary*12,d.department_name
from employees E join departments D
on (e.department_id = d.department_id);

select * from emp_dep_sum;

--department Name ?
select * from departments;

create or replace view emp_mi_ma_av_to_salary(
Dep_name,Total_Salary,Min_Salary_Max_Salary,Total_Employees)
as select d.department_name, sum(e.salary), min(e.salary), max(e.salary),count(e.department_id)
from employees e join departments d
on (e.department_id = d.department_id)
group by d.department_name;

select * from emp_mi_ma_av_to_salary;


--ProcuduresProcuduresProcuduresProcuduresProcuduresProcudures
create or replace procedure greeting
as 
begin
DBMS_OUTPUT.PUT_LINE('Welcome to Szabist');
END;

--we need to on server out on
set serveroutput on;
begin greeting; end;
execute greeting;


--we are making procedure for input the values
--we are making procedure for input the values
create or replace procedure insert_ctry(ID  IN varchar2, Name IN varchar2, Rig IN number)
is 
begin
insert into countrie values(Id,Name,Rig);
end;

set serveroutput on;
execute insert_ctry('AS', 'Fast', 2);
execute insert_ctry('Um', 'Szabist', 2);
execute insert_ctry('SRI', 'IU', 2);
execute insert_ctry('IND', 'KU', 2);




select * from countrie;

    
create or replace procedure up_sal(id in number,amount in number,d out number)
is
begin
update employees set salary = salary+amount where employee_id = id;
select salary into d from employees where employee_id =id;
DBMS_OUTPUT.PUT_LINE('Updated Salary is : ' || D);
end;

select salary from employees where employee_id = 155;
variable K number
execute up_sal(155,400,:K);


--now create Procedure of
--delete 
--read
--update






-- Name: UmairSolangi
-- GR: 2112203
-- Instructor: Sir Abid Ali

-- //Table Auditorium Executed
create table Auditorium(
    audi_id integer primary key,
    audi_name varchar(35) not null,
    audi_capicity integer not null
);
insert into Auditorium values(1,'Jinnah Audi', 450);
insert into Auditorium values(2,'Iqbal Audi', 550);
insert into Auditorium values(3,'Umair Audi', 660);
insert into Auditorium values(4,'PAF Audi', 770);
insert into Auditorium values(5,'Karachi Audi', 880);
insert into Auditorium values(6,'Szab Audi', 150);
insert into Auditorium values(7,'Lahore Audi', 300);
insert into Auditorium values(8,'Solangi Audi', 930);
insert into Auditorium values(9,'Coder Audi', 200);
insert into Auditorium values(10,'Bollywood Audi', 820);
select * from auditorium;

-- //Table Roww Executed
CREATE TABLE Roww (
    roww_id INTEGER PRIMARY KEY,
    roww_no INTEGER NOT NULL,
    roww_seats INTEGER NOT NULL,
    audi_id INTEGER, 
    CONSTRAINT ROWW_AUDI_FR FOREIGN KEY (audi_id) REFERENCES Auditorium (audi_id)
);
insert into Roww values(1,1,15,1);
insert into Roww values(2,2,25,2);
insert into Roww values(3,3,35,3);
insert into Roww values(4,4,45,4);
insert into Roww values(5,5,55,5);
insert into Roww values(6,6,29,3);
insert into Roww values(7,7,50,2);
insert into Roww values(8,8,70,3);
insert into Roww values(9,9,10,4);
insert into Roww values(10,10,23,1);
select * from roww;

-- //seatType Tables Executed
create table seatType(
    seatType_id integer primary key,
    seatType_name varchar(35) not null
);
insert into seatType values(1,'Standard');
insert into seatType values(2,'Economic');
insert into seatType values(3,'Economic');
insert into seatType values(4,'Standard');
insert into seatType values(5,'Economic');
insert into seatType values(6,'Economic');
insert into seatType values(7,'Standard');
insert into seatType values(8,'Standard');
insert into seatType values(9,'Economic');
insert into seatType values(10,'Standard');

DELETE FROM seatType WHERE seatType_id = 6;
select * from seatType;

-- //seat Tables Executed
create table seat(
    seat_id integer primary key,
    seat_name varchar(25) not null,
    seat_number integer not null,
    roww_id integer,
    seatType_id integer,
    CONSTRAINT SEAT_ROW_FR FOREIGN KEY (roww_id) REFERENCES roww (roww_id),
    CONSTRAINT SEAT_TYPE_FR FOREIGN KEY (seatType_id) REFERENCES seatType (seatType_id)
);

insert into seat values(1,'Standart',1,1,1);
insert into seat values(2,'Economic',2,2,2);
insert into seat values(3,'Economic',3,3,3);
insert into seat values(4,'Economic',4,4,4);
insert into seat values(5,'Standart',5,5,5);
insert into seat values(6,'Standart',6,3,1);
insert into seat values(7,'Economic',7,2,2);
insert into seat values(8,'Economic',8,3,6);
insert into seat values(9,'Economic',9,1,3);
insert into seat values(10,'Standart',10,8,6);
select * from seat;
-- Customer Table Executed
create table customer(
    customer_id integer primary key,
    customer_firstname varchar(300) not null,
    customer_lastname varchar(70) not null,
    customer_email varchar(70) not null,
    customer_isvip NUMBER(1) NOT NULL CHECK (customer_isvip IN (0, 1))
);
insert into customer values(1,'Umair','Solangi','umair@gmail.com',1);
insert into customer values(2,'Ahmed','Asim','ahmed@gmail.com',0);
insert into customer values(3,'Anas','Khan','anas@gmail.com',1);
insert into customer values(4,'Hamza','Jawed','hamza@gmail.com',0);
insert into customer values(5,'Ibrahim','Khalil','ibrahim@gmail.com',1);
insert into customer values(6,'Amjad','Sabri','amjad@gmail.com',1);
insert into customer values(7,'Rasheed','Riyaaz','rasheed@gmail.com',0);
insert into customer values(8,'Ammar','Khuram','ammar@gmail.com',1);
insert into customer values(9,'Ali','Jawed','ali@gmail.com',0);
insert into customer values(10,'Usama','Khalil','usama@gmail.com',1);
select * from customer;
-- MOvie Talbe Executed
create table movie(
    movie_id integer primary key,
    movie_name varchar(70) not null,
    movie_decription varchar(254) not null,
    movie_minutes integer not null,
    movie_published_year integer not null
);
insert into movie values(1,'Don','A Story of Gangstor',120,2011);
insert into movie values(2,'Poling Station','A Story of Politicians',120,2013);
insert into movie values(3,'Third Eye','A Story of Computer Programmer',120,2014);
insert into movie values(4,'Hocky','A Story of Sports Man',120,2016);
insert into movie values(5,'Newly Birth','A Story of Child',120,2015);
insert into movie values(6,'Hacker','A Story of Hacker',100,2011);
insert into movie values(7,'Fast and Feurious','A Story of An Advertures',110,2013);
insert into movie values(8,'Covid 19','A Story of Covid 19',140,2022);
insert into movie values(9,'Facebook','A Story of Sports Facebook',130,2022);
insert into movie values(10,'Mars','A Story of Mars',90,20123);

    select * from movie;
    
-- Table Reservation Executed
create table reservation(
    reservation_id integer primary key,
    reservation_hasPaidTicket number(1) not null check (reservation_hasPaidTicket IN (0,1)),
    seat_id integer,
    customer_id integer,
    movie_id integer,
    CONSTRAINT RESERVATION_SEAT_FR FOREIGN KEY (seat_id) REFERENCES seat (seat_id),
    CONSTRAINT RESERVATION_CUSTOMER_FR FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT RESERVATION_MOVIE_FR FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);
insert into reservation values(1,0,1,1,1);
insert into reservation values(2,1,2,2,2);
insert into reservation values(3,1,3,3,3);
insert into reservation values(4,1,4,4,4);
insert into reservation values(5,0,4,4,3);
insert into reservation values(6,0,3,1,3);
insert into reservation values(7,0,2,2,7);
insert into reservation values(8,1,4,5,3);
insert into reservation values(9,1,6,6,9);
insert into reservation values(10,0,9,4,37);
select * from reservation;
-- Scheduled MOvie Talbe Executed
CREATE TABLE scheduledMovie (
    scheduledMovie_id INTEGER PRIMARY KEY,
    scheduledMovie_start_date DATE,
    scheduledMovie_start_time TIMESTAMP,
    scheduledMovie_end_date DATE,
    scheduledMovie_end_time TIMESTAMP,
    scheduledMovie_price DECIMAL(10,2),
    audi_id INTEGER,
    movie_id INTEGER,
    CONSTRAINT scheduledMovie_AUDI_FR FOREIGN KEY (audi_id) REFERENCES Auditorium (audi_id),
    CONSTRAINT scheduledMovie_MOVIE_FR FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);
INSERT INTO scheduledmovie VALUES (1, TO_DATE('2023/05/30', 'YYYY/MM/DD'), TO_TIMESTAMP('20:10:10', 'HH24:MI:SS'), TO_DATE('2023/05/30', 'YYYY/MM/DD'), TO_TIMESTAMP('22:10:10', 'HH24:MI:SS'), 800, 1, 1);
INSERT INTO scheduledmovie VALUES (2, TO_DATE('2023/02/12', 'YYYY/MM/DD'), TO_TIMESTAMP('10:10:10', 'HH24:MI:SS'), TO_DATE('2023/02/12', 'YYYY/MM/DD'), TO_TIMESTAMP('10:10:10', 'HH24:MI:SS'), 850, 2, 2);
INSERT INTO scheduledmovie VALUES (3, TO_DATE('2023/03/23', 'YYYY/MM/DD'), TO_TIMESTAMP('12:10:10', 'HH24:MI:SS'), TO_DATE('2023/03/23', 'YYYY/MM/DD'), TO_TIMESTAMP('12:10:10', 'HH24:MI:SS'), 1000, 3, 3);
INSERT INTO scheduledmovie VALUES (4, TO_DATE('2023/04/05', 'YYYY/MM/DD'), TO_TIMESTAMP('14:10:10', 'HH24:MI:SS'), TO_DATE('2023/04/05', 'YYYY/MM/DD'), TO_TIMESTAMP('14:10:10', 'HH24:MI:SS'), 700, 4, 4);
INSERT INTO scheduledmovie VALUES (5, TO_DATE('2023/06/08', 'YYYY/MM/DD'), TO_TIMESTAMP('16:10:10', 'HH24:MI:SS'), TO_DATE('2023/06/08', 'YYYY/MM/DD'), TO_TIMESTAMP('16:10:10', 'HH24:MI:SS'), 900, 5, 5);
INSERT INTO scheduledmovie VALUES (6, TO_DATE('2023/05/30', 'YYYY/MM/DD'), TO_TIMESTAMP('20:10:10', 'HH24:MI:SS'), TO_DATE('2023/05/30', 'YYYY/MM/DD'), TO_TIMESTAMP('22:10:10', 'HH24:MI:SS'), 800, 1, 1);
INSERT INTO scheduledmovie VALUES (7, TO_DATE('2024/06/16', 'YYYY/MM/DD'), TO_TIMESTAMP('10:10:10', 'HH24:MI:SS'), TO_DATE('2024/06/16', 'YYYY/MM/DD'), TO_TIMESTAMP('10:10:10', 'HH24:MI:SS'), 850, 2, 2);
INSERT INTO scheduledmovie VALUES (8, TO_DATE('2025/03/04', 'YYYY/MM/DD'), TO_TIMESTAMP('12:10:10', 'HH24:MI:SS'), TO_DATE('2025/03/04', 'YYYY/MM/DD'), TO_TIMESTAMP('12:10:10', 'HH24:MI:SS'), 1200, 3, 3);
INSERT INTO scheduledmovie VALUES (9, TO_DATE('2023/02/02', 'YYYY/MM/DD'), TO_TIMESTAMP('14:10:10', 'HH24:MI:SS'), TO_DATE('2023/02/02', 'YYYY/MM/DD'), TO_TIMESTAMP('14:10:10', 'HH24:MI:SS'), 950, 4, 4);
INSERT INTO scheduledmovie VALUES (10, TO_DATE('2023/04/05', 'YYYY/MM/DD'), TO_TIMESTAMP('14:10:10', 'HH24:MI:SS'), TO_DATE('2023/04/05', 'YYYY/MM/DD'), TO_TIMESTAMP('14:10:10', 'HH24:MI:SS'), 700, 4, 4);
select * from scheduledmovie;    

-- 1. Retrieve all auditoriums.
select * from auditorium;
-- 2. Get all rows for a specific auditorium.
select * from roww where audi_id = 3;
-- 3. Fetch all seats in a particular row.
select * from seat where roww_id = 2;
-- 4. Get the seat types available.
select * from seattype;
-- 5. Retrieve all reservations made by a specific customer.
select * from reservation where customer_id = 6;
-- 6. Fetch customer details for a reservation.
select * from customer where customer_id = customer_id;
-- 7. Get information about a specific movie.
select * from movie where movie_name = 'Hacker';
-- 8. Retrieve all scheduled movies.
select * from scheduledmovie;
-- 9. Retrieve all reservations with associated customer and movie details.
select r.*, c.*, m.* from reservation r
join customer c on r.customer_id = c.customer_id
join movie m on r.movie_id = m.movie_id;
-- 10. Fetch all seats with their corresponding row, auditorium, and seat type information.
select s.seat_id, s.seat_name, s.seat_number, r.roww_id, r.roww_no, a.audi_id, a.audi_name, st.seattype_id, st.seattype_name
from seat s
join roww r ON s.roww_id = r.roww_id
join auditorium a ON r.audi_id = a.audi_id
join seattype st ON s.seattype_id = st.seattype_id;

-- 11. Get all scheduled movies with their associated movie and auditorium details.
select sm.*, m.*, a.*
from scheduledmovie sm
join movie m On sm.movie_id = m.movie_id
join auditorium a On sm.audi_id = a.audi_id;
-- 12. Retrieve all scheduled movies in an auditorium along with their overlapping scheduled
-- movies.
SELECT sm1.*, sm2.*
FROM scheduledMovie sm1
JOIN scheduledMovie sm2 ON sm1.audi_id = sm2.audi_id
WHERE sm1.scheduledMovie_id <> sm2.scheduledMovie_id
AND ((sm1.scheduledMovie_start_date >= sm2.scheduledMovie_start_date
AND sm1.scheduledMovie_start_date <= sm2.scheduledMovie_end_date)
OR (sm1.scheduledMovie_end_date >= sm2.scheduledMovie_start_date
AND sm1.scheduledMovie_end_date <= sm2.scheduledMovie_end_date));

-- 13. Retrieve all movies along with their associated scheduled movies (including movies without
-- any scheduled movies).
select m.*, sm.*
from movie m 
left Join scheduledmovie sm On sm.movie_id = sm.scheduledMovie_id;
-- 14. Retrieve all combinations of auditoriums and customers.
select a.*,c.*
from auditorium a
cross join customer c;
-- 15. Get all combinations of seats and movies.
select s.*,m.*
from seat s
cross join movie m;
-- 16. Retrieve all combinations of rows and scheduled movies.
select r.*,sm.*
from roww r
cross join scheduledmovie sm;
-- 17. Retrieve the distinct list of customers who have made reservations.
select DISTINCT c.customer_id,  c.customer_firstname, c.customer_lastname, c.customer_email
from customer c
join reservation r ON c.customer_id = r.customer_id;
-- 18. Get the union of all seats and rows.
select seat_id, seat_name
from seat
union 
select roww_id, concat('Row',roww_no)
from roww;

-- 20. Get the set difference between auditoriums and scheduled movies.
SELECT audi_id,  audi_capicity
FROM Auditorium
MINUS
SELECT audi_id, scheduledmovie_price
FROM scheduledMovie;
-- 21. Create a view that combines auditorium, row, and seat information.
create view CombAudRowSeat as
select a.audi_id, a.audi_name, r.roww_id, r.roww_no, s.seat_id, s.seat_name
from auditorium a
join roww r on a.audi_id = r.audi_id
join seat s on r.roww_id = s.roww_id;

select * from CombAudRowSeat;
-- 22. Create a view that provides reservation details along with customer and movie information.
create view ResDetWithCustMovie as
select r.reservation_id, r.reservation_haspaidticket, c.customer_id, c.customer_firstname, m.movie_id, m.movie_name
from reservation r
join customer c on r.customer_id = c.customer_id 
join movie m on r.movie_id = m.movie_id;

select * from ResDetWithCustMovie;

-- 23. Create a view that shows the available seats in each auditorium.
CREATE VIEW AvailableSeats AS
SELECT a.audi_id, a.audi_name, r.roww_id, r.roww_no, s.seat_id, s.seat_name
FROM auditorium a
JOIN roww r ON a.audi_id = r.audi_id
JOIN seat s ON r.roww_id = s.roww_id
WHERE s.seat_id NOT IN (
    SELECT seat_id
    FROM reservation
);

select * from AvailableSeats;
-- 24. Create a function to calculate the total number of seats in an auditorium.
CREATE OR REPLACE FUNCTION CalculateTotalSeats(audi_id IN INTEGER) RETURN INTEGER IS
  total_seats INTEGER;
BEGIN
  SELECT COUNT(*) INTO total_seats
  FROM seat
  WHERE roww_id IN (SELECT roww_id FROM roww WHERE audi_id = audi_id);

  RETURN total_seats;
END;
SELECT CalculateTotalSeats(1) FROM DUAL;


-- 25 Adding a virtual column 'TotalSeats' to calculate the total number of seats in each row
ALTER TABLE scheduledmovie ADD TotalSeats INTEGER AS (
    SELECT SUM(roww_seats) FROM Roww WHERE audi_id = scheduledmovie.audi_id
);

-- 26. Add a virtual column to determine the availability status of a seat.
ALTER TABLE scheduledmovie ADD SeatAvailability VARCHAR(10) AS (
    CASE
        WHEN TotalSeats > (SELECT COUNT(*) FROM seat WHERE seat.seat_id IN (SELECT seat_id FROM reservation WHERE reservation.movie_id = scheduledmovie.movie_id)) THEN 'Available'
        ELSE 'Full'
    END
);

-- 27. Add a virtual column to calculate the total duration of a scheduled movie.
ALTER TABLE scheduledmovie ADD TotalDuration INTEGER AS (
    EXTRACT(HOUR FROM scheduledMovie_end_time - scheduledMovie_start_time) * 60 +
    EXTRACT(MINUTE FROM scheduledMovie_end_time - scheduledMovie_start_time)
);
select * from scheduledmovie;
-- 28. Retrieve all customers who have made a reservation in a specific auditorium.
SELECT DISTINCT r.customer_id
FROM reservation r
JOIN seat s ON r.seat_id = s.seat_id
JOIN roww rw ON s.roww_id = rw.roww_id
JOIN auditorium a ON rw.audi_id = a.audi_id
WHERE a.audi_id = 3; 

-- 29. Retrieve all movies that have scheduled show times in a specific auditorium.
SELECT DISTINCT m.movie_id, m.movie_name
FROM movie m
JOIN scheduledmovie sm ON m.movie_id = sm.movie_id
JOIN auditorium a ON sm.audi_id = a.audi_id
WHERE a.audi_id = 6; 



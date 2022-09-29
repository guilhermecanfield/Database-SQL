show databases;

create database first_example;
use first_example;

create table person(
person_id smallint unsigned,
fname varchar(20),
lname varchar(20),
gender enum('M','F'),
birth_date date,
street varchar(30),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code varchar(20),
constraint pk_person primary key (person_id)
);

desc person;

show databases;

create table favorite_food(
person_id smallint unsigned,
food varchar(20),
constraint pk_favorite_food primary key (person_id, food),
constraint fk_favorite_food_person_id foreign key (person_id)
references person(person_id)
);

desc favorite_food;

show databases;

select * from information_schema.table_constraints	
where constraint_schema = 'first_example';

select * from information_schema.table_constraints
where table_name = 'person';

desc person;

insert into person values('1','Carolina','Silva','F','1979-08-21',
						  'rua A','Cidade J','RJ','Brasil','83206-202');

select * from person;

insert into person values('2','Roberta','Silva','F','1979-08-21',
						  'rua A','Cidade J','RJ','Brasil','83206-202'),
                          ('3','Luiz','Silva','F','1979-08-21',
						  'rua A','Cidade J','RJ','Brasil','83206-202'),
                          ('4','João','Silva','F','1979-08-21',
						  'rua A','Cidade J','RJ','Brasil','83206-202'),
                          ('5','Maria','Silva','F','1979-08-21',
						  'rua A','Cidade J','RJ','Brasil','83206-202');
                          
select * from person;

delete from person where person_id = 2 or person_id = 4;

select * from person;

desc favorite_food;

insert into favorite_food values(3, 'carne'),
                                (5, 'peixe');
                                
select * from favorite_food;

select now();

create schema company;

use company;

alter table employee(
Fname varchar(15) NOT NULL,
Minit char,
Lname varchar(15) NOT NULL,
Ssn char(9) NOT NULL,
Bdate date,
Adress varchar(30),
Gender char,
salary decimal(10,2),
Super_ssn char(9),
Dno int NOT NULL,
constraint chk_salary_employee check (Salary > 2000.0),
constraint pk_employee primary key (Ssn)
);

use company;
create table departament(
Dname varchar(15) not null,
Dnumber int not null,
Mgr_ssn char(9),
Mgr_state_date date,
primary key (Dnumber),
unique (Dname),
foreign key (Mgr_ssn) references employee(Ssn)
);

create table dept_locations(
Dnumber int not null,
Dlocation varchar(15) not null,
primary key (Dnumber, Dlocation),
foreign key (Dnumber) references departament(Dnumber)
);

create table project(
Pname varchar(15) not null,
Pnumber int not null,
Plocation varchar(15),
Dnum int not null,
primary key (Pnumber),
unique(Pname),
foreign key (Dnum) references departament(Dnumber)
);

create table works_on(
Essn char(9) not null,
Pno int not null,
Hour decimal(3,1) not null,
primary key (Essn, Pno),
foreign key (Essn) references employee(Ssn),
foreign key (Pno) references project(Pnumber)
);

create table dependent(
Essn char(9) not null,
Dependent_name varchar(15) not null,
Sex char,
Bdate date,
Relationship varchar(8),
primary key (Essn, Dependent_name),
foreign key (Essn) references employee (Ssn)
);

desc dependent;

show tables;

desc departament;
use company;
select * from information_schema.table_constraints
where constraint_schema = 'comapny';
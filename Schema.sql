CREATE SCHEMA course_guide_data;

drop table Teachers;
drop table Departments;
drop table Classrooms;
drop table Course_Offerings;
drop table Course;
drop table Teach;
drop table ISA;
drop table Part_Of;
drop table Taught_In;




create table Teachers(
   NAME VARCHAR (20)     NOT NULL,
   PRIMARY KEY (NAME)
);


create table Departments(
   NAME VARCHAR (20)     NOT NULL,
   PRIMARY KEY (NAME)
);

create table Classrooms(
   NAME VARCHAR (20)     NOT NULL,
   BUILDING VARCHAR (20)     NOT NULL,
   PRIMARY KEY (NAME)
);

create table Course_Offerings(
   NAME VARCHAR (20)     NOT NULL,
   CREDIT VARCHAR (20)     NOT NULL,
   DESCRIPTION   VARCHAR(800)   NOT NULL,
   Size INT 	NOT NULL,
   FIRST_YEAR VARCHAR(20) 	NOT NULL,
   PRIMARY KEY (NAME)
);

create table Course(
   ID VARCHAR (20)      NOT NULL ,
   MEET_TIME VARCHAR (20)     NOT NULL,
   YEAR INT 	NOT NULL,
   PRIMARY KEY (ID, YEAR)
);

create table Teach(
   CID VARCHAR,
   CYEAR INT,
   TNAME VARCHAR REFERENCES Teachers(NAME),
   FOREIGN KEY (CID, CYEAR) REFERENCES Course (ID, YEAR)
);


create table Part_Of(
   CNAME VARCHAR,
   DNAME VARCHAR REFERENCES Departments(NAME),
   FOREIGN KEY (CNAME) REFERENCES Course_Offerings(NAME)
);

create table ISA(
   CID VARCHAR,
   CYEAR INT,
   CNAME VARCHAR REFERENCES Course_Offerings(NAME),
   FOREIGN KEY (CID, CYEAR) REFERENCES Course (ID, YEAR)

);


create table Taught_In(
   CID VARCHAR,
   CYEAR INT,
   FOREIGN KEY (CID, CYEAR) REFERENCES Course (ID, YEAR),
   RNAME VARCHAR REFERENCES Classrooms(NAME)
);







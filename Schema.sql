CREATE SCHEMA course_guide_data;

drop table professor CASCADE;
drop table departments CASCADE;
drop table classrooms CASCADE;
drop table offering CASCADE;
drop table course CASCADE;
drop table weekday CASCADE;
drop table building CASCADE;
drop table teaches CASCADE;
drop table IMPLEMENTS CASCADE;
drop table Offers CASCADE;
drop table Taught_In CASCADE;
drop table Located_In CASCADE;
drop table Offered_ON CASCADE;
drop table Requires CASCADE;




-- department(name)
-- professor(name, id, email)
-- course(name, description, id, credits, first_year_friendly, first_semester_offered)
-- offering(id, semester, pf, max_students)
-- classroom(code, capacity)
-- weekday(name)
-- building(name) 

-- teaches(professor.id, offering.id, offering.semester) 
-- taughtIn(offering.id, offering.semester, classroom.code)
-- locatedIn(classroom.code, building.name)
-- implements(offering.id, offering.semester, course.id,)
-- offers(department.name, course.id)
-- offeredOn(offering.id, offering.semester, weekday.name, time_start, time_end)
-- requires(course.id, course.id, coreq)



create table Professor(
   NAME VARCHAR (20)     NOT NULL,
   ID int   NOT NULL,
   EMAIL VARCHAR(50)    NOT NULL,
   PRIMARY KEY (ID)
);


create table Departments(
   NAME VARCHAR (20)     NOT NULL,
   PRIMARY KEY (NAME)
);

create table Building(
   NAME VARCHAR (20)     NOT NULL,
   PRIMARY KEY (NAME)
);

create table Weekday(
   NAME VARCHAR (20)     NOT NULL,
   PRIMARY KEY (NAME)
);

create table Classrooms(
   CODE VARCHAR (20)     NOT NULL,
   CAPACITY int     NOT NULL,
   PRIMARY KEY (CODE)
);

create table Course(
   NAME VARCHAR (20)     NOT NULL,
   CREDIT VARCHAR (20)     NOT NULL,
   DESCRIPTION   VARCHAR(800)   NOT NULL,
   FIRST_YEAR VARCHAR(20) 	NOT NULL,
   NEW VARCHAR(10)   NOT NULL,
   ID VARCHAR(10)    NOT NULL,

   PRIMARY KEY (ID)
);

create table Offering(
   ID VARCHAR (20)      NOT NULL ,
   SEMESTER VARCHAR (10)     NOT NULL,
   PF VARCHAR(10) 	NOT NULL,
   MAX_STUDENTS INT  NOT NULL,
   PRIMARY KEY (ID, SEMESTER)
);

create table Teaches(
   OfID VARCHAR,
   OFSEMESTER VARCHAR,
   TID INT REFERENCES Professor(ID),
   FOREIGN KEY (OfID, OFSEMESTER) REFERENCES Offering (ID, SEMESTER)
);


create table Offers(
   CfID VARCHAR,
   DNAME VARCHAR REFERENCES Departments(NAME),
   FOREIGN KEY (CfID) REFERENCES Course (ID)
);

create table IMPLEMENTS(
   OFID VARCHAR,
   OFSEMESTER VARCHAR,
   CFID VARCHAR REFERENCES Course(ID),
   FOREIGN KEY (OFID, OFSEMESTER) REFERENCES Offering(ID, SEMESTER)

);


create table Taught_In(
   OFID VARCHAR,
   OFSEMESTER VARCHAR,
   FOREIGN KEY (OFID, OFSEMESTER) REFERENCES Offering (ID, SEMESTER),
   RCODE VARCHAR REFERENCES Classrooms(CODE)
);

create table Located_In(
   Bname VARCHAR REFERENCES Building(NAME),
   RCODE VARCHAR REFERENCES Classrooms(CODE)
);

create table Offered_ON(
   OFID VARCHAR,
   OFSEMESTER VARCHAR,
   DAY VARCHAR REFERENCES Weekday(NAME),
   Time_start TIME,
   Time_end TIME,
   FOREIGN KEY (OFID, OFSEMESTER) REFERENCES Offering (ID, SEMESTER)
);

create table Requires(
   CID VARCHAR REFERENCES Course (ID),
   RID VARCHAR REFERENCES Course(ID)
);







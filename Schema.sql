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



create table professor(
   name VARCHAR (20)     NOT NULL,
   id int   NOT NULL,
   email VARCHAR(50)    NOT NULL,
   PRIMARY KEY (id)
);


create table department(
   name VARCHAR (20)     NOT NULL,
   PRIMARY KEY (name)
);

create table building(
   name VARCHAR (20)     NOT NULL,
   PRIMARY KEY (name)
);

create table weekday(
   name VARCHAR (20)    NOT NULL,
   PRIMARY KEY (name)
);

create table classroom(
   code VARCHAR (20)     NOT NULL,
   capacity int     NOT NULL,
   PRIMARY KEY (code)
);

create table course(
   name VARCHAR (20)     NOT NULL,
   credits VARCHAR (20)     NOT NULL,
   description   VARCHAR(800)   NOT NULL,
   first_year VARCHAR(20) 	NOT NULL,
   when_new VARCHAR(10)   NOT NULL,
   id VARCHAR(10)    NOT NULL,

   PRIMARY KEY (id)
);

create table offering(
   id VARCHAR (20)      NOT NULL ,
   semester VARCHAR (10)     NOT NULL,
   pf VARCHAR(10) 	NOT NULL, /* NEED SOME SORT OF BOOLEAN TYPE */
   max_students INT  NOT NULL,
   PRIMARY KEY (id, semester)
);

create table teaches(
   p_id INT REFERENCES professor(id),
   o_id VARCHAR,
   semester VARCHAR,

   FOREIGN KEY (o_id, semester) REFERENCES offering (id, semester)
);

create table offers(
   c_id VARCHAR,
   d_name VARCHAR REFERENCES department(name),
   FOREIGN KEY (c_id) REFERENCES course (id)
);

create table implements(
   o_id VARCHAR,
   semester VARCHAR,
   c_id VARCHAR REFERENCES course(id),
   FOREIGN KEY (o_id, semester) REFERENCES offering(id, semester)

);

create table taughtIn(
   o_id VARCHAR,
   semester VARCHAR,
   FOREIGN KEY (o_id, semester) REFERENCES offering (id, semester),
   room_code VARCHAR REFERENCES classroom(code)
);

create table locatedIn(
   building VARCHAR REFERENCES building(name),
   room_code VARCHAR REFERENCES classroom(code)
);

create table offeredOn(
   o_id VARCHAR,
   semester VARCHAR,
   day VARCHAR REFERENCES weekday(name),
   time_start TIME,
   time_end TIME,
   FOREIGN KEY (o_id, semester) REFERENCES offering (id, semester)
);

create table Requires(
   c_id VARCHAR REFERENCES course (id),
   req_id VARCHAR REFERENCES course(id)
);

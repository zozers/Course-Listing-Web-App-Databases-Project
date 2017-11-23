CREATE SCHEMA course_guide_data;

drop table professor CASCADE;
drop table department CASCADE;
drop table classroom CASCADE;
drop table offering CASCADE;
drop table course CASCADE;
drop table weekday CASCADE;
drop table building CASCADE;
drop table teaches CASCADE;
drop table implements CASCADE;
drop table offers CASCADE;
drop table taughtIn CASCADE;
drop table locatedIn CASCADE;
drop table offeredOn CASCADE;
drop table requires CASCADE;
drop table all_data CASCADE;


create table all_data(

course_offering_id   VARCHAR,
new   VARCHAR,
course_name VARCHAR,
credits  VARCHAR,
time_and_place VARCHAR,
semester VARCHAR,
professor_name VARCHAR,
first_year_friendly  VARCHAR,
max_students   VARCHAR,
course_description VARCHAR

);


--finished filling:
-- department(name)
-- professor(name, id, email)
-- offering(id, semester, pf, max_students)
-- weekday(name)
-- building(name)
-- teaches(professor.id, offering.id, offering.semester)
-- classroom(code, capacity) (half way done)
-- course(name, description, id, credits, first_year_friendly, first_semester_offered)
-- implements(offering.id, offering.semester, course.id,)






--not finished:


-- taughtIn(offering.id, offering.semester, classroom.code)
-- locatedIn(classroom.code, building.name)
-- offers(department.name, course.id)
-- offeredOn(offering.id, offering.semester, weekday.name, time_start, time_end)
-- requires(course.id, course.id, coreq)



create table professor(
   name VARCHAR (50)     NOT NULL,
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
   name VARCHAR      NOT NULL,
   credits VARCHAR (80)     NOT NULL,
   description   VARCHAR   NOT NULL,
   first_year VARCHAR(80) 	NOT NULL,
   when_new VARCHAR(10)   NOT NULL,
   id SERIAL,

   PRIMARY KEY (id)
);

create table offering(
   id VARCHAR (50)      NOT NULL ,
   semester VARCHAR (50)     NOT NULL,
   pf VARCHAR(50) 	NOT NULL, /* NEED SOME SORT OF BOOLEAN TYPE */
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
   c_id SERIAL,
   d_name VARCHAR REFERENCES department(name),
   FOREIGN KEY (c_id) REFERENCES course (id)
);

create table implements(
   o_id VARCHAR,
   semester VARCHAR,
   c_id SERIAL REFERENCES course(id),
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
   c_id SERIAL REFERENCES course (id),
   req_id SERIAL REFERENCES course(id)
);

CREATE SCHEMA course_guide_data;

drop table if exists professor CASCADE;
drop table if exists department CASCADE;
drop table if exists classroom CASCADE;
drop table if exists offering CASCADE;
drop table if exists course CASCADE;
drop table if exists weekday CASCADE;
drop table if exists building CASCADE;
drop table if exists teaches CASCADE;
drop table if exists implements CASCADE;
drop table if exists offers CASCADE;
drop table if exists taughtIn CASCADE;
drop table if exists locatedIn CASCADE;
drop table if exists offeredOn CASCADE;
drop table if exists requires CASCADE;
drop table if exists all_data CASCADE;


create table all_data( /* table only used for inserting data */

course_offering_id   VARCHAR,
semester VARCHAR,
pf VARCHAR,
new   VARCHAR,
course_name VARCHAR,
credits  VARCHAR,
time_  VARCHAR,   
days VARCHAR,
classroom VARCHAR,
professor_name VARCHAR,
first_year_friendly  VARCHAR,
max_students   VARCHAR,
course_description VARCHAR

);


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


create table classroom(
   code VARCHAR (20)     NOT NULL,
   capacity int     NOT NULL,
   PRIMARY KEY (code)
);

create table course(
   name VARCHAR      NOT NULL,
   credits VARCHAR (80)     NOT NULL,
   description   VARCHAR   NOT NULL,
   first_year VARCHAR(80)  NOT NULL,
   when_new VARCHAR(10)   NOT NULL,
   id SERIAL,

   PRIMARY KEY (id)
);

create table offering(
   id VARCHAR (50)      NOT NULL ,
   semester VARCHAR (50)     NOT NULL,
   pf VARCHAR(50)    NOT NULL, /* NEED SOME SORT OF BOOLEAN TYPE */
   max_students INT  NOT NULL,
   time_ VARCHAR (50) NOT NULL,
   days VARCHAR (50) NOT NULL,
   description VARCHAR NOT NULL, /* Temporary for joining the course and offering together is dropped in insert statments. Better data would be more helpful*/
   name VARCHAR NOT NULL, /* Temporary for joining the course and offering together is dropped in insert statments. Better data would be more helpful*/
   credits VARCHAR NOT NULL, /* Temporary for joining the course and offering together is dropped in insert statments. Better data would be more helpful*/
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


create table Requires(
   c_id SERIAL REFERENCES course (id),
   req_id SERIAL REFERENCES course(id)
);

create table coRequires(
   c_id SERIAL REFERENCES course (id),
   coreq_id SERIAL REFERENCES course(id)
);


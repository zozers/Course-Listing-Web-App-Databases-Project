
-- insert into teaches(p_id, o_id, semester)
	
-- 	SELECT id as p_id, course_offering_id as o_id, semester as sem FROM(
	
-- 		SELECT name, id, course_offering_id, professor_name, semester
-- 	    	FROM professor, all_data
-- 	    		WHERE name = professor_name) as teaches;



-- insert into course(name,credits, description, first_year, when_new)
-- 	 select distinct course_name, credits, course_description, first_year_friendly, new from all_data;

-- insert into implements(c_id, o_id, semester)
-- 	select id, course_offering_id, semester from (
-- 	select id, course_offering_id, semester, name, course_name from course, all_data where name = course_name)as implement;
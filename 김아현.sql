8)
SELECT regions.region_id, regions.region_name, countries.country_name
FROM countries JOIN regions ON(regions.region_id = countries.region_id AND regions.region_name = 'Europe');
9)
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id
     AND regions.region_name = 'Europe');
10)
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city, departments.department_name
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id)
     JOIN departments ON( departments.location_id = locations.location_id  AND regions.region_name = 'Europe');
11)   
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city,departments.department_name,
      (employees.FIRST_NAME||employees.LAST_NAME) NAME 
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id)
     JOIN departments ON( departments.location_id = locations.location_id)
     JOIN employees ON( departments.department_id = employees.department_id AND regions.region_name = 'Europe');
12)
SELECT employees.employee_id,(employees.FIRST_NAME||employees.LAST_NAME) NAME, jobs.job_id, jobs.job_title
FROM employees JOIN jobs ON(employees.job_id = jobs.job_id);
13)
SELECT e.manager_id mr_id, e.employee_id, m.first_name || m.last_name mgr_name
            , e.first_name || e.last_name, e.job_id, jobs.job_title name
FROM employees e, jobs, employees m
WHERE e.job_id =jobs.job_id
      AND e.manager_id = m.employee_id
      AND e.manager_id =100;

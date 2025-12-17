show databases;
use project_medical_data_history;
show tables;

select * from admissions;
select * from doctors;
select * from patients;
select * from province_names;

-- ques: 1
-- Show first name, last name, and gender of patients who's gender is 'M'
select first_name, last_name, gender from patients where gender = 'M';

-- ques: 2 
-- Show first name and last name of patients who does not have allergies.
select first_name, last_name from patients where allergies is null;

-- ques: 3
-- Show first name of patients that start with the letter 'C'
select * from patients where left(first_name,1) in ('C');

-- ques: 4
-- Show first name and last name of patients that weight within the range of 100 to 120
 select first_name, last_name, weight from patients where weight between 100 and 120;
 
 -- ques: 5
 select first_name, last_name, coalesce(allergies, 'NKA') as allergies  from patients;
 
 -- ques: 6
 select concat(first_name,' ',last_name) as full_name from patients;
 
 -- ques: 7
 select p.first_name, p.last_name, n.province_name from patients p left join province_names n on p.province_id = n.province_id;
 
 -- ques: 8
 select count(*) as total_count from patients where year(birth_date) = 2010;
  
-- ques: 9
select first_name, last_name, height from patients order by height desc;

-- ques: 10
select * from patients where  patient_id in (1,45,534,879,1000);

-- ques: 11
select count(*) as total_count from admissions;

-- ques: 12
select * from admissions where admission_date = discharge_date;

-- ques: 13
select count(*) as t_count from admissions where patient_id = '579';

-- ques: 14
select distinct city from patients where province_id = 'NS';

-- ques: 15
select first_name, last_name, birth_date from patients where height > 160 and weight > 70;

-- ques: 16
select distinct year(birth_date)  from patients order by year(birth_date) asc;

-- ques: 17
select first_name from patients group by first_name having count(first_name) = 1;

-- ques: 18
select patient_id, first_name from patients where first_name like 's%s' and length(first_name) >= 6;

-- ques: 19
select a.patient_id, first_name, last_name, a.diagnosis from patients p right join admissions a on p.patient_id = a.patient_id where a.diagnosis = 'Dementia';

-- ques: 20
select first_name from patients order by length(first_name), first_name;

-- ques: 21 and 22
SELECT 
    COUNT(IF(gender = 'M', 1, NULL)) AS male_count,
    COUNT(IF(gender = 'F', 1, NULL)) AS female_count FROM patients;
    
-- ques: 23
select patient_id, diagnosis from admissions  group by patient_id, diagnosis having count(*) > 1;

-- ques: 24
select city, count(*) as total_count from patients group by city order by   total_count desc, city asc;

-- ques: 25
select first_name, last_name, 'Patient' as role from patients union all select first_name, last_name, 'Doctor' as role from doctors;

-- ques: 26
SELECT allergies, COUNT(*) AS total_occurrences FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_occurrences DESC;

-- ques: 27
select first_name, last_name, birth_date from patients where birth_date between '1970-01-01' and '1979-12-31' order by birth_date asc;

-- ques: 28
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS formatted_name FROM patients ORDER BY first_name DESC;

-- ques: 29
select province_id, sum(height) as total_height from patients group by province_id having total_height >= 7000;

-- ques: 30
select (max(weight)-min(weight)) as difference from patients where last_name = 'Maroni';

-- ques: 31
select day(admission_date) as day_number, count(*) as countings from admissions group by day_number order by countings desc;

-- ques: 32
SELECT (weight) AS weight_group, COUNT(*) AS total_patients FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- ques: 33
select patient_id, weight, height, case when weight/power(height/100.0, 2) >= 30 then 1 else 0 end as isobese from patients;

-- ques: 34
select p.patient_id, p.first_name, p.last_name, d.specialty,  a.diagnosis, d.first_name as doctor_name from patients p 
join admissions a on p.patient_id = a.patient_id
join doctors d on a.attending_doctor_id = d.doctor_id where a.diagnosis = 'Epilepsy' and d.first_name = 'Lisa';
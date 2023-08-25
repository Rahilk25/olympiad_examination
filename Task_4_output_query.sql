--Task 4 Query

select  sr.question_number,subject,class , paper_code, count(sr.option_marked)  as no_of_students
from student_response sr
join question_paper_code pc on pc.paper_code = sr.question_paper_code
join correct_answers ca on ca.question_paper_code = pc.paper_code and ca. question_number = sr.question_number
where sr.option_marked = 'e'  
group by 3,4,2,1

order by 5 desc;


--Task 3 Query

with cte as 
(select  subject,class ,sr.question_number, paper_code, count(sr.option_marked)  as no_of_students
from student_response sr
join question_paper_code pc on pc.paper_code = sr.question_paper_code
join correct_answers ca on ca.question_paper_code = pc.paper_code and ca. question_number = sr.question_number
where sr.option_marked <> 'e' and sr.option_marked<>ca.correct_option 
group by 3,4,2,1

order by 4 ),
cte2 as
(select (count(roll_number)*60)/100 as sixty_per_students, class
from student_list
group by class)

select question_number,subject,a.class , paper_code,no_of_students
from cte a
join cte2 b on a.class = b.class
where no_of_students > sixty_per_students
order by 5 desc;
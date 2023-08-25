--Task 2 Query


with cte AS
(With Cte As
	(Select Sl.Roll_number,
			Sl.Student_name,
			Sl.Class,
			Sl.Section,
			Sl.School_name,
			Sum(Case When Qpc.Subject = 'Math'
		    And Sr.Question_paper_code = Ca.Question_paper_code And Sr.Option_marked <> 'e'
			And Sr.Option_marked = Ca.Correct_option Then 1 Else 0 End) As Math_correct,
	 
			Sum(Case When Qpc.Subject = 'Math' And Sr.Question_paper_code = Ca.Question_paper_code
            And Sr.Option_marked <> 'e' And Sr.Option_marked <> Ca.Correct_option Then 1 Else 0
							End) As Math_wrong,
	 
			Sum(Case When Qpc.Subject = 'Math' And Sr.Question_paper_code = Ca.Question_paper_code
            And Sr.Option_marked = 'e' Then 1 Else 0 End) As Math_yet_to_learn,
											
							
			Sum(Case When Qpc.Subject = 'Science' And Sr.Question_paper_code = Ca.Question_paper_code
            And Sr.Option_marked <> 'e' And Sr.Option_marked = Ca.Correct_option Then 1 Else 0
 		     End) As Science_correct,
	 
			Sum(Case When Qpc.Subject = 'Science' And Sr.Question_paper_code = Ca.Question_paper_code
            And Sr.Option_marked <> 'e' And Sr.Option_marked <> Ca.Correct_option Then 1 Else 0 End) As Science_wrong,
	 
			Sum(Case When Qpc.Subject = 'Science' And Sr.Question_paper_code = Ca.Question_paper_code 
				And Sr.Option_marked = 'e' Then 1 Else 0 End) As Science_yet_to_learn,
	 
			Sum(Case When Qpc.Subject = 'Science' Then 1 Else 0 End) As Total_science_questions,
	 
			Sum(Case When Qpc.Subject = 'Math' Then 1 Else 0  End) As Total_math_questions
		From Student_list Sl
		Join Student_response Sr On Sr.Roll_number = Sl.Roll_number
		Join Correct_answers Ca On Ca.Question_paper_code = Sr.Question_paper_code
		And Ca.Question_number = Sr.Question_number
		Join Question_paper_code Qpc On Qpc.Paper_code = Ca.Question_paper_code
		Group by 1,2,3,4,5)
		
Select Roll_number,Student_name,Class,Section,School_name,Math_correct,Math_wrong,Math_yet_to_learn,
	Math_correct As Math_score, 
	Round((Math_correct:: decimal / Total_math_questions:: decimal) * 100,2) || '%'As Math_percentage,
	Science_correct,Science_wrong,Science_yet_to_learn, science_correct As science_score,
	Round((Science_correct:: decimal / Total_science_questions:: decimal) * 100,2) || '%'As Science_percentage,total_math_questions,total_science_questions
From Cte)
 
Select Roll_number, Student_name,class, section, School_name,math_score , total_math_questions as out_of_score_math, 
science_score,total_science_questions as out_of_score_science, (math_score + science_score) as total_score, (total_math_questions+total_science_questions) as out_of_score_total,
round(((math_score + science_score)::decimal/(total_math_questions+total_science_questions)::decimal)*100,2)||'%' as total_percentage,
 case when round(((math_score + science_score)::decimal/(total_math_questions+total_science_questions)::decimal)*100,2) < '25' then 'Fail' else 'Pass' end as final_result

from cte
order by total_score desc;

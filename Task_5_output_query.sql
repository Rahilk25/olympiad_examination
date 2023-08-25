--Task 5 Query

select roll_number,Left (student_name,3)||'.'|| right (roll_number:: text,3)||'@gpsedu.org'as email_id,
'#'||right (student_name,4)||roll_number||'@'||class||'%'||section as temp_pass ,
student_name, class, section
from student_list;
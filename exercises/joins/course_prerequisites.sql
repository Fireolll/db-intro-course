-- Завдання:
--      Сформувати список усіх курсів разом з їхніми пре-реквізитами
--      Очікувані колонки результату:
--          - назва курсу (course_name)
--          - назва пре-реквізиту (prerequisite_name)
--      Включити усі курси, навіть ті, що не мають пре-реквізитів
--      Результат відсортувати за:
--          - назвою курсу, потім за назвою пре-реквізиту

-- Рішення:

select 
	c.name as course_name,
	p.name AS prerequisite_name
from course c 
left join 
	course_prerequisite c_p on c.course_id = c_p.course_id
left join 
	course p ON c_p.prerequisite_course_id = p.course_id
order by
	course_name, prerequisite_name;
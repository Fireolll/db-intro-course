-- Завдання:
--      Знайти всіх студентів, які записані на більше курсів ніж в середньому
--      Очікувані колонки результату:
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (full_name)
--          - кількість курсів студента (course_number)
--          - середня кількість курсів серед усіх студентів (avg_number) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - кількістю курсів студента (спадання), потім за іменем студента, потім за ідентифікатор студента

-- Рішення:
with stud_with_many_enr as (
    select
        s.student_id,
        per.first_name || ' ' || per.last_name as full_name,
        count(e.course_id) as course_number
    from student s
    inner join person per using(person_id)
    inner join enrolment e using(student_id)
    group by s.student_id, full_name
)
select
    student_id,
    full_name,
    course_number,
    round((select avg(course_number) 
    from stud_with_many_enr), 2) 
    as avg_number
from stud_with_many_enr
where course_number > (
    select avg(course_number)
    from stud_with_many_enr
)
order by course_number desc, full_name;
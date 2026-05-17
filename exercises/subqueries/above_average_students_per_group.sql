-- Завдання:
--      Знайти студентів, чий середній бал перевищує середній бал їхньої групи
--      Використати два CTE: один для середнього балу студента, інший для середнього балу групи
--      Очікувані колонки результату:
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (full_name)
--          - назва групи (group_name)
--          - середній бал студента (avg_student_grade) - округлити результат до 2 знаків після коми
--          - середній бал групи (avg_group_grade) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - назвою групи, потім за середнім балом студента (спадання), потім за іменем студента

-- Рішення:
with student_avg as (
    select
        s.student_id,
        p.first_name || ' ' || p.last_name as full_name,
        s.group_id,
        avg(e.grade)::numeric as avg_value
    from student s
    join person p using (person_id)
    join enrolment e using (student_id)
    where e.grade is not null
    group by s.student_id, 
             p.first_name, 
             p.last_name, 
             s.group_id
),
group_avg as (
    select
        s.group_id,
        avg(e.grade)::numeric as avg_value
    from student s
    join enrolment e using (student_id)
    where e.grade is not null
    group by s.group_id
)
select
    sa.student_id,
    sa.full_name,
    sg.name as group_name,
    round(sa.avg_value, 2)::float8 as avg_student_grade,
    round(ga.avg_value, 2)::float8 as avg_group_grade
from student_avg sa
join group_avg ga using (group_id)
join student_group sg using (group_id)
where round(sa.avg_value, 2) > round(ga.avg_value, 2)
order by
    group_name asc,
    avg_student_grade desc,
    full_name asc;
-- сподіваюся зараз все точно запрацюж
-- Завдання:
--      Для кожного курсу знайти мінімальний семестр, в якому він може читатись
--      Очікувані колонки результату:
--          - ідентифікатор курсу (course_id)
--          - назва курсу (name)
--          - мінімальний рік (min_year)
--      Результат відсортувати за:
--          - мінімальним роком (зростання), потім за назвою курсу

-- Рішення:
with recursive course_depth as (
    select
        c.course_id,
        c.name,
        1 as min_year
    from course c
    left join course_prerequisite cp using(course_id)
    where cp.prerequisite_course_id is null

    union all

    select
        c.course_id,
        c.name,
        cd.min_year + 1
    from course c
    inner join course_prerequisite cp using(course_id)
    inner join course_depth cd
        on cp.prerequisite_course_id = cd.course_id
)
select
    course_id,
    name,
    max(min_year) as min_year
from course_depth
group by course_id, name
order by min_year asc, name;
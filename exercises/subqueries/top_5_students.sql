-- Завдання:
--      Знайти топ-5 студентів у кожному курсі за отриманими балами
--      Очікувані колонки результату:
--          - назва курсу (course_name)
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (student_full_name)
--          - бал (grade)
--          - ранг (rank) - за балом, іменем студента та ідентифікатором студента
--      Результат відсортувати за:
--          - назвою курсу, потім за рангом (зростання), потім за іменем студента, потім за ідентифікатором студента

-- Рішення:
select
    course_name,
    student_id,
    student_full_name,
    grade,
    rank
from (
    select
        c.name as course_name,
        s.student_id,
        per.first_name || ' ' || per.last_name as student_full_name,
        e.grade,
        row_number() over (
            partition by c.course_id
            order by e.grade desc,
                    per.first_name || ' ' || per.last_name asc
        ) as rank
    from course c
    inner join enrolment e using(course_id)
    inner join student s using(student_id)
    inner join person per using(person_id)
    where e.grade is not null
) as sub
where rank <= 5
order by course_name,
         rank asc,
         student_full_name;
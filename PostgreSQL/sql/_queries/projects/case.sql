CREATE OR REPLACE FUNCTION get_projects_case(
    min_tasks_per_employee int,     -- Minimum number of tasks per employee
    min_employees_per_project int   -- Minimum number of employees in a project who meet the above threshold
)
  RETURNS TABLE (
    project_id int,
    project_title text,
    employee_count bigint  -- Number of employees in the project who have >= min_tasks_per_employee tasks
  )
  LANGUAGE sql
AS $$
    /*
      This function returns all projects that satisfy the following criteria:
        1) They have at least `min_employees_per_project` employees.
        2) Each of those employees has at least `min_tasks_per_employee` tasks.

      Implementation outline using CASE:
        - First, aggregate tasks by (project_id, employee_id) to get each employee's task count.
        - In the outer query, GROUP BY project, and use a CASE expression to increment the sum
          by 1 only if the employee's task_count >= min_tasks_per_employee.
        - HAVING ensures the project has at least min_employees_per_project employees meeting that threshold.
    */

    SELECT 
       p.id AS project_id,
       p.title AS project_title,
       SUM(
         CASE 
           WHEN sub.task_count >= min_tasks_per_employee 
           THEN 1 
           ELSE 0 
         END
       ) AS employee_count
    FROM (
        -- Aggregate tasks by (project_id, employee_id)
        SELECT 
            t.project_id,
            t.employee_id,
            COUNT(*) AS task_count
        FROM task AS t
        WHERE t.employee_id IS NOT NULL
        GROUP BY t.project_id, t.employee_id
    ) AS sub
    JOIN project p 
      ON p.id = sub.project_id
    GROUP BY p.id, p.title
    HAVING SUM(
             CASE 
               WHEN sub.task_count >= min_tasks_per_employee 
               THEN 1 
               ELSE 0 
             END
           ) >= min_employees_per_project;
$$;

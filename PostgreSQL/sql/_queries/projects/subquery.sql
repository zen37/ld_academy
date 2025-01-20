CREATE OR REPLACE FUNCTION get_projects_subquery(
    min_tasks_per_employee int,  -- Minimum number of tasks each employee must have
    min_employees_per_project int -- Minimum number of employees in a project who meet the above threshold
)
  RETURNS TABLE (
    project_id int,
    project_title text,
    employee_count bigint -- How many employees in that project meet the min_tasks_per_employee threshold
  )
  LANGUAGE sql
AS $$
    /*
      This function returns all projects that satisfy the following criteria:
        1) They have at least `min_employees_per_project` employees.
        2) Each of those employees has at least `min_tasks_per_employee` tasks assigned.

      Implementation outline:
        - Identify all (project_id, employee_id) pairs where the employee has >= min_tasks_per_employee tasks.
        - Join the resulting set back to the `project` table, then group again to find
          how many employees per project meet that task threshold.
        - Filter out any projects that do not have at least `min_employees_per_project` employees.
    */
    SELECT p.id AS project_id,
           p.title AS project_title,
           COUNT(*) AS employee_count
    FROM (
        -- Step 1: Find employees with >= min_tasks_per_employee tasks per project
        SELECT t.project_id,
               t.employee_id
        FROM task AS t
        WHERE t.employee_id IS NOT NULL
        GROUP BY t.project_id, t.employee_id
        HAVING COUNT(t.id) >= min_tasks_per_employee
    ) AS sub
    -- Step 2: Join to projects and count how many employees per project hit the threshold
    JOIN project AS p
      ON p.id = sub.project_id
    GROUP BY p.id, p.title
    -- Step 3: Keep only the projects with >= min_employees_per_project employees meeting the threshold
    HAVING COUNT(*) >= min_employees_per_project;
$$;

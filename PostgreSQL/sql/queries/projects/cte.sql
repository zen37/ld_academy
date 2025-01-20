--This version is typically as efficient as the subselect, and many find the CTE style easier to read/maintain.

CREATE OR REPLACE FUNCTION get_projects_cte(
    min_tasks_per_employee int,     -- Minimum number of tasks each employee must have
    min_employees_per_project int   -- Minimum number of employees in a project who meet the above threshold
)
  RETURNS TABLE (
    project_id int,
    project_title text,
    employee_count bigint  -- How many employees in that project meet the min_tasks_per_employee threshold
  )
  LANGUAGE sql
AS $$
    /*
      This function returns all projects that satisfy the following criteria:
        1) They have at least `min_employees_per_project` employees.
        2) Each of those employees has at least `min_tasks_per_employee` tasks assigned.

      Implementation outline:
        - Use a CTE ("employees_with_min_tasks") to gather all (project_id, employee_id) pairs 
          where the employee has >= min_tasks_per_employee tasks on that project.
        - Join that CTE back to the "project" table, group by project, 
          and filter out any project with fewer than "min_employees_per_project" employees meeting the threshold.
    */
    WITH employees_with_min_tasks AS (
        SELECT t.project_id,
               t.employee_id
        FROM task AS t
        WHERE t.employee_id IS NOT NULL
        GROUP BY t.project_id, t.employee_id
        HAVING COUNT(t.id) >= min_tasks_per_employee
    )
    SELECT p.id AS project_id,
           p.title AS project_title,
           COUNT(*) AS employee_count
    FROM employees_with_min_tasks e
    JOIN project p
      ON p.id = e.project_id
    GROUP BY p.id, p.title
    HAVING COUNT(*) >= min_employees_per_project;
$$;

COMMENT ON FUNCTION get_projects_cte(int, int)
    IS 'Returns projects with at least N employees who each have at least M tasks; it uses CTE.';

WITH ep AS (
    -- 1) For each project, gather all employees assigned to that project into an array
    SELECT
        project_id,
        array_agg(employee_id) AS earr
    FROM EmployeeProject
    GROUP BY project_id
)
INSERT INTO Task (project_id, employee_id, title, description, deadline, status)
SELECT
    -- The project
    p.project_id,
    
    -- 2) Randomly pick an employee out of the array for that project
    p.earr[(random() * array_length(p.earr, 1))::int + 1] AS employee_id,
    
    -- Example random data for the Task
    'Task Title ' || p.project_id || '-' || s AS title,
    'Task Description ' || p.project_id || '-' || s AS description,
    CURRENT_DATE + (random() * 30)::int AS deadline,
    CASE 
      WHEN random() < 0.33 THEN 'new'
      WHEN random() < 0.66 THEN 'open'
      ELSE 'completed'
    END AS status

FROM ep p

-- 3) For each project, generate a random number of tasks between 10..100
CROSS JOIN LATERAL generate_series(1, (10 + (random() * 91)::int)) s

-- (Optional) In case some projects have no employees, you might skip them:
WHERE p.earr IS NOT NULL;

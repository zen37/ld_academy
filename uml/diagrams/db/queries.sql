/* projects with open tasks and the employees assigned to those tasks. */

SELECT DISTINCT 
    p.project_id,
    p.project_name,
    t.task_id,
    t.task_name,
    t.status,
    t.due_date,
    e.employee_id,
    e.first_name,
    e.last_name,
    e.position
FROM 
    PROJECT p
JOIN 
    TASK t ON p.project_id = t.project_id
JOIN 
    EMPLOYEE e ON e.employee_id = t.employee_id
WHERE 
    t.status = 'Open'
ORDER BY 
    p.project_id, 
    t.due_date;


Project Details with Task Status Counts:
SELECT 
    p.project_id,
    p.project_name,
    p.description,
    p.start_date,
    p.end_date,
    COUNT(CASE WHEN t.status = 'Open' THEN 1 END) AS open_tasks,
    COUNT(CASE WHEN t.status = 'In Progress' THEN 1 END) AS in_progress_tasks,
    COUNT(CASE WHEN t.status = 'Completed' THEN 1 END) AS completed_tasks,
    COUNT(t.task_id) AS total_tasks
FROM 
    PROJECT p
LEFT JOIN 
    TASK t ON p.project_id = t.project_id
GROUP BY 
    p.project_id,
    p.project_name,
    p.description,
    p.start_date,
    p.end_date
ORDER BY 
    p.project_id;


Employee Details with Task Status Counts:
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.position,
    COUNT(CASE WHEN t.status = 'Open' THEN 1 END) AS open_tasks,
    COUNT(CASE WHEN t.status = 'In Progress' THEN 1 END) AS in_progress_tasks,
    COUNT(CASE WHEN t.status = 'Completed' THEN 1 END) AS completed_tasks,
    COUNT(t.task_id) AS total_tasks
FROM 
    EMPLOYEE e
LEFT JOIN 
    TASK t ON e.employee_id = t.employee_id
GROUP BY 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.position
ORDER BY 
    e.employee_id;
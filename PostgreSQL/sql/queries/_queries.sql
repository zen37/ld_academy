-- Employees who are not assigned to any project.

SELECT * 
FROM Employee e 
WHERE NOT EXISTS 
(
    SELECT 1 FROM EmployeeProject ep WHERE ep.employee_id = e.id
)


SELECT e.* 
FROM Employee e LEFT JOIN EmployeeProject ep ON e.id = ep.employee_id 
WHERE ep.employee_id IS NULL;



-- tasks

SELECT COUNT(*) AS unassigned_tasks
FROM Task
WHERE employee_id IS NULL;

-- check how many tasks are now assigned an employee
SELECT employee_id, COUNT(*) AS task_count
FROM Task
WHERE employee_id IS NOT NULL
GROUP BY employee_id;

-- find tasks where the assigned employee is not assigned to the task's project in EmployeeProject.
SELECT t.id, t.project_id, t.employee_id
FROM Task t
where t.employee_id is not null
and
NOT EXISTS (
    SELECT 1
    FROM EmployeeProject ep
    WHERE ep.employee_id = t.employee_id
    AND ep.project_id = t.project_id
);

-- list of projects that have at least 3 employees with at least 3 tasks each
SELECT p.id, p.title
FROM (
    SELECT t.project_id, t.employee_id, COUNT(t.id) AS task_count
    FROM Task t
    WHERE t.employee_id IS NOT NULL -- Consider only tasks with assigned employees
    GROUP BY t.project_id, t.employee_id
    HAVING COUNT(t.id) >= 3 -- Each employee must have at least 3 tasks
) task_query
inner join project p on p.id = task_query.project_id
GROUP BY p.id, p.title
HAVING COUNT(employee_id) >= 3; -- At least 3 employees with 3+ tasks


-- list of projects that have at least 3 employees with at least 3 tasks each and count of employees

SELECT p.id, p.title, count(*)
FROM (
    SELECT t.project_id, t.employee_id, COUNT(t.id) AS task_count
    FROM Task t
    WHERE t.employee_id IS NOT NULL -- Consider only tasks with assigned employees
    GROUP BY t.project_id, t.employee_id
    HAVING COUNT(t.id) >= 3 -- Each employee must have at least 3 tasks
) task_query
inner join project p on p.id = task_query.project_id
GROUP BY p.id, p.title
HAVING COUNT(employee_id) >= 3; -- At least 3 employees with 3+ tasks


SELECT 
    p.id AS project_id, 
    p.title AS project_title, 
    COUNT(DISTINCT task_query.employee_id) AS employee_count
FROM (
    SELECT t.project_id, t.employee_id, COUNT(t.id) AS task_count
    FROM Task t
    WHERE t.employee_id IS NOT NULL -- Consider only tasks with assigned employees
    GROUP BY t.project_id, t.employee_id
    HAVING COUNT(t.id) >= 3 -- Each employee must have at least 3 tasks
) task_query
INNER JOIN Project p ON p.id = task_query.project_id
GROUP BY p.id, p.title
HAVING COUNT(task_query.employee_id) >= 3; -- At least 3 employees with 3+ tasks


-- find employees that do not have any tasks

SELECT e.id AS employee_id, e.name
FROM employee e
LEFT JOIN task t ON e.id = t.employee_id
WHERE t.id IS NULL
ORDER BY e.id;

SELECT e.id AS employee_id, e.name
FROM employee e
WHERE NOT EXISTS (
    SELECT 1
    FROM task t
    WHERE t.employee_id = e.id
)
ORDER BY e.id;
DO $$
DECLARE
    project_ids INTEGER[] := ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9]; -- 9 projects
    status_options TEXT[] := ARRAY['new', 'open', 'completed'];
    task_count INTEGER := 300;
BEGIN
    FOR i IN 1..task_count LOOP
        INSERT INTO Task (project_id, employee_id, title, description, deadline, status)
        VALUES (
            project_ids[ceil(random() * array_length(project_ids, 1))], -- Random project_id
            (SELECT id FROM Employee ORDER BY random() LIMIT 1),       -- Random employee_id
            'Task Title ' || i,                                        -- Task title
            'Task Description ' || i,                                 -- Task description
            CURRENT_DATE + (random() * 30)::INTEGER,                   -- Random deadline within 30 days
            status_options[ceil(random() * array_length(status_options, 1))] -- Random status
        );
    END LOOP;
END $$;

-- add employee

DO $$
DECLARE
    task_row RECORD; -- Renamed to avoid conflict with the Task table
    valid_employee_id INTEGER;
    updated_count INTEGER := 0;
BEGIN
    -- Iterate over tasks without an employee assigned
    FOR task_row IN
        SELECT id, project_id FROM Task WHERE employee_id IS NULL LIMIT 200
    LOOP
        -- Find a random valid employee assigned to the same project
        SELECT id INTO valid_employee_id
        FROM Employee
        WHERE id IN (
            SELECT employee_id
            FROM EmployeeProject
            WHERE project_id = task_row.project_id
        )
        ORDER BY random()
        LIMIT 1;

        -- Assign the employee to the task if a valid employee exists
        IF valid_employee_id IS NOT NULL THEN
            UPDATE Task
            SET employee_id = valid_employee_id
            WHERE id = task_row.id; -- Reference task_row explicitly

            updated_count := updated_count + 1;
        END IF;

        -- Exit loop early if we’ve updated 200 tasks
        EXIT WHEN updated_count >= 200;
    END LOOP;

    -- Output the result
    RAISE NOTICE 'Assigned employees to % tasks.', updated_count;
END $$;

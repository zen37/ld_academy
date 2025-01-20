CREATE TABLE Task (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_id INTEGER NOT NULL,
    employee_id INTEGER,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    deadline DATE,
    status TEXT NOT NULL CHECK (status IN ('new', 'open', 'completed')),
    FOREIGN KEY (project_id) REFERENCES Project(id),
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
);


ALTER TABLE Task DROP CONSTRAINT task_project_id_fkey;
ALTER TABLE Task DROP CONSTRAINT task_employee_id_fkey;

ALTER TABLE Task
    ADD CONSTRAINT task_project_id_fkey
    FOREIGN KEY (project_id) REFERENCES Project(id)
    ON DELETE CASCADE;

ALTER TABLE Task
    ADD CONSTRAINT task_employee_id_fkey
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
    ON DELETE SET NULL;


CREATE INDEX idx_task_project_id ON Task(project_id);
CREATE INDEX idx_task_employee_id ON Task(employee_id);

DROP INDEX IF EXISTS idx_task_project_id;
DROP INDEX IF EXISTS idx_task_employee_id;

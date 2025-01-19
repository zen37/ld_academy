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

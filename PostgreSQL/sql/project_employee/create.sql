CREATE TABLE EmployeeProject (
    id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE,
    CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES Employee(id),
    CONSTRAINT fk_project_id FOREIGN KEY (project_id) REFERENCES Project(id)
);
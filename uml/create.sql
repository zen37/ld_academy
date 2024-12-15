CREATE TABLE Department (
 id INTEGER PRIMARY KEY,
 department_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
 id INTEGER PRIMARY KEY,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL
);

CREATE TABLE Project (
 id INTEGER PRIMARY KEY,
 project_name VARCHAR(255) NOT NULL,
 creation_date DATE NOT NULL,
 project_status TEXT NOT NULL CHECK(project_status IN ('open', 'closed')),
 closure_date DATE NULL
);


CREATE TABLE Employee_Project (
 id INTEGER PRIMARY KEY,
 employee_id INTEGER NOT NULL,
 project_id INTEGER NOT NULL,
 position VARCHAR(100) NOT NULL,
 FOREIGN KEY (employee_id) REFERENCES Employee(id),
 FOREIGN KEY (project_id) REFERENCES Project(id)
);

CREATE TABLE Task (
 id INTEGER PRIMARY KEY,
 project_id INTEGER NOT NULL,
 employee_id INTEGER NOT NULL,
 task_description TEXT NOT NULL,
 deadline DATE,
 status TEXT CHECK(status = 'open' or status = 'completed' or status = 'requires revision' or status = 'accepted'  ) NOT NULL,
 FOREIGN KEY (project_id) REFERENCES Project(id),
 FOREIGN KEY (employee_id) REFERENCES Employee(id)
);

CREATE TABLE Task_Status_History (
 id INTEGER PRIMARY KEY,
 task_id INTEGER NOT NULL,
 status TEXT CHECK(status = 'open' or status = 'completed' or status = 'requires revision' or status = 'accepted'  ) NOT NULL,
 task_status_date DATE NOT NULL,
 updated_by INTEGER NOT NULL,
 FOREIGN KEY (task_id) REFERENCES Task(id),
 FOREIGN KEY (updated_by) REFERENCES Employee(id)
);
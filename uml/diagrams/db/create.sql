CREATE TABLE Employee (
 id PRIMARY KEY AUTO_INCREMENT
 name VARCHAR(100) NOT NULL,
 email VARCHAR(100) NOT NULL
);

CREATE TABLE Project (
 id PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(255) NOT NULL,
 description VARCHAR(255) NOT NULL,
 startdate DATE NOT NULL,
 enddate DATE,
 project_status TEXT NOT NULL CHECK(project_status IN ('open', 'closed')),
);


CREATE TABLE EmployeeProject (
 id PRIMARY KEY AUTO_INCREMENT,
 employee_id INTEGER NOT NULL,
 project_id INTEGER NOT NULL,
 startdate DATE NOT NULL,
 enddate DATE,
 FOREIGN KEY (employee_id) REFERENCES Employee(id),
 FOREIGN KEY (project_id) REFERENCES Project(id)
);

CREATE TABLE Task (
 id PRIMARY KEY AUTO_INCREMENT,
 project_id INTEGER NOT NULL,
 employee_id INTEGER NOT NULL,
 task_description TEXT NOT NULL,
 deadline DATE,
 status TEXT CHECK(status = 'open' or status = 'completed' or status = 'requires revision' or status = 'accepted'  ) NOT NULL,
 FOREIGN KEY (project_id) REFERENCES Project(id),
 FOREIGN KEY (employee_id) REFERENCES Employee(id)
     CONSTRAINT chk_Employee_Project
        CHECK (employee_id IN (
            SELECT employee_id
            FROM EmployeeProject
            WHERE EmployeeProject.project_id = Task.project_id
        ))
);

---Note: In PostgreSQL 10 and later, you can use the IDENTITY clause instead of SERIAL:

CREATE TABLE Project (
    id SERIAL PRIMARY KEY,
    title VARCHAR(128) NOT NULL,
    description VARCHAR(1024) NOT NULL,
    startdate DATE,
    enddate DATE,
    project_status TEXT NOT NULL CHECK(project_status IN ('new', 'open', 'closed'))
);

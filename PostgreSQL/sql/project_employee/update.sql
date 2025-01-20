INSERT INTO EmployeeProject (project_id, employee_id, startdate, enddate)
SELECT
   (random() * 19900)::int + 1,
   (random() * 99000)::int + 1,
   CURRENT_DATE + (random() * 100)::int,
   NULL  -- or some random logic
FROM generate_series(1, 500000) AS g;
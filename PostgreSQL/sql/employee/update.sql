DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO Employee (name, email, role)
        VALUES (
            'Employee ' || i,
            'employee' || i || '@example.com',
            CASE
                WHEN i <= 10 THEN 'Manager'
                WHEN i <= 30 THEN 'Team Lead'
                WHEN i <= 80 THEN 'Developer'
                WHEN i <= 90 THEN 'QA Engineer'
                ELSE 'Intern'
            END
        );

        i := i + 1;
    END LOOP;
END $$;
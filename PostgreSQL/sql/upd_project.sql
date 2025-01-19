DO $$
DECLARE
    i INTEGER := 1;
    status TEXT;
    start_date DATE;
    end_date DATE;
BEGIN
    WHILE i <= 100 LOOP
        status := CASE
            WHEN random() < 0.3 THEN 'new'
            WHEN random() < 0.7 THEN 'open'
            ELSE 'closed'
        END;

        IF status = 'new' THEN
            start_date := NULL;
            end_date := NULL;
        ELSIF status = 'open' THEN
            start_date := ('2022-01-01'::DATE + (random() * 365)::INTEGER);
            end_date := NULL;
        ELSE
            start_date := ('2022-01-01'::DATE + (random() * 365)::INTEGER);
            end_date := (start_date + (random() * 365)::INTEGER);
        END IF;

        INSERT INTO Project (title, description, startdate, enddate, project_status)
        VALUES (
            'Project ' || i,
            'This is a sample project description for project ' || i,
            start_date,
            end_date,
            status
        );

        i := i + 1;
    END LOOP;
END $$;
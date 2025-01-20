   CREATE TABLE query_logs (
       log_time TIMESTAMP DEFAULT now(),
       description TEXT,
       duration_ms NUMERIC
   );

DO $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
	query TEXT;
    query_description TEXT;
BEGIN
    start_time := clock_timestamp();
    query := '
		SELECT *
		FROM get_projects_case(3, 3);
    ';
    EXECUTE query;
    end_time := clock_timestamp();

	query_description := 'case start server';

    INSERT INTO query_logs (description, duration_ms)
    VALUES (query_description, EXTRACT(MILLISECOND FROM (end_time - start_time)));
END $$;

select * from query_logs;


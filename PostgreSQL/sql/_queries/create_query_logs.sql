   CREATE TABLE query_logs (
       log_time TIMESTAMP DEFAULT now(),
       description TEXT,
       duration_ms NUMERIC
   );

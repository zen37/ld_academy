Unfortunately, **`pg_stat_statements` does not store individual records for each query execution**. It aggregates execution statistics (e.g., total execution time, number of calls, average time) for each unique query plan. If you need detailed, per-execution query logs, you'll need to use other PostgreSQL features or external tools.

---

### **Options to Track Individual Query Executions**

#### **1. Use `log_statement` with Query Logging**
PostgreSQL can log each query execution into the server logs using `log_statement` or related settings:

1. **Enable Query Logging**:
   Edit your `postgresql.conf` file and set:
   ```plaintext
   log_statement = 'all'
   log_duration = on
   ```
   Alternatively, for detailed performance logs:
   ```plaintext
   log_min_duration_statement = 0  # Logs all queries and their durations
   ```

2. **Reload Configuration**:
   ```bash
   sudo /Library/PostgreSQL/17/bin/pg_ctl -D /Library/PostgreSQL/17/data reload
   ```

3. **View Logs**:
   Check the PostgreSQL log files (e.g., `/Library/PostgreSQL/17/data/log`) to see detailed information about each query execution.

---

#### **2. Use `pg_stat_activity` for Real-Time Monitoring**
`pg_stat_activity` provides details about currently running queries, including their execution time:

1. Run the following query to monitor active queries:
   ```sql
   SELECT pid, query, state, now() - query_start AS execution_time
   FROM pg_stat_activity
   WHERE state = 'active';
   ```

   While this doesn’t store historical data, you can use it to monitor real-time query execution.

---

#### **3. Use Extensions Like `pg_stat_kcache`**
The `pg_stat_kcache` extension provides detailed execution statistics at the system level. You can combine it with `pg_stat_statements` for more granular tracking.

1. Install and enable `pg_stat_kcache`:
   ```sql
   CREATE EXTENSION pg_stat_kcache;
   ```

2. Query detailed statistics (including read/write operations):
   ```sql
   SELECT * FROM pg_stat_kcache;
   ```

---

#### **4. Use an External Query Logging Tool**
If detailed, per-execution query logs are critical, consider tools like:
- **pgAudit**: Logs detailed query information, including arguments and execution details.
- **Performance Monitoring Tools** (e.g., pgAdmin, Percona Monitoring, or custom logging frameworks).

---

#### **5. Insert into a Custom Audit Table**
Create a trigger or manually insert query logs into a custom table for each execution:
1. Create a logging table:
   ```sql
   CREATE TABLE query_logs (
       log_time TIMESTAMP DEFAULT now(),
       query TEXT,
       duration_ms NUMERIC
   );
   ```

2. Log queries manually:
   ```sql
   DO $$
   DECLARE
       start_time TIMESTAMP;
       end_time TIMESTAMP;
   BEGIN
       start_time := clock_timestamp();
       -- Your query here
       PERFORM * FROM Employee e WHERE NOT EXISTS (
           SELECT 1 FROM EmployeeProject ep WHERE ep.employee_id = e.id
       );
       end_time := clock_timestamp();

       INSERT INTO query_logs (query, duration_ms)
       VALUES ('SELECT ...', EXTRACT(MILLISECOND FROM end_time - start_time));
   END $$;
   ```

---

### **Recommendation**
If you need **per-execution query records**:
- Use **`log_min_duration_statement`** for server logs.
- For deeper insights or real-time logging, implement **custom logging with a query log table**.

Let me know if you’d like help implementing one of these! 😊
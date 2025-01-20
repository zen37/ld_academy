Below is a single SQL snippet that compares **all three** function results at once. It uses CTEs to store each function’s output, then performs **EXCEPT** checks among all pairs (subquery vs. CTE, subquery vs. CASE, CTE vs. CASE). If everything is identical, the final query will return **no rows**.

```sql
WITH 
    sub AS (
        SELECT * 
        FROM get_projects_subquery(3, 3)
    ),
    cte AS (
        SELECT * 
        FROM get_projects_cte(3, 3)
    ),
    cas AS (
        SELECT *
        FROM get_projects_case(3, 3)
    ),
    diffs AS (
        (
            -- sub - cte
            SELECT 'sub EXCEPT cte' AS difference_marker, *
            FROM sub
            EXCEPT
            SELECT 'sub EXCEPT cte', *
            FROM cte
        )
        UNION ALL
        (
            -- cte - sub
            SELECT 'cte EXCEPT sub', *
            FROM cte
            EXCEPT
            SELECT 'cte EXCEPT sub', *
            FROM sub
        )
        UNION ALL
        (
            -- sub - cas
            SELECT 'sub EXCEPT cas', *
            FROM sub
            EXCEPT
            SELECT 'sub EXCEPT cas', *
            FROM cas
        )
        UNION ALL
        (
            -- cas - sub
            SELECT 'cas EXCEPT sub', *
            FROM cas
            EXCEPT
            SELECT 'cas EXCEPT sub', *
            FROM sub
        )
        UNION ALL
        (
            -- cte - cas
            SELECT 'cte EXCEPT cas', *
            FROM cte
            EXCEPT
            SELECT 'cte EXCEPT cas', *
            FROM cas
        )
        UNION ALL
        (
            -- cas - cte
            SELECT 'cas EXCEPT cte', *
            FROM cas
            EXCEPT
            SELECT 'cas EXCEPT cte', *
            FROM cte
        )
    )
SELECT *
FROM diffs;
```

### How It Works

1. **sub, cte, cas CTEs**:  
   - Each one calls a different function (`get_projects_subquery`, `get_projects_cte`, and `get_projects_case`) so we have the three result sets.

2. **diffs CTE**:  
   - We do **six** comparisons to capture the *symmetric difference* across all pairs:
     - `sub EXCEPT cte`  
     - `cte EXCEPT sub`  
     - `sub EXCEPT cas`  
     - `cas EXCEPT sub`  
     - `cte EXCEPT cas`  
     - `cas EXCEPT cte`
   - Each block returns rows that exist in the left set but **not** in the right set.

3. **Final SELECT**:  
   - Pulls all differences together. If this returns **no rows**, it means all three functions produce exactly the same `(project_id, project_title, employee_count)` sets. If anything **does** appear, the `difference_marker` column indicates which pair’s comparison revealed it.  

If you run that query and get **zero rows** returned, you can be confident the three functions have identical outputs.

## Timing

```sql
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
```
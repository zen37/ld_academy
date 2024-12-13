Window functions are a powerful feature in SQL that allow you to perform calculations across sets of table rows that are somehow related to the current row. They are particularly useful for running totals, moving averages, ranking, and other complex aggregations. PostgreSQL extends the standard SQL support for window functions with additional features and flexibility.

### Standard SQL Window Functions:
Standard SQL provides basic support for window functions, which include:
- **Aggregate functions**: Such as `SUM`, `AVG`, `COUNT`, `MIN`, and `MAX`.
- **Ranking functions**: Such as `ROW_NUMBER`, `RANK`, `DENSE_RANK`, and `NTILE`.
- **Analytic functions**: Such as `LAG`, `LEAD`, `FIRST_VALUE`, and `LAST_VALUE`.

### PostgreSQL Window Functions:
PostgreSQL offers extensive support for window functions, including all the standard functions plus additional features like custom window frames and complex aggregations.

#### Syntax:
```sql
SELECT
    column1,
    window_function() OVER (
        PARTITION BY partition_column
        ORDER BY order_column
        [ROWS or RANGE frame_start [frame_exclusion]]
    )
FROM table_name;
```

- **PARTITION BY**: Divides the result set into partitions to which the window function is applied.
- **ORDER BY**: Defines the logical order of the rows within each partition.
- **ROWS or RANGE**: Defines the window frame, which specifies the set of rows considered by the window function.
- **frame_start**: Specifies the starting point of the window frame (e.g., `UNBOUNDED PRECEDING`, `CURRENT ROW`, `n PRECEDING`, `n FOLLOWING`).
- **frame_exclusion**: Excludes certain rows from the window frame (e.g., `EXCLUDE CURRENT ROW`, `EXCLUDE GROUP`, `EXCLUDE TIES`, `EXCLUDE NO OTHERS`).

#### Examples:

1. **Running Total**:
   ```sql
   SELECT
       employee_id,
       salary,
       SUM(salary) OVER (ORDER BY employee_id) AS running_total
   FROM employees;
   ```

2. **Moving Average**:
   ```sql
   SELECT
       date,
       value,
       AVG(value) OVER (ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
   FROM stock_prices;
   ```

3. **Ranking**:
   ```sql
   SELECT
       employee_id,
       salary,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
   FROM employees;
   ```

4. **Custom Window Frame**:
   ```sql
   SELECT
       date,
       value,
       AVG(value) OVER (ORDER BY date RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW) AS weekly_avg
   FROM sensor_data;
   ```

5. **Complex Aggregation with Frame Exclusion**:
   ```sql
   SELECT
       date,
       value,
       SUM(value) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING EXCLUDE CURRENT ROW) AS cumulative_sum
   FROM transactions;
   ```

### Key Features of PostgreSQL Window Functions:

1. **Custom Window Frames**:
   - Allows you to define custom window frames using `ROWS` or `RANGE` with various frame start and end options.
   - Supports frame exclusions to exclude certain rows from the window frame.

2. **Complex Aggregations**:
   - Supports a wide range of aggregate functions and allows for complex aggregations over custom window frames.
   - Allows nesting of window functions and combining them with other SQL features.

3. **Performance Optimizations**:
   - PostgreSQL's query planner is optimized to handle window functions efficiently, even with complex window frames and large datasets.

4. **Flexibility**:
   - Window functions can be used in `SELECT`, `INSERT`, `UPDATE`, and `DELETE` statements, providing flexibility in how and where they are applied.

### Conclusion:
PostgreSQL's extensive support for window functions, including custom window frames and complex aggregations, makes it a powerful tool for advanced data analysis and reporting. These features allow you to perform complex calculations and aggregations that go beyond the basic support provided by standard SQL, making PostgreSQL a versatile choice for applications requiring sophisticated data manipulation.
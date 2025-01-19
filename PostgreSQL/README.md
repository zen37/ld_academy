https://www.tutorialspoint.com/postgresql/index.htm


While PostgreSQL is highly compliant with the SQL standard, it includes several extensions and features that differ from standard SQL. Here are some key differences:

### 1. **Data Types**:
   - **Standard SQL**: Basic data types like `INTEGER`, `VARCHAR`, `DATE`, etc.
   - **PostgreSQL**: Additional data types like `SERIAL`, `JSON`, `JSONB`, `ARRAY`, `UUID`, `HSTORE`, `BYTEA`, and more.

### 2. **Constraints**:
   - **Standard SQL**: Supports `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, and `CHECK`.
   - **PostgreSQL**: Supports `EXCLUDE` constraints for more complex uniqueness requirements using the `btree_gist` and `btree_gin` extensions.

### 3. **Indexing**:
   - **Standard SQL**: Typically supports B-tree indexes.
   - **PostgreSQL**: Supports multiple indexing methods like B-tree, Hash, GiST, GIN, BRIN, and SP-GiST.

### 4. **Full-Text Search**:
   - **Standard SQL**: Limited or no support for full-text search.
   - **PostgreSQL**: Robust full-text search capabilities with functions like `to_tsvector`, `to_tsquery`, and `ts_rank`.

### 5. **JSON Support**:
   - **Standard SQL**: Limited or no support for JSON data.
   - **PostgreSQL**: Powerful JSON and JSONB data types with functions to manipulate and query JSON data.

### 6. **Window Functions**:
   - **Standard SQL**: Basic support for window functions.
   - **PostgreSQL**: Extensive support for window functions, including custom window frames and complex aggregations.

   

### 7. **Common Table Expressions (CTEs)**:
   - **Standard SQL**: Supports basic CTEs.
   - **PostgreSQL**: Supports recursive CTEs for hierarchical queries and more complex scenarios.

### 8. **Transaction Control**:
   - **Standard SQL**: Basic transaction control with `BEGIN`, `COMMIT`, and `ROLLBACK`.
   - **PostgreSQL**: Advanced transaction control with `SAVEPOINT` and nested transactions.

### 9. **Concurrency Control**:
   - **Standard SQL**: Typically uses locking mechanisms for concurrency control.
   - **PostgreSQL**: Uses Multi-Version Concurrency Control (MVCC) for efficient handling of concurrent transactions.

### 10. **Extensions**:
   - **Standard SQL**: No concept of extensions.
   - **PostgreSQL**: Highly extensible with a wide range of extensions like `PostGIS` for geographic objects, `pg_trgm` for text similarity, and more.

### 11. **Functions and Operators**:
   - **Standard SQL**: Basic set of functions and operators.
   - **PostgreSQL**: Rich set of built-in functions and operators, including custom functions and operators.

### 12. **Inheritance**:
   - **Standard SQL**: No support for table inheritance.
   - **PostgreSQL**: Supports table inheritance, allowing tables to inherit columns from parent tables.

### 13. **Rules and Triggers**:
   - **Standard SQL**: Basic support for triggers.
   - **PostgreSQL**: Advanced support for rules and triggers, allowing for complex event-driven behavior.

### 14. **Array Data Type**:
   - **Standard SQL**: No support for array data types.
   - **PostgreSQL**: Supports array data types, allowing columns to store arrays of values.

### 15. **Custom Aggregates**:
   - **Standard SQL**: Limited support for custom aggregates.
   - **PostgreSQL**: Allows creation of custom aggregate functions.

**Stored procedures** and **functions** in PostgreSQL share many similarities with those in other databases (like SQL Server, MySQL, or Oracle), but there are a few key differences in how PostgreSQL implements them:

1. **Functions vs. Procedures**  
   - PostgreSQL **functions** have been around longer; they can return a single value, a row, or an entire set (making them act like “table functions”), and they’re often used in SQL statements (e.g., `SELECT * FROM some_function(...)`).  
   - **Procedures** were introduced more recently (PostgreSQL 11). Unlike functions, procedures do not return values directly. Instead, they’re invoked with `CALL procedure_name(...)` and are typically used for actions or utility tasks (e.g., data loading, transaction control).

2. **Transaction Control**  
   - PostgreSQL **functions** must run within a transaction; you cannot start or end transactions inside a function.  
   - **Procedures** in PostgreSQL can manage transactions directly (e.g., use `BEGIN`, `COMMIT`, or `ROLLBACK` inside the procedure), which is more aligned with how Oracle, SQL Server, or MySQL stored procedures can handle transaction flow.

3. **Table Functions**  
   - PostgreSQL functions can return a result set directly (`RETURNS TABLE(...)` or `RETURNS SETOF ...`), which you can query in a `FROM` clause just like a physical table. This feature is not as common or is more restricted in some other databases (though Oracle has table functions and SQL Server has table-valued functions).

4. **Implementation Languages**  
   - PostgreSQL supports multiple languages for writing stored code (PL/pgSQL, PL/Python, PL/Perl, etc.). Other databases also allow multiple languages or T-SQL/PL-SQL style scripting, but the breadth and flexibility of PostgreSQL’s language support is often cited as a differentiator.

5. **Syntax & Invocation**  
   - In PostgreSQL, **functions** are typically invoked in queries (e.g., `SELECT my_function(...)`), whereas **procedures** use `CALL my_procedure(...)`.  
   - SQL Server’s stored procedures use `EXEC proc_name ...`; MySQL and Oracle also use `CALL proc_name(...)`, but with slightly different syntax and parameter handling.

Overall, PostgreSQL’s model is quite flexible—particularly because of its **table functions**—but if you’re coming from SQL Server, Oracle, or MySQL, you’ll find the main conceptual difference is that **functions** in PostgreSQL are much more tightly integrated into queries, and **procedures** are specifically for operations that may need transaction control or don’t produce a direct result set.

It may look a bit unusual if you’re used to other RDBMSes (like SQL Server or Oracle) where functions aren’t typically used in FROM clauses.
In PostgreSQL, this is perfectly normal, because table functions are first-class citizens and can appear in the FROM clause just as a physical table or subselect would.


### Conclusion:
PostgreSQL extends standard SQL with a rich set of features that enhance its functionality and flexibility. Understanding these differences can help you leverage PostgreSQL's capabilities to build more robust and efficient database applications.
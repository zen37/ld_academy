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



### Conclusion:
PostgreSQL extends standard SQL with a rich set of features that enhance its functionality and flexibility. Understanding these differences can help you leverage PostgreSQL's capabilities to build more robust and efficient database applications.
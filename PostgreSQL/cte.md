Common Table Expressions (CTEs) are a powerful feature in SQL that allow you to define temporary result sets that can be referenced within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. PostgreSQL extends the standard CTE functionality by supporting recursive CTEs, which are particularly useful for hierarchical queries and other complex scenarios.

### Standard CTEs:
In standard SQL, CTEs are defined using the `WITH` clause and can be used to simplify complex queries by breaking them down into smaller, more manageable parts.

#### Example:
```sql
WITH cte_name AS (
    SELECT column1, column2
    FROM table_name
    WHERE condition
)
SELECT column1, column2
FROM cte_name;
```

### Recursive CTEs in PostgreSQL:
PostgreSQL supports recursive CTEs, which allow you to perform recursive queries. This is particularly useful for hierarchical data, such as organizational charts, bill of materials, or graph traversal.

#### Syntax:
```sql
WITH RECURSIVE cte_name AS (
    initial_query
    UNION [ALL]
    recursive_query
)
SELECT column1, column2
FROM cte_name;
```

- **initial_query**: The base query that defines the initial set of rows.
- **recursive_query**: The query that references the CTE itself, allowing for recursion.

#### Example: Hierarchical Data (Organizational Chart):
Suppose you have a table `employees` with the following structure:
```sql
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT
);
```

To retrieve the hierarchy of employees under a specific manager, you can use a recursive CTE:
```sql
WITH RECURSIVE employee_hierarchy AS (
    -- Initial query: Select the root manager
    SELECT employee_id, employee_name, manager_id
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive query: Select employees managed by the current level
    SELECT e.employee_id, e.employee_name, e.manager_id
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT employee_id, employee_name, manager_id
FROM employee_hierarchy;
```

### Explanation:
1. **Initial Query**: Selects the root manager (the employee with no manager).
2. **Recursive Query**: Joins the `employees` table with the CTE itself to select employees managed by the current level of employees.
3. **UNION ALL**: Combines the results of the initial query and the recursive query.

### Another Example: Graph Traversal:
Suppose you have a table `edges` representing a graph:
```sql
CREATE TABLE edges (
    node_id INT,
    connected_node_id INT
);
```

To find all nodes reachable from a specific starting node, you can use a recursive CTE:
```sql
WITH RECURSIVE graph_traversal AS (
    -- Initial query: Select the starting node
    SELECT node_id, connected_node_id
    FROM edges
    WHERE node_id = 1

    UNION ALL

    -- Recursive query: Select nodes connected to the current level
    SELECT e.node_id, e.connected_node_id
    FROM edges e
    INNER JOIN graph_traversal gt ON e.node_id = gt.connected_node_id
)
SELECT DISTINCT connected_node_id
FROM graph_traversal;
```

### Explanation:
1. **Initial Query**: Selects the starting node.
2. **Recursive Query**: Joins the `edges` table with the CTE itself to select nodes connected to the current level of nodes.
3. **UNION ALL**: Combines the results of the initial query and the recursive query.

### Conclusion:
Recursive CTEs in PostgreSQL provide a powerful way to handle hierarchical data and complex queries that involve recursion. They extend the standard CTE functionality by allowing you to perform recursive operations, making it easier to work with data structures like trees and graphs.
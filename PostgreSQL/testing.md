Yes, that’s true. **Unit tests typically use a known, controlled data set**, so you already know what the “expected” rows should be. If your production database changes constantly, you’d either:

1. **Use a test fixture** (a temporary or dedicated schema/table) seeded with predictable data, so you can anticipate the function’s output in advance.  
2. **Run the tests in a separate environment** (e.g., a CI pipeline or dev database) where the data is stable and purposely set up for testing.  

### Common Approaches

1. **Static Test Data**  
   - You insert a small, well-defined data set into your test environment.  
   - The test script knows exactly what rows the function should return (like `(1, 'Project A', 3)` etc.).  
   - Then you compare the function’s result to that expected set.

2. **pgTAP with a Known Fixture**  
   - You can combine **pgTAP** with a fixture script that populates your test tables with sample rows before the tests run.  
   - The function under test runs against this fixed data.  
   - Your assertions check exact rows or row counts.

3. **In-Memory Tests / Ephemeral Database**  
   - Some CI systems spin up a temporary PostgreSQL instance for each test run.  
   - Your test suite seeds it with data, runs the function tests, and tears it down afterward.  
   - This ensures each run starts from the same baseline data.

### If You Can’t Use Static Data
- **Integration tests** may need to handle dynamic data. In that case, you might check for more general conditions (e.g., “at least one row has X,” or “the row count is greater than 2”) rather than exact row matches.  
- But strict unit tests, by definition, usually assume **a controlled data fixture** so you can do exact comparisons.

---

**In short**, if you want to compare the function’s output to an exact set of rows, you need predictable data (and thus “know in advance what the results should be”). That’s a normal part of writing unit tests for database code.
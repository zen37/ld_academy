
## W3 Schools

### Aggregate Function

An aggregate function is a function that performs a calculation on a set of values, and returns a single value.
Usage

Aggregate functions are often used with the GROUP BY clause of the SELECT statement.

The GROUP BY clause splits the result-set into groups of values and the aggregate function can be used to return a single value for each group.

### Common Aggregate Functions

The most commonly used SQL aggregate functions are:

MIN(): returns the smallest value within the selected column

MAX(): returns the largest value within the selected column

COUNT(): returns the number of rows in a set

SUM(): returns the total sum of a numerical column

AVG(): returns the average value of a numerical column


Aggregate functions ignore null values (except for COUNT()).

https://www.w3schools.com/sql/sql_aggregate_functions.asp

# DBMS Documentation

[Aggregate Functions PostgreSQL](https://www.postgresql.org/docs/current/functions-aggregate.html)

[Aggregate Functions (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/functions/aggregate-functions-transact-sql?view=sql-server-ver16)


## Meta AI

Here is the corrected list of aggregate functions:

Other Aggregate Functions:

VARIANCE (Oracle, PostgreSQL, SQL Server) - returns the variance

STDDEV (Oracle, PostgreSQL, SQL Server) - returns the standard deviation

LISTAGG (Oracle, PostgreSQL) - returns a concatenated string

ARRAY_AGG (PostgreSQL) - returns an array of values

STRING_AGG (SQL Server, PostgreSQL) - returns a concatenated string

GROUP_CONCAT (MySQL) - returns a concatenated string

PERCENTILE_CONT (Oracle, PostgreSQL) - returns a percentile value

PERCENTILE_DISC (Oracle, PostgreSQL) - returns a percentile value

MEDIAN (PostgreSQL, Oracle) - returns the median value

MODE (PostgreSQL, Oracle, SQL Server, IBM DB2) - returns the most frequently occurring value

Note that this list might not be exhaustive, as different database management systems may support additional aggregate functions.


## Chat GPT

Here are the corrections:

1. **VARIANCE**:  
   Add **MySQL** (from version 8.0).  
   Corrected: `VARIANCE (Oracle, PostgreSQL, SQL Server, MySQL)`

2. **STDDEV**:  
   Add **MySQL** (from version 8.0).  
   Corrected: `STDDEV (Oracle, PostgreSQL, SQL Server, MySQL)`

3. **LISTAGG**:  
   Remove **PostgreSQL**, as it is not supported natively.  
   Corrected: `LISTAGG (Oracle) - returns a concatenated string`

4. **ARRAY_AGG**:  
   Add **MySQL** (from version 8.0).  
   Corrected: `ARRAY_AGG (PostgreSQL, MySQL)`

5. **MODE**:  
   Remove **SQL Server**, as it does not support `MODE` natively.  
   Corrected: `MODE (PostgreSQL, Oracle, IBM DB2) - returns the most frequently occurring value`
# Study for SQL
-- Normalization
-- 1st nf
    -- Atomic values, Unique Columns, No Reapting groups
-- 2nd nf
    -- attributes dependent on the primary key
-- 3rd nf
    -- no transitive dependiencies, 
        (dependent on something other than the primary key)
-- ACID
    Atomicity <fails unless everything goes thorugh>
    Consistancy <must remain in a valid state>
    Isolation <multiple transactions cant happen at once>
    Durability <written to disk>
-- Sub Query (WHERE)
    SELECT employee_name FROM employees 
    WHERE department_id= (
    SELECT department_id FROM departments
    Where department_name = 'sales')
-- Joins 
    SELECT columns FROM table1
    INNER JOIN table2 ON table1.column_name = table2.column_name
-- GROUP BY (with aggregate functions)
    SELECT product_id, SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY product_id
-- aggregate functions
    COUNT, SUM, AVG, MIN, MAX
-- INDEXES
    B-tree (balanced tree)
        CREATE INDEX index_name
        ON table_name (columns)
-- VIEW vs TABLE
    Virtual vs physical
    read/only vs read/write
    CREATE VIEW view_name AS name
    SELECT column1, column2 FROM table_name
    WHERE condition
-- TABLE
    CREATE TABLE employees (
        employee_id INT PRIMARY KEY,
        first_name VARCHAR(50))
    INSERT,UPDATE,DELETE,MERGE
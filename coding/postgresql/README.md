# Postgresql

    brew install pgcli
    brew install libpq
    sudo ln -s $(brew --prefix)/opt/libpq/bin/psql /usr/local/bin/psql

## Postgresql performance
1. **EXPLAIN and EXPLAIN ANALYZE**:
    - These commands help you understand how PostgreSQL executes a query and where it might be spending most of its time.
    - `EXPLAIN` provides the execution plan without running the query.
    - `EXPLAIN ANALYZE` runs the query and provides the execution plan along with actual run times.

    ```
    EXPLAIN ANALYZE SELECT * FROM your_table WHERE condition;
    ```
2. **VACUUM and VACUUM ANALYZE**:
    - These commands help in cleaning up dead tuples and updating statistics used by the query planner.
    - `VACUUM` reclaims storage occupied by dead tuples.
    - `VACUUM ANALYZE` also updates statistics.

    ```VACUUM ANALYZE your_table;```    

3. **Auto-Tuning Tools**:
    - Tools like `pg_tune` can help generate configuration settings optimized for your hardware and workload.
4. **pgAdmin**:
    - A graphical tool that provides a user-friendly interface for managing PostgreSQL databases, including performance analysis and tuning.
5. **Logging and Monitoring**:
    - Enable logging of slow queries and use monitoring tools like `pgBadger` to analyze the logs.
6. **Indexes**:
    - Ensure that appropriate indexes are created for frequently queried columns.
    - Make sure configure `lock_timeout` and `concurrently`

    ```
    SET lock_timeout = '5s';
    CREATE INDEX concurrently idx_your_column ON your_table(your_column);
    ```

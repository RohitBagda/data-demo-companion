-- Customers with most unique events
-- EXPLAIN PLAN FOR
SELECT
    customerId,
    DISTINCT_COUNT_HLL(eventid) as distinct_count
FROM foo
GROUP BY customerId
ORDER BY distinct_count DESC;
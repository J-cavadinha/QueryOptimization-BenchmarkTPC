EXPLAIN ANALYZE
SELECT l_orderkey,
    SUM(l_extendedprice * (1 - l_discount)) AS revenue,
    o_orderdate,
    o_shippriority
FROM CUSTOMER,
    ORDERS,
    LINEITEM
WHERE c_mktsegment = 'BUILDING' -- Segmento de exemplo
    AND c_custkey = o_custkey
    AND l_orderkey = o_orderkey
    AND o_orderdate < DATE '1995-03-15' -- Data de exemplo
    AND l_shipdate > DATE '1995-03-15' -- Data de exemplo
GROUP BY l_orderkey,
    o_orderdate,
    o_shippriority
ORDER BY revenue DESC,
    o_orderdate
LIMIT 10;
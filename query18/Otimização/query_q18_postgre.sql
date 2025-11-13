CREATE INDEX idx_orders_custkey ON orders(o_custkey);
CREATE INDEX idx_lineitem_orderkey ON lineitem(l_orderkey);
CREATE INDEX idx_lineitem_quantity ON lineitem(l_quantity);

EXPLAIN ANALYZE
SELECT
    c.c_name,
    c.c_custkey,
    o.o_orderkey,
    o.o_orderdate,
    o.o_totalprice,
    SUM(l.l_quantity) AS total_quantity
FROM
    customer c
    JOIN orders o ON c.c_custkey = o.o_custkey
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    JOIN (
        SELECT l_orderkey
        FROM lineitem
        GROUP BY l_orderkey
        HAVING SUM(l_quantity) > 300
    ) big_orders ON big_orders.l_orderkey = o.o_orderkey
GROUP BY
    c.c_name,
    c.c_custkey,
    o.o_orderkey,
    o.o_orderdate,
    o.o_totalprice
ORDER BY
    o.o_totalprice DESC, o.o_orderdate;


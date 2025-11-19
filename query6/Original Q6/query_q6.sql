EXPLAIN ANALYZE
SELECT SUM(l_extendedprice * l_discount) AS revenue
FROM LINEITEM
WHERE l_shipdate >= DATE '1994-01-01' -- Filtro 1 (Data)
    AND l_shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
    AND l_discount BETWEEN 0.06 - 0.01 AND 0.06 + 0.01 -- Filtro 2 (Numérico)
    AND l_quantity < 24;
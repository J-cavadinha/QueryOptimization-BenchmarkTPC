CREATE INDEX idx_orders_orderdate_orderkey ON orders (o_orderdate, o_orderkey)

EXPLAIN ANALYZE
select
    n.n_name as nation,
    extract(year from o.o_orderdate) as o_year,
    sum(l.l_extendedprice * (1 - l.l_discount) - ps.ps_supplycost * l.l_quantity) as sum_profit
from
    part p
join partsupp ps   on ps.ps_partkey = p.p_partkey
join supplier s    on s.s_suppkey = ps.ps_suppkey
join nation n      on n.n_nationkey = s.s_nationkey
join lineitem l    on l.l_partkey = p.p_partkey
                   and l.l_suppkey = s.s_suppkey
join orders o      on o.o_orderkey = l.l_orderkey
where
    p.p_name like '%green%'
group by
    nation, o_year
order by
    nation, o_year desc;

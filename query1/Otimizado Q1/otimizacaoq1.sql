CREATE INDEX idx_q1_covering ON LINEITEM (
    l_shipdate,
    l_returnflag,
    l_linestatus,
    l_quantity,
    l_extendedprice,
    l_discount,
    l_tax
);
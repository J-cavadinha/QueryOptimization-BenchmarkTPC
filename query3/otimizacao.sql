-- Índices para Q3 (Válido para PostgreSQL e MySQL)
-- 1. Ajuda a filtrar os clientes (ponto de partida)
CREATE INDEX idx_cust_segment ON CUSTOMER (c_mktsegment);
-- 2. Índice Composto: acelera o JOIN de CUSTOMER com ORDERS
-- E otimiza o filtro de data (o_orderdate)
CREATE INDEX idx_orders_cust_date ON ORDERS (o_custkey, o_orderdate);
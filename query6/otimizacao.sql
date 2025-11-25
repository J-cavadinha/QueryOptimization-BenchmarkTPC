-- Índice de Cobertura para Q6 (Válido para PostgreSQL e MySQL)
-- Ordem: Colunas de filtro (shipdate, discount, quantity) + Coluna de cálculo (extendedprice)
CREATE INDEX idx_q6_super_covering ON LINEITEM (
    l_shipdate,
    l_discount,
    l_quantity,
    l_extendedprice
);
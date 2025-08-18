
USE loja_carros;

-- [nota pessoal] 1) Inventário disponível (com marca e modelo)
SELECT v.id_veiculo, b.nome AS tb_marcas, m.nome AS tb_modelos, v.ano, v.cor, v.preco
FROM tb_veiculos v
JOIN tb_modelos m ON m.id_modelo = v.id_modelo
JOIN tb_marcas b ON b.id_marca = m.id_marca
WHERE v.status = 'estoque'
ORDER BY tb_marcas, tb_modelos, v.ano DESC;

-- [nota pessoal] 2) Top marcas por volume de vendas no ano atual
SELECT b.nome AS tb_marcas, COUNT(*) AS total_vendido
FROM tb_vendas s
JOIN tb_veiculos v ON v.id_veiculo = s.id_veiculo
JOIN tb_modelos m ON m.id_modelo = v.id_modelo
JOIN tb_marcas b ON b.id_marca = m.id_marca
WHERE YEAR(s.data_venda) = YEAR(CURDATE())
GROUP BY b.nome
ORDER BY total_vendido DESC, b.nome;

-- [nota pessoal] 3) Faturamento mensal no ano atual
SELECT DATE_FORMAT(data_venda, '%Y-%m') AS mes, SUM(valor_total) AS faturamento
FROM tb_vendas
WHERE YEAR(data_venda) = YEAR(CURDATE())
GROUP BY DATE_FORMAT(data_venda, '%Y-%m')
ORDER BY mes;

-- [nota pessoal] 4) Desconto médio por vendedor
SELECT sp.nome AS vendedor, AVG(s.desconto) AS desconto_medio, COUNT(*) AS qtd_vendas
FROM tb_vendas s
JOIN tb_vendedores sp ON sp.id_vendedor = s.id_vendedor
GROUP BY sp.nome
ORDER BY desconto_medio DESC;

-- [nota pessoal] 5) Detalhe de venda (com acessórios do veículo)
SELECT s.id_venda, c.nome AS cliente, sp.nome AS vendedor, b.nome AS marca, m.nome AS modelo,
       v.chassi, s.data_venda, s.valor_total,
       GROUP_CONCAT(a.nome ORDER BY a.nome SEPARATOR ', ') AS acessorios
FROM tb_vendas s
JOIN tb_clientes c ON c.id_cliente = s.id_cliente
JOIN tb_vendedores sp ON sp.id_vendedor = s.id_vendedor
JOIN tb_veiculos v ON v.id_veiculo = s.id_veiculo
JOIN tb_modelos m ON m.id_modelo = v.id_modelo
JOIN tb_marcas b ON b.id_marca = m.id_marca
LEFT JOIN tb_veiculo_acessorio va ON va.id_veiculo = v.id_veiculo
LEFT JOIN tb_acessorios a ON a.id_acessorio = va.id_acessorio
GROUP BY s.id_venda, c.nome, sp.nome, b.nome, m.nome, v.chassi, s.data_venda, s.valor_total
ORDER BY s.data_venda DESC;

-- [nota pessoal] 6) Parcelas em atraso (vencidas e não pagas)
SELECT p.id_pagamento, p.id_venda, p.num_parcela, p.valor, p.data_vencimento, DATEDIFF(CURDATE(), p.data_vencimento) AS dias_atraso
FROM tb_pagamentos p
WHERE p.data_pagamento IS NULL AND p.data_vencimento < CURDATE()
ORDER BY dias_atraso DESC;

-- [nota pessoal] 7) Veículos encalhados (em estoque há +90 dias)
SELECT v.id_veiculo, b.nome AS tb_marcas, m.nome AS tb_modelos, v.data_compra, v.preco
FROM tb_veiculos v
JOIN tb_modelos m ON m.id_modelo = v.id_modelo
JOIN tb_marcas b ON b.id_marca = m.id_marca
WHERE v.status = 'estoque' AND DATEDIFF(CURDATE(), v.data_compra) > 90
ORDER BY v.data_compra;

-- [nota pessoal] 8) Ticket médio por cliente
SELECT c.nome AS cliente, AVG(s.valor_total) AS ticket_medio, COUNT(*) AS compras
FROM tb_vendas s
JOIN tb_clientes c ON c.id_cliente = s.id_cliente
GROUP BY c.nome
ORDER BY ticket_medio DESC;

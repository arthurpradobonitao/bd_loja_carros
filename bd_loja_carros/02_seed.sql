
USE loja_carros;

-- [nota pessoal] Marcas
INSERT INTO tb_marcas (nome) VALUES
('Ford'), ('Chevrolet'), ('Toyota');

-- [nota pessoal] Modelos
INSERT INTO tb_modelos (id_marca, nome, ano_lancamento) VALUES
(1, 'Mustang', 1964),
(1, 'Fiesta', 1976),
(2, 'Onix', 2012),
(2, 'S10', 1995),
(3, 'Corolla', 1966),
(3, 'Hilux', 1968);

-- [nota pessoal] Clientes
INSERT INTO tb_clientes (nome, cpf, email, telefone) VALUES
('Ana Silva', '11122233344', 'ana@email.com', '41999990001'),
('Bruno Souza', '22233344455', 'bruno@email.com', '41999990002'),
('Carla Nunes', '33344455566', 'carla@email.com', '41999990003');

-- [nota pessoal] Vendedores
INSERT INTO tb_vendedores (nome, cpf, email, telefone, hire_date) VALUES
('Diego Ramos', '44455566677', 'diego@email.com', '41999990010', '2022-03-01'),
('Elaine Costa', '55566677788', 'elaine@email.com', '41999990011', '2023-01-10');

-- [nota pessoal] Acessórios
INSERT INTO tb_acessorios (nome, preco) VALUES
('Som Premium', 2500.00),
('Película', 600.00),
('Roda Liga Leve', 3500.00),
('Banco de Couro', 4200.00);

-- [nota pessoal] Veículos em estoque
INSERT INTO tb_veiculos (id_modelo, chassi, ano, cor, data_compra, custo_compra, preco, status) VALUES
(1, '1FA6P8CF0F1234567', 2020, 'Preto', '2025-05-10', 180000.00, 210000.00, 'estoque'),
(3, '9BGKS48U05C123456', 2022, 'Branco', '2025-05-15', 65000.00, 78000.00, 'estoque'),
(5, 'JTDBR32E330123456', 2021, 'Prata', '2025-06-02', 90000.00, 105000.00, 'estoque'),
(6, 'MR0CX3CD401234567', 2023, 'Vermelho', '2025-06-20', 160000.00, 189000.00, 'estoque');

-- [nota pessoal] Atribuir acessórios aos veículos
INSERT INTO tb_veiculo_acessorio (id_veiculo, id_acessorio) VALUES
(1,1), (1,3), (2,2), (3,4), (4,1), (4,2), (4,3);

-- [nota pessoal] Registrar uma venda
-- [nota pessoal] Vender o veículo 2 (Onix) para o cliente 1 com vendedor 2
INSERT INTO tb_vendas (id_veiculo, id_cliente, id_vendedor, data_venda, desconto, valor_total)
VALUES (2, 1, 2, '2025-07-01', 1000.00, 77000.00);

-- [nota pessoal] Parcelas dessa venda (3x)
INSERT INTO tb_pagamentos (id_venda, num_parcela, valor, data_vencimento, data_pagamento) VALUES
(LAST_INSERT_ID(), 1, 25666.67, '2025-08-01', '2025-08-01'),
(LAST_INSERT_ID(), 2, 25666.67, '2025-09-01', NULL),
(LAST_INSERT_ID(), 3, 25666.66, '2025-10-01', NULL);

-- [nota pessoal] Atualizar status do veículo vendido
UPDATE tb_veiculos SET status = 'vendido' WHERE id_veiculo = 2;

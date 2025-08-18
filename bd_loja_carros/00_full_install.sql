
DROP DATABASE IF EXISTS loja_carros;
CREATE DATABASE loja_carros
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;
USE loja_carros;

-- [nota pessoal] Tabela de Marcas
CREATE TABLE tb_marcas (
  id_marca INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- [nota pessoal] Tabela de Modelos
CREATE TABLE tb_modelos (
  id_modelo INT AUTO_INCREMENT PRIMARY KEY,
  id_marca INT NOT NULL,
  nome VARCHAR(80) NOT NULL,
  ano_lancamento YEAR NULL,
  CONSTRAINT uq_model_brand_name UNIQUE (id_marca, nome),
  CONSTRAINT fk_model_brand FOREIGN KEY (id_marca) REFERENCES tb_marcas(id_marca)
) ENGINE=InnoDB;

-- [nota pessoal] Tabela de Veículos
CREATE TABLE tb_veiculos (
  id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
  id_modelo INT NOT NULL,
  chassi CHAR(17) NOT NULL UNIQUE,
  ano YEAR NOT NULL,
  cor VARCHAR(30) NOT NULL,
  data_compra DATE NOT NULL,
  custo_compra DECIMAL(12,2) NOT NULL,
  preco DECIMAL(12,2) NOT NULL,
  status ENUM('estoque','reservado','vendido') NOT NULL DEFAULT 'estoque',
  CONSTRAINT fk_vehicle_model FOREIGN KEY (id_modelo) REFERENCES tb_modelos(id_modelo)
) ENGINE=InnoDB;

-- [nota pessoal] Tabela de Clientes
CREATE TABLE tb_clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  cpf CHAR(11) NOT NULL UNIQUE,
  email VARCHAR(120),
  telefone VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- [nota pessoal] Tabela de Vendedores
CREATE TABLE tb_vendedores (
  id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  cpf CHAR(11) NOT NULL UNIQUE,
  email VARCHAR(120),
  telefone VARCHAR(20),
  hire_date DATE NOT NULL
) ENGINE=InnoDB;

-- [nota pessoal] Tabela de Vendas
CREATE TABLE tb_vendas (
  id_venda INT AUTO_INCREMENT PRIMARY KEY,
  id_veiculo INT NOT NULL UNIQUE, -- [nota pessoal] um veículo só pode ser vendido uma vez
  id_cliente INT NOT NULL,
  id_vendedor INT NOT NULL,
  data_venda DATE NOT NULL,
  desconto DECIMAL(12,2) NOT NULL DEFAULT 0,
  valor_total DECIMAL(12,2) NOT NULL,
  CONSTRAINT fk_sale_vehicle FOREIGN KEY (id_veiculo) REFERENCES tb_veiculos(id_veiculo),
  CONSTRAINT fk_sale_customer FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente),
  CONSTRAINT fk_sale_salesperson FOREIGN KEY (id_vendedor) REFERENCES tb_vendedores(id_vendedor)
) ENGINE=InnoDB;

-- [nota pessoal] Tabela de Pagamentos (parcelas)
CREATE TABLE tb_pagamentos (
  id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
  id_venda INT NOT NULL,
  num_parcela INT NOT NULL,
  valor DECIMAL(12,2) NOT NULL,
  data_vencimento DATE NOT NULL,
  data_pagamento DATE NULL,
  CONSTRAINT fk_payment_sale FOREIGN KEY (id_venda) REFERENCES tb_vendas(id_venda),
  CONSTRAINT uq_payment_installment UNIQUE (id_venda, num_parcela)
) ENGINE=InnoDB;

-- [nota pessoal] Tabela de Acessórios
CREATE TABLE tb_acessorios (
  id_acessorio INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE,
  preco DECIMAL(12,2) NOT NULL
) ENGINE=InnoDB;

-- [nota pessoal] Tabela de Associação Veículo x Acessório (N:N)
CREATE TABLE tb_veiculo_acessorio (
  id_veiculo INT NOT NULL,
  id_acessorio INT NOT NULL,
  PRIMARY KEY (id_veiculo, id_acessorio),
  CONSTRAINT fk_va_vehicle FOREIGN KEY (id_veiculo) REFERENCES tb_veiculos(id_veiculo),
  CONSTRAINT fk_va_accessory FOREIGN KEY (id_acessorio) REFERENCES tb_acessorios(id_acessorio)
) ENGINE=InnoDB;

-- [nota pessoal] 02_seed.sql — DML (dados de exemplo)
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

-- [nota pessoal] 03_queries.sql — Consultas úteis
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


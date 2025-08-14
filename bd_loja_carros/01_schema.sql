-- [nota pessoal] Projeto Loja de Carros - Versão adaptada por Luiz
-- [nota pessoal] 01_schema.sql — DDL
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
